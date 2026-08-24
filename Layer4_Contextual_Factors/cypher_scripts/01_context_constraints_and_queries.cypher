// ==============================================================================
// LAYER 4: CONTEXTUAL FACTORS
// ==============================================================================
// Note: The physical nodes (e.g. Job Loss, Divorce, Medical Trauma) are created 
// dynamically alongside the Disorders in the Layer 1 scripts to guarantee 
// structural integrity of the graph edges.
//
// This script defines the constraints, indexes, and core queries for Layer 4.
// ==============================================================================

// 1. Create Constraints and Indexes for Performance
CREATE CONSTRAINT context_name_unique IF NOT EXISTS FOR (c:Context) REQUIRE c.name IS UNIQUE;
CREATE INDEX context_name_index IF NOT EXISTS FOR (c:Context) ON (c.name);

// 2. Sample Query: Retrieve all Contextual Factors associated with a specific Disorder
// MATCH (d:Disorder {name: "Post-Traumatic Stress Disorder"})-[:HAS_CONTEXT]->(c:Context)
// RETURN d.name, c.name, c.description;

// 3. Sample Query: Find all Disorders sharing a common Context (e.g., Job Loss)
// MATCH (d:Disorder)-[:HAS_CONTEXT]->(c:Context {name: "Job Loss"})
// RETURN c.name, collect(d.name) AS associated_disorders;

// 4. Sample Query: Count the frequency of Contexts across the Knowledge Graph
// MATCH (d:Disorder)-[:HAS_CONTEXT]->(c:Context)
// RETURN c.name, count(d) AS frequency
// ORDER BY frequency DESC;
