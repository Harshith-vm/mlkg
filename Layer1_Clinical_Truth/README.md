# Layer 1: Clinical Truth

This layer represents the core medical foundation of the Knowledge Graph. 

**Note on Cypher Scripts & Datasets:**
The Cypher scripts located in `cypher_scripts/` are responsible for generating **Layer 1 (Disorders)**, **Layer 3 (Behaviours)**, and **Layer 4 (Contexts)** all at once. This is because Neo4j `MERGE` queries must create the edges (connections) between disorders and behaviours simultaneously to guarantee structural integrity.

Because we strictly use the DSM-5 and ICD-11 manuals for this clinical truth, we **do not use NLP CSV/JSON datasets** here to avoid internet hallucination.
