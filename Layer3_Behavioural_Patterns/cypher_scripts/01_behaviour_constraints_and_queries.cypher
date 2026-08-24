// ==============================================================================
// LAYER 3: BEHAVIOURAL PATTERNS
// ==============================================================================
// Note: The physical nodes (e.g. Insomnia, Aggression, Avoidance) are created 
// dynamically alongside the Disorders in the Layer 1 scripts to guarantee 
// structural integrity of the graph edges.
//
// This script defines the constraints, indexes, and core queries for Layer 3.
// ==============================================================================

// 1. Create Constraints and Indexes for Performance
CREATE CONSTRAINT behavior_name_unique IF NOT EXISTS FOR (b:Behavior) REQUIRE b.name IS UNIQUE;
CREATE INDEX behavior_name_index IF NOT EXISTS FOR (b:Behavior) ON (b.name);

// 2. Sample Query: Retrieve all Behaviours associated with a specific Disorder
// MATCH (d:Disorder {name: "Major Depressive Disorder"})-[:HAS_BEHAVIOR]->(b:Behavior)
// RETURN d.name, b.name, b.description;

// 3. Sample Query: Find all Disorders sharing a common Behaviour (e.g., Insomnia)
// MATCH (d:Disorder)-[:HAS_BEHAVIOR]->(b:Behavior {name: "Insomnia"})
// RETURN b.name, collect(d.name) AS disorders;

// 4. Sample Query: Count the frequency of Behaviours across the Knowledge Graph
// MATCH (d:Disorder)-[:HAS_BEHAVIOR]->(b:Behavior)
// RETURN b.name, count(d) AS frequency
// ORDER BY frequency DESC;
