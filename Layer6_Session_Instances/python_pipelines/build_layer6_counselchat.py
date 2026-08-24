import json
import sys
import os
from neo4j import GraphDatabase

sys.stdout.reconfigure(encoding='utf-8')

NEO4J_URI = "bolt://localhost:7687"
NEO4J_USER = "neo4j"
NEO4J_PASS = "psychotherapy123"

# Path to the CounselChat dataset (JSONL format)
DATASET_PATH = r"d:\Psyco Therapy\Layer6_Session_Instances\datasets\counsel_chat\train.json"

def process_counselchat():
    if not os.path.exists(DATASET_PATH):
        print(f"Error: Dataset not found at {DATASET_PATH}")
        return

    print("Connecting to Neo4j...")
    driver = GraphDatabase.driver(NEO4J_URI, auth=(NEO4J_USER, NEO4J_PASS))
    
    # Read the dataset
    print(f"Reading dataset from {DATASET_PATH}...")
    sessions = []
    with open(DATASET_PATH, 'r', encoding='utf-8') as f:
        for line in f:
            if line.strip():
                try:
                    data = json.loads(line)
                    # We only take the first 500 for the initial build to keep it fast
                    if len(sessions) < 500:
                        sessions.append(data)
                except json.JSONDecodeError:
                    continue

    print(f"Loaded {len(sessions)} session records. Inserting into Neo4j (Layer 6)...")

    # Cypher query to insert Session and link it
    # We use UNWIND to batch insert efficiently
    query = """
    UNWIND $batch AS record
    
    // 1. Create the Session Node
    MERGE (s:Session {session_id: 'counselchat_' + toString(record.questionID)})
    ON CREATE SET 
        s.patient_utterance = record.questionText,
        s.therapist_utterance = record.answerText,
        s.topic = record.topic,
        s.therapist = record.therapistInfo,
        s.source = "CounselChat",
        s.date_added = date()
        
    // 2. Link to existing clinical knowledge (Disorder, Symptom, or Emotion) based on topic keyword
    WITH s, record.topic AS topic
    MATCH (n)
    WHERE (n:Disorder OR n:Symptom OR n:EmotionalState) 
          AND toLower(n.name) CONTAINS toLower(topic) 
          AND size(topic) > 3 // prevent matching on tiny words
    MERGE (s)-[:EXPRESSED]->(n)
    """

    # Execute in batches of 100
    batch_size = 100
    total_inserted = 0
    with driver.session(database="neo4j") as session:
        for i in range(0, len(sessions), batch_size):
            batch = sessions[i:i+batch_size]
            session.run(query, batch=batch)
            total_inserted += len(batch)
            print(f"Inserted {total_inserted}/{len(sessions)} sessions...")

    # Verification Query
    with driver.session(database="neo4j") as session:
        result = session.run("MATCH (s:Session) RETURN count(s) AS total")
        total_sessions = result.single()["total"]
        print(f"\nSuccess! Total Layer 6 Sessions in Graph: {total_sessions}")
        
        result_links = session.run("MATCH (s:Session)-[r:EXPRESSED]->(n) RETURN count(r) AS total")
        total_links = result_links.single()["total"]
        print(f"Total connections from Sessions to Clinical Knowledge: {total_links}")

    driver.close()

if __name__ == "__main__":
    process_counselchat()
