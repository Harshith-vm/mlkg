# Multi-Layered Knowledge Graph (MLKG) for Psychotherapy

This repository contains the architecture and ETL pipelines for a production-ready, highly accurate Multi-Layered Knowledge Graph (MLKG) built for AI-assisted Psychotherapy. It is designed to act as the medical and conversational foundation for a Large Language Model (LLM) agent.

## Architecture Overview
The MLKG is strictly divided into two distinct components to prevent AI hallucination and ensure clinical accuracy:

### Part 1: Static Clinical Truth (Layers 1-4)
These layers form the medical foundation of the graph. They are built entirely from authoritative medical guidelines (DSM-5, ICD-11, NIMH) using static Cypher scripts to guarantee 100% accuracy.
- **Layer 1:** Clinical Truth (Disorders, e.g., Major Depressive Disorder, Panic Disorder)
- **Layer 2:** Emotional States (e.g., Anxiety, Sadness, utilizing GoEmotions taxonomy)
- **Layer 3:** Behavioural Patterns (e.g., Insomnia, Avoidance)
- **Layer 4:** Contextual Factors (e.g., Job Loss, Childbirth, Medical Diagnosis)

### Part 2: Dynamic Instances (Layers 5-6)
These layers are populated dynamically from massive NLP datasets using Python ETL pipelines. They link real-world patient scenarios and therapeutic sessions directly to the clinical truth nodes.
- **Layer 5:** Therapeutic Knowledge & Cognitive Patterns (Populated via `CBT_Bench`)
- **Layer 6:** Session Instances (Populated via `CounselChat` and `MentalChat16K`)

## Features
- **Strict Medical Ontologies:** ICD-11 and DSM-5 mapping.
- **Semantic Vector Search (GraphRAG):** Full integration with Neo4j 5 Native Vector Indexes. All Symptoms and Sessions are embedded using `sentence-transformers` (`all-MiniLM-L6-v2`) to enable lightning-fast, mathematically precise semantic queries (Cosine Similarity).

## Directory Structure
- `Layer1_Clinical_Truth/` - Contains Cypher scripts for graph initialization.
- `Layer2_Emotional_States/`
- `Layer3_Behavioural_Patterns/`
- `Layer4_Contextual_Factors/`
- `Layer5_Therapeutic_Knowledge/` - Contains Python ETL pipelines for extracting Cognitive Distortions.
- `Layer6_Session_Instances/` - Contains Python ETL pipelines for ingesting 16K+ therapy sessions and calculating Vector Embeddings.

## Setup Instructions
1. Install Neo4j (Community Edition 5.x+).
2. Execute the Cypher scripts in Layers 1-4.
3. Install Python requirements: `pip install neo4j sentence-transformers numpy`
4. Run the ETL pipelines in Layers 5 and 6 to ingest real-world data and generate semantic vector embeddings.
