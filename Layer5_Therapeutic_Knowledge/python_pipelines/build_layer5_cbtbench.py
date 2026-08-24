import json
import sys
import os
from neo4j import GraphDatabase

sys.stdout.reconfigure(encoding='utf-8')

NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "psychotherapy123"

DATASET_PATH = r"d:\Psyco Therapy\Layer5_Therapeutic_Knowledge\datasets\CBT_Bench\distortions_seed_train.json"

def process_cbtbench():
    if not os.path.exists(DATASET_PATH):
        print(f"Error: Dataset not found at {DATASET_PATH}")
        return

    print("Connecting to Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    
    print(f"Reading dataset from {DATASET_PATH}...")
    records = []
    with open(DATASET_PATH, 'r', encoding='utf-8') as f:
        for line in f:
            if line.strip():
                try:
                    data = json.loads(line)
                    # We take up to 1000 for this phase
                    if len(records) < 1000:
                        records.append(data)
                except json.JSONDecodeError:
                    continue

    print(f"Loaded {len(records)} records. Inserting into Neo4j (Layer 5/6)...")

    query = """
    UNWIND $batch AS record
    
    // Create Session/Scenario Node
    MERGE (s:Session {session_id: 'cbtbench_' + toString(record.id)})
    ON CREATE SET 
        s.patient_utterance = record.situation + ' ' + record.thoughts,
        s.source = "CBT_Bench",
        s.date_added = date()
        
    // Create CognitivePattern nodes and link
    WITH s, record
    UNWIND record.distortions AS dist
    MERGE (cp:CognitivePattern {name: toLower(dist)})
    ON CREATE SET 
        cp.source = "CBT_Bench", 
        cp.confidence = 1.0, 
        cp.date_added = date()
    MERGE (s)-[:EXPRESSED]->(cp)
    
    // Attempt to link CognitivePattern to a TherapeuticModality (CBT)
    WITH cp
    MATCH (m:TherapeuticModality {name: "CBT"})
    MERGE (cp)-[:ADDRESSED_BY]->(m)
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
        result = session.run("MATCH (cp:CognitivePattern) RETURN count(cp) AS total")
        print(f"\nSuccess! Total CognitivePattern nodes: {result.single()['total']}")
        
        result_links = session.run("MATCH (s:Session)-[r:EXPRESSED]->(cp:CognitivePattern) RETURN count(r) AS total")
        print(f"Total connections from Sessions to Cognitive Patterns: {result_links.single()['total']}")

    driver.close()

if __name__ == "__main__":
    process_cbtbench()
