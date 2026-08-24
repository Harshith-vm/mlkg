# MentalChat16K

**License**: MIT  
**Creator**: Shen Lab, University of Pennsylvania  
**Source**: https://huggingface.co/datasets/ShenLab/MentalChat16K  
**Paper**: arxiv:2503.13509  
**Rows**: 16,084 conversations  

## Description
Synthetic conversations between a counselor and a client, covering 33 mental
health topics including Anxiety, Depression, Relationships, Intimacy, and Family Conflict.
Generated using GPT-3.5 Turbo + Airoboros self-generation framework.

## Columns
- `instruction`: Task instruction (therapist context/system prompt)
- `input`: Client's input/question
- `output`: Counselor's therapeutic response

## KG Layer Mapping (kg_guide_v2.pdf)
| Layer | Mapping |
|-------|---------|
| Layer 2 - Emotional States | Topics: Anxiety, Depression, Grief -> EmotionalState nodes |
| Layer 3 - Behavioural Patterns | Avoidance, Rumination patterns in client turns |
| Layer 4 - Context | Family Conflict, Work Stress -> ContextCategory nodes |
| Layer 5 - Therapeutic Techniques | Counselor responses encode CBT techniques |
| Layer 6 - Session/Instance | Each conversation = one session interaction |

## Academic Use
Permitted for academic and research projects under MIT license.
Cite the paper arxiv:2503.13509 when publishing.
