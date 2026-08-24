# Mental Health Counseling Conversations

**License**: Other (open academic use -- verify before commercial use)  
**Creator**: Amod  
**Source**: https://huggingface.co/datasets/Amod/mental_health_counseling_conversations  
**DOI**: 10.57967/hf/1581  
**Downloads**: 100,000+ since public release in 2023  
**Rows**: 3,512 Q&A pairs  

## Description
High-quality, real one-on-one mental health counseling conversations between individuals
and licensed professionals. Structured as Context-Response pairs.
Sourced from online therapy platforms (anonymized/paraphrased).

## Columns
- `Context`: User's question or description of their issue
- `Response`: Licensed professional's therapeutic response

## KG Layer Mapping (kg_guide_v2.pdf)
| Layer | Mapping |
|-------|---------|
| Layer 2 - Emotional States | Context sentences describe Anxiety, Sadness, Fear |
| Layer 3 - Behavioural Patterns | Avoidance, isolation, self-harm mentions in Context |
| Layer 5 - Therapeutic Techniques | Response encodes CBT, validation, psychoeducation |
| Layer 6 - Session/Instance | Each Q&A pair = one session instance node |

## Academic Use
Permitted for academic and research projects.
Cite the dataset DOI 10.57967/hf/1581 when publishing.
