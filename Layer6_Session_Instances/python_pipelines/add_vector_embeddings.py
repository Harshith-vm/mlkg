import sys
from neo4j import GraphDatabase
import numpy as np

# Suppress warnings
import warnings
warnings.filterwarnings('ignore')

sys.stdout.reconfigure(encoding='utf-8')

NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "psychotherapy123"

def main():
    print("Loading local Transformer model (all-MiniLM-L6-v2)...")
    try:
        from sentence_transformers import SentenceTransformer
        model = SentenceTransformer('all-MiniLM-L6-v2')
    except ImportError:
        print("Error: sentence-transformers not installed.")
        return

    print("Connecting to Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    
    # 1. Create Vector Indexes
    print("Creating Vector Indexes in Neo4j (if not exists)...")
    with driver.session(database="neo4j") as session:
        # For Neo4j 5.x
        try:
            session.run("""
            CREATE VECTOR INDEX symptom_embeddings IF NOT EXISTS 
            FOR (s:Symptom) ON (s.embedding)
            OPTIONS {indexConfig: {`vector.dimensions`: 384, `vector.similarity_function`: 'cosine'}}
            """)
            session.run("""
            CREATE VECTOR INDEX session_embeddings IF NOT EXISTS 
            FOR (s:Session) ON (s.embedding)
            OPTIONS {indexConfig: {`vector.dimensions`: 384, `vector.similarity_function`: 'cosine'}}
            """)
        except Exception as e:
            print(f"Warning on index creation: {e}")

    # 2. Embed Symptoms
    print("Fetching Symptom nodes...")
    with driver.session(database="neo4j") as session:
        result = session.run("MATCH (s:Symptom) RETURN elementId(s) as id, s.name as name")
        symptoms = [{"id": r["id"], "text": r["name"]} for r in result]
    
    print(f"Generating embeddings for {len(symptoms)} Symptoms...")
    texts = [s["text"] for s in symptoms]
    embeddings = model.encode(texts, convert_to_numpy=True)
    
    print("Writing Symptom embeddings to Neo4j...")
    update_query = """
    UNWIND $batch AS row
    MATCH (s:Symptom) WHERE elementId(s) = row.id
    CALL db.create.setNodeVectorProperty(s, 'embedding', row.embedding)
    """
    # Note: For Neo4j 5, you can just do SET s.embedding = row.embedding if it's a list of floats.
    # We will use standard SET for wider compatibility, but ensure it's a list of Python floats.
    update_query_standard = """
    UNWIND $batch AS row
    MATCH (s:Symptom) WHERE elementId(s) = row.id
    SET s.embedding = row.embedding
    """
    
    batch = [{"id": sym["id"], "embedding": emb.tolist()} for sym, emb in zip(symptoms, embeddings)]
    with driver.session(database="neo4j") as session:
        session.run(update_query_standard, batch=batch)

    # 3. Embed Sessions (Limit to 500 for speed)
    print("Fetching Session nodes (Max 500)...")
    with driver.session(database="neo4j") as session:
        result = session.run("MATCH (s:Session) WHERE s.patient_utterance IS NOT NULL RETURN elementId(s) as id, s.patient_utterance as text LIMIT 500")
        sessions = [{"id": r["id"], "text": r["text"]} for r in result]
    
    print(f"Generating embeddings for {len(sessions)} Sessions...")
    texts = [s["text"] for s in sessions]
    embeddings = model.encode(texts, convert_to_numpy=True)
    
    print("Writing Session embeddings to Neo4j...")
    update_session_query = """
    UNWIND $batch AS row
    MATCH (s:Session) WHERE elementId(s) = row.id
    SET s.embedding = row.embedding
    """
    batch_sessions = [{"id": ses["id"], "embedding": emb.tolist()} for ses, emb in zip(sessions, embeddings)]
    
    # Batch execute
    batch_size = 100
    with driver.session(database="neo4j") as session:
        for i in range(0, len(batch_sessions), batch_size):
            session.run(update_session_query, batch=batch_sessions[i:i+batch_size])

    print("Success! Vector embeddings added to graph.")
    driver.close()

if __name__ == "__main__":
    main()
