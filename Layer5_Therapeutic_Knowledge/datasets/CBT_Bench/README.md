# CBT-Bench (Psychotherapy-LLM)

**License**: CC BY-NC 4.0 (Creative Commons Non-Commercial)
**Source**: Psychotherapy-LLM Research Group
**HuggingFace**: https://huggingface.co/datasets/Psychotherapy-LLM/CBT-Bench

## Description
Benchmark dataset evaluating LLM proficiency in CBT (Cognitive Behavioral Therapy).
Contains multiple-choice Q&A across CBT knowledge categories.

## Downloaded Configs
| Config | Description | KG Mapping |
|--------|-------------|------------|
| qa_test / qa_seed | General CBT knowledge Q&A | Layer 5 TherapeuticTechnique |
| distortions_test / seed | Cognitive distortions identification | Layer 3 Behaviour + Layer 5 |
| core_major_test / seed | Core CBT major categories | Layer 5 TherapeuticTechnique |
| core_fine_test / seed | Core CBT fine-grained categories | Layer 5 TherapeuticTechnique |

## KG Layer Mapping (kg_guide_v2.pdf)
- **Layer 3 — Behavioural Patterns**: distortions configs map to cognitive distortion behaviours
- **Layer 5 — Therapeutic Techniques**: all configs map to CBT technique nodes
  - Cognitive restructuring, thought records, behavioural experiments, etc.

## Academic Use
Permitted under CC BY-NC 4.0. Not for commercial use. Cite the dataset when publishing.
