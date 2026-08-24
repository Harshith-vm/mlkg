import sys
from neo4j import GraphDatabase
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

    # Simulate a messy user query that strict keyword matching would fail on
    user_query = "I feel like I'm drowning, my chest is tight and I can't catch my breath."
    print(f"\nUser Query: '{user_query}'")
    print("Generating query vector...")
    query_vector = model.encode(user_query, convert_to_numpy=True).tolist()

    print("Connecting to Neo4j and running Semantic Vector Search...\n")
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    
    with driver.session(database="neo4j") as session:
        # Search for similar Symptoms
        symptom_query = """
        CALL db.index.vector.queryNodes('symptom_embeddings', 3, $query_vector)
        YIELD node AS symptom, score
        RETURN symptom.name AS name, score
        """
        print("=== Top 3 Matched Clinical Symptoms ===")
        result = session.run(symptom_query, query_vector=query_vector)
        for r in result:
            print(f"[{r['score']:.4f}] {r['name']}")

        # Search for similar Sessions from the dataset
        session_query = """
        CALL db.index.vector.queryNodes('session_embeddings', 2, $query_vector)
        YIELD node AS session, score
        RETURN session.patient_utterance AS text, session.source AS source, score
        """
        print("\n=== Top 2 Similar Past Patient Sessions ===")
        result = session.run(session_query, query_vector=query_vector)
        for i, r in enumerate(result):
            text = r['text']
            # Truncate text for display
            display_text = text[:150] + "..." if len(text) > 150 else text
            print(f"[{r['score']:.4f}] ({r['source']}) {display_text}")

    driver.close()
    print("\nVector Search Complete!")

if __name__ == "__main__":
    main()
