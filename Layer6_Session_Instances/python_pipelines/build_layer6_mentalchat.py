import json
import sys
import os
from neo4j import GraphDatabase

sys.stdout.reconfigure(encoding='utf-8')

NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "psychotherapy123"

DATASET_PATH = r"d:\Psyco Therapy\Layer6_Session_Instances\datasets\MentalChat16K\train.json"

def process_mentalchat():
    if not os.path.exists(DATASET_PATH):
        print(f"Error: Dataset not found at {DATASET_PATH}")
        return

    print("Connecting to Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    
    print(f"Reading dataset from {DATASET_PATH}...")
    records = []
    with open(DATASET_PATH, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f):
            if line.strip():
                try:
                    data = json.loads(line)
                    # Add an ID since the dataset doesn't have one
                    data['id'] = i
                    # Take 1000 records for the initial graph build
                    if len(records) < 1000:
                        records.append(data)
                except json.JSONDecodeError:
                    continue

    print(f"Loaded {len(records)} records. Inserting into Neo4j (Layer 6)...")

    # We match keywords in the input text to link to Clinical knowledge
    # For a real pipeline, an NER or LLM step would happen here before Neo4j insertion
    query = """
    UNWIND $batch AS record
    
    // Create Session Node
    MERGE (s:Session {session_id: 'mentalchat_' + toString(record.id)})
    ON CREATE SET 
        s.patient_utterance = record.input,
        s.therapist_utterance = record.output,
        s.source = "MentalChat16K",
        s.date_added = date()
        
    // Dynamically link to Disorders based on keyword in patient utterance
    WITH s, toLower(record.input) AS input_text
    MATCH (d:Disorder)
    WHERE input_text CONTAINS toLower(d.name)
    MERGE (s)-[:EXPRESSED]->(d)
    
    // Dynamically link to Symptoms
    WITH s, input_text
    MATCH (sym:Symptom)
    WHERE input_text CONTAINS toLower(sym.name)
    MERGE (s)-[:EXPRESSED]->(sym)
    
    // Dynamically link to Emotions
    WITH s, input_text
    MATCH (e:EmotionalState)
    WHERE input_text CONTAINS toLower(e.name)
    MERGE (s)-[:EXPRESSED]->(e)
    """

    batch_size = 100
    total_inserted = 0
    with driver.session(database="neo4j") as session:
        for i in range(0, len(records), batch_size):
            batch = records[i:i+batch_size]
            session.run(query, batch=batch)
            total_inserted += len(batch)
            print(f"Inserted {total_inserted}/{len(records)} records...")

    with driver.session(database="neo4j") as session:
        result = session.run("MATCH (s:Session {source: 'MentalChat16K'}) RETURN count(s) AS total")
        print(f"\nSuccess! Total MentalChat16K Sessions: {result.single()['total']}")
        
        result_links = session.run("MATCH (s:Session {source: 'MentalChat16K'})-[r:EXPRESSED]->(n) RETURN count(r) AS total")
        print(f"Total connections from MentalChat16K Sessions to Clinical Knowledge: {result_links.single()['total']}")

    driver.close()

if __name__ == "__main__":
    process_mentalchat()
