// ============================================================
// MULTI-LAYER KNOWLEDGE GRAPH — COMPLETE BUILD SCRIPT
// AI-Assisted Psychotherapy Capstone Project
// Based on: kg_guide_v2.pdf + kg_demo_example_v2.pdf
// Reference image: WhatsApp Image 2026-08-22 at 17.32.42.jpeg
//
// 5 PRIORITY DISORDERS (Section 7.3, kg_demo_example_v2.pdf):
//   1. GeneralizedAnxietyDisorder (GAD)
//   2. MildDepressiveEpisode (MDD)
//   3. PanicDisorder
//   4. SocialAnxietyDisorder (SAD)
//   5. PTSD
//
// ALL 6 LAYERS:
//   L1 — Clinical/Psychological Concepts (Disorder, Symptom, CognitivePattern)
//   L2 — Emotional States (EmotionalState)
//   L3 — Behavioural Patterns (Behaviour)
//   L4 — Contextual Categories (ContextCategory)
//   L5 — Therapeutic Knowledge (TherapeuticModality, TherapeuticTechnique)
//   L6 — Instance Layer (Session + temporal chain)
//
// PROVENANCE DISCIPLINE (Section 1.4, kg_demo_example_v2.pdf):
//   Every node: source, confidence, date_added
//   Every relationship: source (where applicable)
//   MERGE on name only, ON CREATE SET for rest (idempotent, safe to re-run)
// ============================================================

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 0 — CONSTRAINTS (run once, idempotent)
// ═══════════════════════════════════════════════════════════
// ============================================================
CREATE CONSTRAINT disorder_name   IF NOT EXISTS FOR (n:Disorder)            REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT symptom_name    IF NOT EXISTS FOR (n:Symptom)             REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT cogpat_name     IF NOT EXISTS FOR (n:CognitivePattern)    REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT emotion_name    IF NOT EXISTS FOR (n:EmotionalState)      REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT behaviour_name  IF NOT EXISTS FOR (n:Behaviour)           REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT context_name    IF NOT EXISTS FOR (n:ContextCategory)     REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT modality_name   IF NOT EXISTS FOR (n:TherapeuticModality) REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT technique_name  IF NOT EXISTS FOR (n:TherapeuticTechnique)REQUIRE n.name IS UNIQUE;
CREATE CONSTRAINT session_id      IF NOT EXISTS FOR (n:Session)             REQUIRE n.session_id IS UNIQUE;

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 1 — LAYER 1: DISORDERS (all 5, fully cross-mapped)
// Source: Section 7.3, kg_demo_example_v2.pdf
//         DSM-5 | ICD-10 | ICD-11 | UMLS CUI | SNOMED CT
// ═══════════════════════════════════════════════════════════
// ============================================================

// 1.1  Generalized Anxiety Disorder
MERGE (gad:Disorder {name:"GeneralizedAnxietyDisorder"})
ON CREATE SET
  gad.dsm_ref     = "300.02",
  gad.icd10_ref   = "F41.1",
  gad.icd11_ref   = "6B00",
  gad.umls_cui    = "C0270549",
  gad.snomed_id   = "21897009",
  gad.description = "Generalised anxiety disorder is characterised by marked symptoms of anxiety that persist for at least several months, for more days than not, manifested by either general apprehension or excessive worry focused on multiple everyday events, together with additional symptoms such as muscular tension or motor restlessness, sympathetic autonomic over-activity, subjective nervousness, difficulty concentrating, irritability, or sleep disturbance.",
  gad.source      = "manually-curated + NIMH + UMLS + WHO ICD-11",
  gad.confidence  = 1.0,
  gad.date_added  = date();

// 1.2  Mild Depressive Episode
MERGE (mde:Disorder {name:"MildDepressiveEpisode"})
ON CREATE SET
  mde.dsm_ref     = "F32.0",
  mde.icd10_ref   = "F32.0",
  mde.icd11_ref   = "6A70.0",
  mde.umls_cui    = "C0494397",
  mde.snomed_id   = "79298009",
  mde.description = "A mild depressive episode is characterised by depressed mood, loss of interest or pleasure, reduced energy, and at least two of: reduced concentration, reduced self-esteem, ideas of guilt, pessimistic views, self-harm or suicidal ideation, disturbed sleep, diminished appetite. Symptoms cause some impairment but the individual is able to continue with most activities.",
  mde.source      = "NIMH + UMLS + WHO ICD-11 + DSM-5",
  mde.confidence  = 1.0,
  mde.date_added  = date();

// 1.3  Panic Disorder
MERGE (pd:Disorder {name:"PanicDisorder"})
ON CREATE SET
  pd.dsm_ref     = "F41.0",
  pd.icd10_ref   = "F41.0",
  pd.icd11_ref   = "6B01",
  pd.umls_cui    = "C0030319",
  pd.snomed_id   = "371631005",
  pd.description = "Panic disorder is characterised by recurrent unexpected panic attacks — discrete episodes of intense fear or discomfort reaching a peak within minutes — accompanied by somatic and cognitive symptoms, followed by persistent concern about further attacks or their consequences.",
  pd.source      = "NIMH + UMLS + WHO ICD-11 + DSM-5",
  pd.confidence  = 1.0,
  pd.date_added  = date();

// 1.4  Social Anxiety Disorder
MERGE (sad:Disorder {name:"SocialAnxietyDisorder"})
ON CREATE SET
  sad.dsm_ref     = "F40.10",
  sad.icd10_ref   = "F40.1",
  sad.icd11_ref   = "6B04",
  sad.umls_cui    = "C0031572",
  sad.snomed_id   = "25501002",
  sad.description = "Social anxiety disorder is characterised by marked and excessive fear or anxiety about one or more social situations in which the individual may be scrutinised by others, sufficient to be consistently avoided or endured with intense fear or anxiety.",
  sad.source      = "NIMH + UMLS + WHO ICD-11 + DSM-5",
  sad.confidence  = 1.0,
  sad.date_added  = date();

// 1.5  PTSD
MERGE (ptsd:Disorder {name:"PTSD"})
ON CREATE SET
  ptsd.dsm_ref     = "F43.10",
  ptsd.icd10_ref   = "F43.1",
  ptsd.icd11_ref   = "6B40",
  ptsd.umls_cui    = "C0038436",
  ptsd.snomed_id   = "47505003",
  ptsd.description = "Post-traumatic stress disorder may develop following exposure to an extremely threatening or horrifying event or series of events. It is characterised by re-experiencing the traumatic event(s), avoidance of trauma-related thoughts and memories, persistent perceptions of heightened current threat, and significant functional impairment.",
  ptsd.source      = "NIMH + UMLS + WHO ICD-11 + DSM-5",
  ptsd.confidence  = 1.0,
  ptsd.date_added  = date();

// ============================================================
// LAYER 1 CONTINUED — SYMPTOMS
// Source: NIMH clinical brochures (confidence 1.0 for all)
// Shared symptoms reused across disorders (no duplication)
// ============================================================

// ── GAD Symptoms (12) ─────────────────────────────────────
MERGE (s_ew:Symptom   {name:"ExcessiveWorry"})           ON CREATE SET s_ew.source="NIMH",  s_ew.confidence=1.0,  s_ew.date_added=date();
MERGE (s_dcw:Symptom  {name:"DifficultyControllingWorry"})ON CREATE SET s_dcw.source="NIMH", s_dcw.confidence=1.0, s_dcw.date_added=date();
MERGE (s_irr:Symptom  {name:"Irritability"})              ON CREATE SET s_irr.source="NIMH",  s_irr.confidence=1.0,  s_irr.date_added=date();
MERGE (s_rst:Symptom  {name:"Restlessness"})              ON CREATE SET s_rst.source="NIMH",  s_rst.confidence=1.0,  s_rst.date_added=date();
MERGE (s_dc:Symptom   {name:"DifficultyConcentrating"})   ON CREATE SET s_dc.source="NIMH",   s_dc.confidence=1.0,   s_dc.date_added=date();
MERGE (s_ins:Symptom  {name:"Insomnia"})                  ON CREATE SET s_ins.source="NIMH",  s_ins.confidence=1.0,  s_ins.date_added=date();
MERGE (s_fat:Symptom  {name:"Fatigue"})                   ON CREATE SET s_fat.source="NIMH",  s_fat.confidence=1.0,  s_fat.date_added=date();
MERGE (s_mtp:Symptom  {name:"MuscleTensionOrPain"})       ON CREATE SET s_mtp.source="NIMH",  s_mtp.confidence=1.0,  s_mtp.date_added=date();
MERGE (s_tt:Symptom   {name:"TremblingOrTwitching"})      ON CREATE SET s_tt.source="NIMH",   s_tt.confidence=1.0,   s_tt.date_added=date();
MERGE (s_sl:Symptom   {name:"SweatingOrLightheadedness"}) ON CREATE SET s_sl.source="NIMH",   s_sl.confidence=1.0,   s_sl.date_added=date();
MERGE (s_dsw:Symptom  {name:"DifficultySwallowing"})      ON CREATE SET s_dsw.source="NIMH",  s_dsw.confidence=1.0,  s_dsw.date_added=date();
MERGE (s_fu:Symptom   {name:"FrequentUrination"})         ON CREATE SET s_fu.source="NIMH",   s_fu.confidence=1.0,   s_fu.date_added=date();

// ── MDE Symptoms (4 new + 1 reused: DifficultyConcentrating) ─
MERGE (s_psm:Symptom {name:"PersistentSadMood"})          ON CREATE SET s_psm.source="NIMH",  s_psm.confidence=1.0,  s_psm.date_added=date();
MERGE (s_lip:Symptom {name:"LossOfInterestOrPleasure"})   ON CREATE SET s_lip.source="NIMH",  s_lip.confidence=1.0,  s_lip.date_added=date();
MERGE (s_fow:Symptom {name:"FeelingsOfWorthlessness"})    ON CREATE SET s_fow.source="NIMH",  s_fow.confidence=1.0,  s_fow.date_added=date();
MERGE (s_de:Symptom  {name:"DecreasedEnergy"})            ON CREATE SET s_de.source="NIMH",   s_de.confidence=1.0,   s_de.date_added=date();
MERGE (s_gwh:Symptom {name:"GuiltWorthlessnessOrHelplessness"}) ON CREATE SET s_gwh.source="NIMH", s_gwh.confidence=1.0, s_gwh.date_added=date();
MERGE (s_tsd:Symptom {name:"ThoughtsOfDeathOrSuicide"})   ON CREATE SET s_tsd.source="NIMH",  s_tsd.confidence=1.0,  s_tsd.date_added=date();
MERGE (s_awc:Symptom {name:"AppetiteOrWeightChanges"})    ON CREATE SET s_awc.source="NIMH",  s_awc.confidence=1.0,  s_awc.date_added=date();
MERGE (s_pam:Symptom {name:"PsychomotorAgitationOrSlowing"}) ON CREATE SET s_pam.source="NIMH", s_pam.confidence=1.0, s_pam.date_added=date();

// ── Panic Disorder Symptoms (11) ──────────────────────────
MERGE (s_palp:Symptom {name:"PalpitationsOrRacingHeart"}) ON CREATE SET s_palp.source="NIMH", s_palp.confidence=1.0, s_palp.date_added=date();
MERGE (s_sob:Symptom  {name:"ShortnessOfBreath"})         ON CREATE SET s_sob.source="NIMH",  s_sob.confidence=1.0,  s_sob.date_added=date();
MERGE (s_ccp:Symptom  {name:"ChestPainOrDiscomfort"})     ON CREATE SET s_ccp.source="NIMH",  s_ccp.confidence=1.0,  s_ccp.date_added=date();
MERGE (s_nau:Symptom  {name:"NauseaOrStomachDistress"})   ON CREATE SET s_nau.source="NIMH",  s_nau.confidence=1.0,  s_nau.date_added=date();
MERGE (s_diz:Symptom  {name:"DizzinessOrUnsteadiness"})   ON CREATE SET s_diz.source="NIMH",  s_diz.confidence=1.0,  s_diz.date_added=date();
MERGE (s_num:Symptom  {name:"NumbnessTinglingsensation"})  ON CREATE SET s_num.source="NIMH",  s_num.confidence=1.0,  s_num.date_added=date();
MERGE (s_hot:Symptom  {name:"HotFlashesOrChills"})        ON CREATE SET s_hot.source="NIMH",  s_hot.confidence=1.0,  s_hot.date_added=date();
MERGE (s_der:Symptom  {name:"DerealisationOrDepersonalisation"}) ON CREATE SET s_der.source="NIMH", s_der.confidence=1.0, s_der.date_added=date();
MERGE (s_flo:Symptom  {name:"FearOfLosingControl"})       ON CREATE SET s_flo.source="NIMH",  s_flo.confidence=1.0,  s_flo.date_added=date();
MERGE (s_fod:Symptom  {name:"FearOfDying"})               ON CREATE SET s_fod.source="NIMH",  s_fod.confidence=1.0,  s_fod.date_added=date();
MERGE (s_upc:Symptom  {name:"UnexpectedPanicAttacks"})    ON CREATE SET s_upc.source="NIMH",  s_upc.confidence=1.0,  s_upc.date_added=date();

// ── Social Anxiety Disorder Symptoms (8) ──────────────────
MERGE (s_fne:Symptom {name:"FearOfNegativeJudgement"})    ON CREATE SET s_fne.source="NIMH", s_fne.confidence=1.0, s_fne.date_added=date();
MERGE (s_eas:Symptom {name:"EasilyStartled"})              ON CREATE SET s_eas.source="NIMH", s_eas.confidence=1.0, s_eas.date_added=date();
MERGE (s_bls:Symptom {name:"BlushingOrFreezing"})          ON CREATE SET s_bls.source="NIMH", s_bls.confidence=1.0, s_bls.date_added=date();
MERGE (s_avs:Symptom {name:"AvoidingSocialSituations"})    ON CREATE SET s_avs.source="NIMH", s_avs.confidence=1.0, s_avs.date_added=date();
MERGE (s_fts:Symptom {name:"FeelingTenseOrStiff"})         ON CREATE SET s_fts.source="NIMH", s_fts.confidence=1.0, s_fts.date_added=date();
MERGE (s_dme:Symptom {name:"DifficultyMakingEyeContact"})  ON CREATE SET s_dme.source="NIMH", s_dme.confidence=1.0, s_dme.date_added=date();
MERGE (s_slsp:Symptom{name:"SpeakingTooSoftlyOrFastly"})   ON CREATE SET s_slsp.source="NIMH",s_slsp.confidence=1.0,s_slsp.date_added=date();
MERGE (s_wor:Symptom {name:"WorryingForDaysBeforeSocialEvent"}) ON CREATE SET s_wor.source="NIMH", s_wor.confidence=1.0, s_wor.date_added=date();

// ── PTSD Symptoms (12) ────────────────────────────────────
MERGE (s_flb:Symptom {name:"Flashbacks"})                  ON CREATE SET s_flb.source="NIMH", s_flb.confidence=1.0, s_flb.date_added=date();
MERGE (s_nig:Symptom {name:"Nightmares"})                  ON CREATE SET s_nig.source="NIMH", s_nig.confidence=1.0, s_nig.date_added=date();
MERGE (s_dto:Symptom {name:"DistressingThoughtsOrMemories"}) ON CREATE SET s_dto.source="NIMH",s_dto.confidence=1.0, s_dto.date_added=date();
MERGE (s_atr:Symptom {name:"AvoidingTraumaReminders"})     ON CREATE SET s_atr.source="NIMH", s_atr.confidence=1.0, s_atr.date_added=date();
MERGE (s_aab:Symptom {name:"AngryOrAggressiveBehaviour"})  ON CREATE SET s_aab.source="NIMH", s_aab.confidence=1.0, s_aab.date_added=date();
MERGE (s_rrb:Symptom {name:"RiskyOrRecklessBehaviour"})    ON CREATE SET s_rrb.source="NIMH", s_rrb.confidence=1.0, s_rrb.date_added=date();
MERGE (s_avt:Symptom {name:"AvoidingThoughtsAboutTrauma"}) ON CREATE SET s_avt.source="NIMH", s_avt.confidence=1.0, s_avt.date_added=date();
MERGE (s_mob:Symptom {name:"ExaggeratedMoralBlame"})       ON CREATE SET s_mob.source="NIMH", s_mob.confidence=1.0, s_mob.date_added=date();
MERGE (s_pss:Symptom {name:"PhysicalSignsOfStress"})       ON CREATE SET s_pss.source="NIMH", s_pss.confidence=1.0, s_pss.date_added=date();
MERGE (s_dfp:Symptom {name:"DifficultyFeelingPositive"})   ON CREATE SET s_dfp.source="NIMH", s_dfp.confidence=1.0, s_dfp.date_added=date();
MERGE (s_aps:Symptom {name:"ActivePsychosis"})             ON CREATE SET s_aps.source="PMC3406222", s_aps.confidence=1.0, s_aps.date_added=date();
MERGE (s_ssi:Symptom {name:"SevereSuicidalIdeation"})      ON CREATE SET s_ssi.source="PMC3406222", s_ssi.confidence=1.0, s_ssi.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 2 — LAYER 2: EMOTIONAL STATES
// GoEmotions taxonomy (Apache 2.0, Demszky et al. ACL 2020)
// + manually-curated clinical states (Anxiety, Fear, Shame)
// Source: Section 7.6, kg_demo_example_v2.pdf
// valence: -1.0 (very negative) to +1.0 (very positive)
// arousal:  0.0 (calm) to 1.0 (highly activated)
// ═══════════════════════════════════════════════════════════
// ============================================================

// Core clinical emotions (manually-curated)
MERGE (e_anx:EmotionalState {name:"Anxiety"})    ON CREATE SET e_anx.valence=-0.6, e_anx.arousal=0.8, e_anx.source="manually-curated",  e_anx.confidence=1.0, e_anx.date_added=date();
MERGE (e_fea:EmotionalState {name:"Fear"})       ON CREATE SET e_fea.valence=-0.7, e_fea.arousal=0.9, e_fea.source="manually-curated",  e_fea.confidence=1.0, e_fea.date_added=date();
MERGE (e_sha:EmotionalState {name:"Shame"})      ON CREATE SET e_sha.valence=-0.8, e_sha.arousal=0.4, e_sha.source="manually-curated",  e_sha.confidence=1.0, e_sha.date_added=date();
MERGE (e_sad:EmotionalState {name:"Sadness"})    ON CREATE SET e_sad.valence=-0.7, e_sad.arousal=0.2, e_sad.source="GoEmotions+manually-curated", e_sad.confidence=1.0, e_sad.date_added=date();
MERGE (e_ang:EmotionalState {name:"Anger"})      ON CREATE SET e_ang.valence=-0.6, e_ang.arousal=0.8, e_ang.source="GoEmotions+manually-curated", e_ang.confidence=1.0, e_ang.date_added=date();

// GoEmotions taxonomy nodes (text classification / session tone detection)
MERGE (e_gri:EmotionalState {name:"Grief"})          ON CREATE SET e_gri.valence=-0.8, e_gri.arousal=0.3, e_gri.source="GoEmotions-Demszky2020", e_gri.confidence=0.9, e_gri.date_added=date();
MERGE (e_dis:EmotionalState {name:"Disappointment"}) ON CREATE SET e_dis.valence=-0.5, e_dis.arousal=0.3, e_dis.source="GoEmotions-Demszky2020", e_dis.confidence=0.9, e_dis.date_added=date();
MERGE (e_emb:EmotionalState {name:"Embarrassment"})  ON CREATE SET e_emb.valence=-0.6, e_emb.arousal=0.6, e_emb.source="GoEmotions-Demszky2020", e_emb.confidence=0.9, e_emb.date_added=date();
MERGE (e_ner:EmotionalState {name:"Nervousness"})    ON CREATE SET e_ner.valence=-0.5, e_ner.arousal=0.7, e_ner.source="GoEmotions-Demszky2020", e_ner.confidence=0.9, e_ner.date_added=date();
MERGE (e_ann:EmotionalState {name:"Annoyance"})      ON CREATE SET e_ann.valence=-0.4, e_ann.arousal=0.5, e_ann.source="GoEmotions-Demszky2020", e_ann.confidence=0.9, e_ann.date_added=date();
MERGE (e_rem:EmotionalState {name:"Remorse"})        ON CREATE SET e_rem.valence=-0.7, e_rem.arousal=0.3, e_rem.source="GoEmotions-Demszky2020", e_rem.confidence=0.9, e_rem.date_added=date();
MERGE (e_joy:EmotionalState {name:"Joy"})            ON CREATE SET e_joy.valence=0.8,  e_joy.arousal=0.7, e_joy.source="GoEmotions-Demszky2020", e_joy.confidence=0.9, e_joy.date_added=date();
MERGE (e_rel:EmotionalState {name:"Relief"})         ON CREATE SET e_rel.valence=0.6,  e_rel.arousal=0.3, e_rel.source="GoEmotions-Demszky2020", e_rel.confidence=0.9, e_rel.date_added=date();
MERGE (e_pri:EmotionalState {name:"Pride"})          ON CREATE SET e_pri.valence=0.7,  e_pri.arousal=0.6, e_pri.source="GoEmotions-Demszky2020", e_pri.confidence=0.9, e_pri.date_added=date();
MERGE (e_gra:EmotionalState {name:"Gratitude"})      ON CREATE SET e_gra.valence=0.8,  e_gra.arousal=0.5, e_gra.source="GoEmotions-Demszky2020", e_gra.confidence=0.9, e_gra.date_added=date();
MERGE (e_opt:EmotionalState {name:"Optimism"})       ON CREATE SET e_opt.valence=0.7,  e_opt.arousal=0.6, e_opt.source="GoEmotions-Demszky2020", e_opt.confidence=0.9, e_opt.date_added=date();
MERGE (e_neu:EmotionalState {name:"Neutral"})        ON CREATE SET e_neu.valence=0.0,  e_neu.arousal=0.0, e_neu.source="GoEmotions-Demszky2020", e_neu.confidence=0.9, e_neu.date_added=date();
MERGE (e_con:EmotionalState {name:"Confusion"})      ON CREATE SET e_con.valence=-0.3, e_con.arousal=0.4, e_con.source="GoEmotions-Demszky2020", e_con.confidence=0.9, e_con.date_added=date();
MERGE (e_cur:EmotionalState {name:"Curiosity"})      ON CREATE SET e_cur.valence=0.4,  e_cur.arousal=0.5, e_cur.source="GoEmotions-Demszky2020", e_cur.confidence=0.9, e_cur.date_added=date();
MERGE (e_sur:EmotionalState {name:"Surprise"})       ON CREATE SET e_sur.valence=0.1,  e_sur.arousal=0.7, e_sur.source="GoEmotions-Demszky2020", e_sur.confidence=0.9, e_sur.date_added=date();
MERGE (e_car:EmotionalState {name:"Caring"})         ON CREATE SET e_car.valence=0.7,  e_car.arousal=0.4, e_car.source="GoEmotions-Demszky2020", e_car.confidence=0.9, e_car.date_added=date();
MERGE (e_adm:EmotionalState {name:"Admiration"})     ON CREATE SET e_adm.valence=0.7,  e_adm.arousal=0.5, e_adm.source="GoEmotions-Demszky2020", e_adm.confidence=0.9, e_adm.date_added=date();
MERGE (e_des:EmotionalState {name:"Desire"})         ON CREATE SET e_des.valence=0.4,  e_des.arousal=0.6, e_des.source="GoEmotions-Demszky2020", e_des.confidence=0.9, e_des.date_added=date();
MERGE (e_dis2:EmotionalState{name:"Disgust"})        ON CREATE SET e_dis2.valence=-0.6,e_dis2.arousal=0.5,e_dis2.source="GoEmotions-Demszky2020",e_dis2.confidence=0.9,e_dis2.date_added=date();
MERGE (e_exc:EmotionalState {name:"Excitement"})     ON CREATE SET e_exc.valence=0.8,  e_exc.arousal=0.9, e_exc.source="GoEmotions-Demszky2020", e_exc.confidence=0.9, e_exc.date_added=date();
MERGE (e_app:EmotionalState {name:"Approval"})       ON CREATE SET e_app.valence=0.6,  e_app.arousal=0.4, e_app.source="GoEmotions-Demszky2020", e_app.confidence=0.9, e_app.date_added=date();
MERGE (e_dap:EmotionalState {name:"Disapproval"})    ON CREATE SET e_dap.valence=-0.5, e_dap.arousal=0.4, e_dap.source="GoEmotions-Demszky2020", e_dap.confidence=0.9, e_dap.date_added=date();
MERGE (e_rea:EmotionalState {name:"Realization"})    ON CREATE SET e_rea.valence=0.2,  e_rea.arousal=0.5, e_rea.source="GoEmotions-Demszky2020", e_rea.confidence=0.9, e_rea.date_added=date();
MERGE (e_lov:EmotionalState {name:"Love"})           ON CREATE SET e_lov.valence=0.9,  e_lov.arousal=0.5, e_lov.source="GoEmotions-Demszky2020", e_lov.confidence=0.9, e_lov.date_added=date();
MERGE (e_amu:EmotionalState {name:"Amusement"})      ON CREATE SET e_amu.valence=0.7,  e_amu.arousal=0.6, e_amu.source="GoEmotions-Demszky2020", e_amu.confidence=0.9, e_amu.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 3 — LAYER 3: BEHAVIOURAL PATTERNS
// Source: Sections 4.1, 7.7, kg_demo_example_v2.pdf
//         + NIMH panic/SAD/PTSD pages
// ═══════════════════════════════════════════════════════════
// ============================================================

MERGE (b_av:Behaviour  {name:"AvoidanceBehaviour"})       ON CREATE SET b_av.source="manually-curated",   b_av.confidence=1.0,  b_av.description="Avoiding feared objects, situations, or thoughts that maintain anxiety through negative reinforcement.", b_av.date_added=date();
MERGE (b_ru:Behaviour  {name:"Rumination"})               ON CREATE SET b_ru.source="manually-curated",   b_ru.confidence=1.0,  b_ru.description="Repetitive, passive focus on distress symptoms and their possible causes and consequences.", b_ru.date_added=date();
MERGE (b_wi:Behaviour  {name:"Withdrawal"})               ON CREATE SET b_wi.source="manually-curated",   b_wi.confidence=1.0,  b_wi.description="Social and behavioural withdrawal — reduced engagement in previously enjoyable activities.", b_wi.date_added=date();
MERGE (b_sm:Behaviour  {name:"SubstanceMisuse"})          ON CREATE SET b_sm.source="NIMH",               b_sm.confidence=1.0,  b_sm.description="Use of alcohol or drugs to manage anxiety, commonly co-occurring with panic disorder and social anxiety disorder (NIMH).", b_sm.date_added=date();
MERGE (b_hs:Behaviour  {name:"HypervigilantSafetyBehaviours"}) ON CREATE SET b_hs.source="WHO ICD-11",  b_hs.confidence=1.0,  b_hs.description="Adopting new behaviours designed to ensure safety: not sitting with back to door, checking rear-view mirrors (WHO ICD-11 PTSD diagnostic text, verbatim).", b_hs.date_added=date();
MERGE (b_sb:Behaviour  {name:"SafetyBehaviours"})         ON CREATE SET b_sb.source="NIMH",              b_sb.confidence=0.9,  b_sb.description="Behaviours performed to reduce anticipated harm in social situations, e.g. holding a drink, rehearsing sentences.", b_sb.date_added=date();
MERGE (b_pro:Behaviour {name:"Procrastination"})          ON CREATE SET b_pro.source="manually-curated", b_pro.confidence=0.8, b_pro.description="Delaying tasks due to anxiety about failure or judgement.", b_pro.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 4 — LAYER 4: CONTEXTUAL CATEGORIES
// Source: Section 4.1 (GAD), 7.8 (PTSD/Anger), kg_demo_v2
// ═══════════════════════════════════════════════════════════
// ============================================================

MERGE (ctx_ws:ContextCategory {name:"WorkStress"})         ON CREATE SET ctx_ws.domain="work",           ctx_ws.source="manually-curated", ctx_ws.confidence=1.0, ctx_ws.date_added=date();
MERGE (ctx_rc:ContextCategory {name:"RelationshipConflict"})ON CREATE SET ctx_rc.domain="interpersonal", ctx_rc.source="PMC5421636",        ctx_rc.confidence=1.0, ctx_rc.date_added=date();
MERGE (ctx_fs:ContextCategory {name:"FamilyStress"})       ON CREATE SET ctx_fs.domain="family",         ctx_fs.source="manually-curated", ctx_fs.confidence=0.9, ctx_fs.date_added=date();
MERGE (ctx_he:ContextCategory {name:"HealthAnxiety"})      ON CREATE SET ctx_he.domain="health",         ctx_he.source="manually-curated", ctx_he.confidence=0.9, ctx_he.date_added=date();
MERGE (ctx_te:ContextCategory {name:"TraumaticEvent"})     ON CREATE SET ctx_te.domain="trauma",         ctx_te.source="NIMH",             ctx_te.confidence=1.0, ctx_te.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 5 — LAYER 5: THERAPEUTIC KNOWLEDGE
// Modalities: CBT, ACT, IPT (Section 7.5, kg_demo_v2)
// 13 Beck/Burns cognitive distortions (Section 7.4)
// ═══════════════════════════════════════════════════════════
// ============================================================

// Therapeutic Modalities
MERGE (m_cbt:TherapeuticModality {name:"CBT"})                        ON CREATE SET m_cbt.phase="PhaseI",  m_cbt.source="manually-curated", m_cbt.confidence=1.0, m_cbt.date_added=date();
MERGE (m_act:TherapeuticModality {name:"AcceptanceAndCommitmentTherapy"}) ON CREATE SET m_act.phase="PhaseI", m_act.source="Hayes/Strosahl/Wilson", m_act.confidence=1.0, m_act.date_added=date();
MERGE (m_ipt:TherapeuticModality {name:"InterpersonalTherapy"})       ON CREATE SET m_ipt.phase="PhaseI",  m_ipt.source="Weissman/Markowitz/Klerman", m_ipt.confidence=1.0, m_ipt.date_added=date();

// CBT Techniques (9)
MERGE (t_cr:TherapeuticTechnique  {name:"CognitiveRestructuring"})    ON CREATE SET t_cr.evidence_level="strong",   t_cr.source="manually-curated+Beck1963", t_cr.confidence=1.0, t_cr.date_added=date();
MERGE (t_ge:TherapeuticTechnique  {name:"GroundingExercise"})         ON CREATE SET t_ge.evidence_level="moderate", t_ge.source="manually-curated",          t_ge.confidence=1.0, t_ge.date_added=date();
MERGE (t_ba:TherapeuticTechnique  {name:"BehaviouralActivation"})     ON CREATE SET t_ba.evidence_level="strong",   t_ba.source="manually-curated+Nair2021-DOI:10.3233/SHTI210268", t_ba.confidence=1.0, t_ba.date_added=date();
MERGE (t_tr:TherapeuticTechnique  {name:"ThoughtRecord"})             ON CREATE SET t_tr.evidence_level="strong",   t_tr.source="manually-curated+Beck1979",  t_tr.confidence=1.0, t_tr.date_added=date();
MERGE (t_pmr:TherapeuticTechnique {name:"ProgressiveMuscleRelaxation"}) ON CREATE SET t_pmr.evidence_level="moderate", t_pmr.source="manually-curated",       t_pmr.confidence=1.0, t_pmr.date_added=date();
MERGE (t_eh:TherapeuticTechnique  {name:"ExposureHierarchy"})         ON CREATE SET t_eh.evidence_level="strong",   t_eh.source="manually-curated+PMC3406222", t_eh.confidence=1.0, t_eh.date_added=date();
MERGE (t_gd:TherapeuticTechnique  {name:"GuidedDiscovery"})           ON CREATE SET t_gd.evidence_level="strong",   t_gd.source="NIMH",                       t_gd.confidence=1.0, t_gd.date_added=date();
MERGE (t_ie:TherapeuticTechnique  {name:"InteroceptiveExposure"})     ON CREATE SET t_ie.evidence_level="strong",   t_ie.source="NIMH",                       t_ie.confidence=1.0, t_ie.date_added=date();
MERGE (t_ss:TherapeuticTechnique  {name:"SocialSkillsTraining"})      ON CREATE SET t_ss.evidence_level="moderate", t_ss.source="NIMH",                       t_ss.confidence=1.0, t_ss.date_added=date();

// ACT Technique (1)
MERGE (t_cd:TherapeuticTechnique  {name:"CognitiveDefusion"})         ON CREATE SET t_cd.evidence_level="strong",   t_cd.source="Hayes/Strosahl/Wilson",      t_cd.confidence=1.0, t_cd.date_added=date();

// IPT Technique (1)
MERGE (t_ca:TherapeuticTechnique  {name:"CommunicationAnalysis"})     ON CREATE SET t_ca.evidence_level="moderate", t_ca.source="Weissman/Markowitz/Klerman",  t_ca.confidence=1.0, t_ca.date_added=date();

// All 13 Beck/Burns Cognitive Distortions (CognitivePattern nodes)
// Sources: Beck 1963/1964/1979, Burns 1980 (12); McKay/Davis/Fanning for ControlFallacies
MERGE (cp_cat:CognitivePattern {name:"Catastrophising"})          ON CREATE SET cp_cat.source="Beck1979+Burns1980",       cp_cat.confidence=1.0, cp_cat.date_added=date();
MERGE (cp_baw:CognitivePattern {name:"BlackAndWhiteThinking"})    ON CREATE SET cp_baw.source="Beck1963+Burns1980",       cp_baw.confidence=1.0, cp_baw.date_added=date();
MERGE (cp_ovg:CognitivePattern {name:"Overgeneralization"})       ON CREATE SET cp_ovg.source="Beck1963+Burns1980",       cp_ovg.confidence=1.0, cp_ovg.date_added=date();
MERGE (cp_mir:CognitivePattern {name:"MindReading"})              ON CREATE SET cp_mir.source="Beck1964+Burns1980",       cp_mir.confidence=1.0, cp_mir.date_added=date();
MERGE (cp_ft:CognitivePattern  {name:"FortuneTelling"})           ON CREATE SET cp_ft.source="Beck1964+Burns1980",        cp_ft.confidence=1.0, cp_ft.date_added=date();
MERGE (cp_er:CognitivePattern  {name:"EmotionalReasoning"})       ON CREATE SET cp_er.source="Beck1979+Burns1980",        cp_er.confidence=1.0, cp_er.date_added=date();
MERGE (cp_sho:CognitivePattern {name:"ShouldStatements"})         ON CREATE SET cp_sho.source="Beck1963+Burns1980",       cp_sho.confidence=1.0, cp_sho.date_added=date();
MERGE (cp_lab:CognitivePattern {name:"Labeling"})                 ON CREATE SET cp_lab.source="Burns1980",                cp_lab.confidence=1.0, cp_lab.date_added=date();
MERGE (cp_per:CognitivePattern {name:"Personalization"})          ON CREATE SET cp_per.source="Beck1979+Burns1980",       cp_per.confidence=1.0, cp_per.date_added=date();
MERGE (cp_mf:CognitivePattern  {name:"MentalFilter"})             ON CREATE SET cp_mf.source="Beck1979+Burns1980",        cp_mf.confidence=1.0, cp_mf.date_added=date();
MERGE (cp_dtp:CognitivePattern {name:"DisqualifyingThePositive"}) ON CREATE SET cp_dtp.source="Burns1980",                cp_dtp.confidence=1.0, cp_dtp.date_added=date();
MERGE (cp_mag:CognitivePattern {name:"Magnification"})            ON CREATE SET cp_mag.source="Beck1979+Burns1980",       cp_mag.confidence=1.0, cp_mag.date_added=date();
MERGE (cp_cof:CognitivePattern {name:"ControlFallacies"})         ON CREATE SET cp_cof.source="McKay/Davis/Fanning-ThoughtsAndFeelings", cp_cof.confidence=1.0, cp_cof.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 6 — LAYER 6: INSTANCE LAYER (Sessions)
// 2 demo sessions + temporal chain (Section 4.1, kg_demo_v2)
// ═══════════════════════════════════════════════════════════
// ============================================================

MERGE (sess1:Session {session_id:"s_demo_001"}) ON CREATE SET sess1.timestamp=datetime("2026-08-05T09:00:00"), sess1.channel="text", sess1.source="manually-curated", sess1.confidence=1.0, sess1.date_added=date();
MERGE (sess2:Session {session_id:"s_demo_002"}) ON CREATE SET sess2.timestamp=datetime("2026-08-07T14:00:00"), sess2.channel="text", sess2.source="manually-curated", sess2.confidence=1.0, sess2.date_added=date();

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 7 — ALL RELATIONSHIPS
// ═══════════════════════════════════════════════════════════
// ============================================================

// ── Disorder → Symptom  (MANIFESTS_AS) ───────────────────

// GAD (12 symptoms)
MATCH (gad:Disorder {name:"GeneralizedAnxietyDisorder"})
MATCH (s_ew:Symptom{name:"ExcessiveWorry"}), (s_dcw:Symptom{name:"DifficultyControllingWorry"}),
      (s_irr:Symptom{name:"Irritability"}), (s_rst:Symptom{name:"Restlessness"}),
      (s_dc:Symptom{name:"DifficultyConcentrating"}), (s_ins:Symptom{name:"Insomnia"}),
      (s_fat:Symptom{name:"Fatigue"}), (s_mtp:Symptom{name:"MuscleTensionOrPain"}),
      (s_tt:Symptom{name:"TremblingOrTwitching"}), (s_sl:Symptom{name:"SweatingOrLightheadedness"}),
      (s_dsw:Symptom{name:"DifficultySwallowing"}), (s_fu:Symptom{name:"FrequentUrination"})
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_ew)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_dcw)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_irr)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_rst)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_dc)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_ins)
MERGE (gad)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_fat)
MERGE (gad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_mtp)
MERGE (gad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_tt)
MERGE (gad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_sl)
MERGE (gad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_dsw)
MERGE (gad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_fu);

// MDE (8 symptoms — DifficultyConcentrating reused from GAD)
MATCH (mde:Disorder{name:"MildDepressiveEpisode"})
MATCH (s_psm:Symptom{name:"PersistentSadMood"}), (s_lip:Symptom{name:"LossOfInterestOrPleasure"}),
      (s_fow:Symptom{name:"FeelingsOfWorthlessness"}), (s_de:Symptom{name:"DecreasedEnergy"}),
      (s_dc:Symptom{name:"DifficultyConcentrating"}), (s_ins:Symptom{name:"Insomnia"}),
      (s_tsd:Symptom{name:"ThoughtsOfDeathOrSuicide"}), (s_awc:Symptom{name:"AppetiteOrWeightChanges"}),
      (s_pam:Symptom{name:"PsychomotorAgitationOrSlowing"}), (s_gwh:Symptom{name:"GuiltWorthlessnessOrHelplessness"})
MERGE (mde)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_psm)
MERGE (mde)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_lip)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_fow)
MERGE (mde)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_de)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_dc)
MERGE (mde)-[:MANIFESTS_AS {frequency:"common",   source:"NIMH"}]->(s_ins)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_tsd)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_awc)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_pam)
MERGE (mde)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_gwh);

// Panic Disorder (11 symptoms)
MATCH (pd:Disorder{name:"PanicDisorder"})
MATCH (s_palp:Symptom{name:"PalpitationsOrRacingHeart"}), (s_sob:Symptom{name:"ShortnessOfBreath"}),
      (s_ccp:Symptom{name:"ChestPainOrDiscomfort"}), (s_nau:Symptom{name:"NauseaOrStomachDistress"}),
      (s_diz:Symptom{name:"DizzinessOrUnsteadiness"}), (s_num:Symptom{name:"NumbnessTinglingsensation"}),
      (s_hot:Symptom{name:"HotFlashesOrChills"}), (s_der:Symptom{name:"DerealisationOrDepersonalisation"}),
      (s_flo:Symptom{name:"FearOfLosingControl"}), (s_fod:Symptom{name:"FearOfDying"}),
      (s_upc:Symptom{name:"UnexpectedPanicAttacks"}), (s_ins:Symptom{name:"Insomnia"}),
      (s_tt:Symptom{name:"TremblingOrTwitching"}), (s_sl:Symptom{name:"SweatingOrLightheadedness"})
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_palp)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_sob)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_ccp)
MERGE (pd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_nau)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_diz)
MERGE (pd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_num)
MERGE (pd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_hot)
MERGE (pd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_der)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_flo)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_fod)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_upc)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_tt)
MERGE (pd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_sl)
MERGE (pd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_ins);

// Social Anxiety Disorder (8 symptoms + shared: Fatigue, Insomnia, Irritability)
MATCH (sad:Disorder{name:"SocialAnxietyDisorder"})
MATCH (s_fne:Symptom{name:"FearOfNegativeJudgement"}), (s_eas:Symptom{name:"EasilyStartled"}),
      (s_bls:Symptom{name:"BlushingOrFreezing"}), (s_avs:Symptom{name:"AvoidingSocialSituations"}),
      (s_fts:Symptom{name:"FeelingTenseOrStiff"}), (s_dme:Symptom{name:"DifficultyMakingEyeContact"}),
      (s_slsp:Symptom{name:"SpeakingTooSoftlyOrFastly"}), (s_wor:Symptom{name:"WorryingForDaysBeforeSocialEvent"}),
      (s_fat:Symptom{name:"Fatigue"}), (s_ins:Symptom{name:"Insomnia"})
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_fne)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_eas)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_bls)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_avs)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_fts)
MERGE (sad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_dme)
MERGE (sad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_slsp)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_wor)
MERGE (sad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_fat)
MERGE (sad)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_ins);

// PTSD (12 symptoms, Irritability + DifficultyConcentrating reused)
MATCH (ptsd:Disorder{name:"PTSD"})
MATCH (s_flb:Symptom{name:"Flashbacks"}), (s_nig:Symptom{name:"Nightmares"}),
      (s_dto:Symptom{name:"DistressingThoughtsOrMemories"}), (s_atr:Symptom{name:"AvoidingTraumaReminders"}),
      (s_aab:Symptom{name:"AngryOrAggressiveBehaviour"}), (s_rrb:Symptom{name:"RiskyOrRecklessBehaviour"}),
      (s_avt:Symptom{name:"AvoidingThoughtsAboutTrauma"}), (s_mob:Symptom{name:"ExaggeratedMoralBlame"}),
      (s_pss:Symptom{name:"PhysicalSignsOfStress"}), (s_dfp:Symptom{name:"DifficultyFeelingPositive"}),
      (s_irr:Symptom{name:"Irritability"}), (s_dc:Symptom{name:"DifficultyConcentrating"}),
      (s_ins:Symptom{name:"Insomnia"})
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_flb)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_nig)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_dto)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_atr)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_aab)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_rrb)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_avt)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_mob)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_pss)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_dfp)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_irr)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_dc)
MERGE (ptsd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_ins);

// ── EmotionalState ↔ Symptom  (ASSOCIATED_WITH) ──────────
MATCH (e_anx:EmotionalState{name:"Anxiety"}),    (s_ins:Symptom{name:"Insomnia"})       MERGE (e_anx)-[:ASSOCIATED_WITH {confidence:0.8,  source:"manually-curated"}]->(s_ins);
MATCH (e_sad:EmotionalState{name:"Sadness"}),     (s_ins:Symptom{name:"Insomnia"})       MERGE (e_sad)-[:ASSOCIATED_WITH {confidence:0.7,  source:"NIMH"}]->(s_ins);
MATCH (e_sad:EmotionalState{name:"Sadness"}),     (s_de:Symptom{name:"DecreasedEnergy"}) MERGE (e_sad)-[:ASSOCIATED_WITH {confidence:0.75, source:"NIMH"}]->(s_de);
MATCH (e_sha:EmotionalState{name:"Shame"}),       (s_gwh:Symptom{name:"GuiltWorthlessnessOrHelplessness"}) MERGE (e_sha)-[:ASSOCIATED_WITH {confidence:0.8, source:"NIMH"}]->(s_gwh);
MATCH (e_fea:EmotionalState{name:"Fear"}),        (s_palp:Symptom{name:"PalpitationsOrRacingHeart"})       MERGE (e_fea)-[:ASSOCIATED_WITH {confidence:0.85,source:"NIMH"}]->(s_palp);
MATCH (e_fea:EmotionalState{name:"Fear"}),        (s_sob:Symptom{name:"ShortnessOfBreath"})                MERGE (e_fea)-[:ASSOCIATED_WITH {confidence:0.8, source:"NIMH"}]->(s_sob);
MATCH (e_ang:EmotionalState{name:"Anger"}),       (s_aab:Symptom{name:"AngryOrAggressiveBehaviour"})       MERGE (e_ang)-[:ASSOCIATED_WITH {confidence:0.9, source:"NIMH"}]->(s_aab);
MATCH (e_emb:EmotionalState{name:"Embarrassment"}),(s_bls:Symptom{name:"BlushingOrFreezing"})              MERGE (e_emb)-[:ASSOCIATED_WITH {confidence:0.85,source:"GoEmotions-Demszky2020"}]->(s_bls);
MATCH (e_ner:EmotionalState{name:"Nervousness"}),  (s_fts:Symptom{name:"FeelingTenseOrStiff"})             MERGE (e_ner)-[:ASSOCIATED_WITH {confidence:0.8, source:"GoEmotions-Demszky2020"}]->(s_fts);
MATCH (e_gri:EmotionalState{name:"Grief"}),        (s_psm:Symptom{name:"PersistentSadMood"})               MERGE (e_gri)-[:ASSOCIATED_WITH {confidence:0.8, source:"GoEmotions-Demszky2020"}]->(s_psm);

// ── EmotionalState ↔ Behaviour  (CO_OCCURS_WITH) ─────────
MATCH (e_anx:EmotionalState{name:"Anxiety"}),  (b_ru:Behaviour{name:"Rumination"})         MERGE (e_anx)-[:CO_OCCURS_WITH {strength:0.75, source:"manually-curated"}]->(b_ru);
MATCH (e_anx:EmotionalState{name:"Anxiety"}),  (b_av:Behaviour{name:"AvoidanceBehaviour"}) MERGE (e_anx)-[:CO_OCCURS_WITH {strength:0.8,  source:"PMC8143038"}]->(b_av);
MATCH (e_sad:EmotionalState{name:"Sadness"}),  (b_wi:Behaviour{name:"Withdrawal"})         MERGE (e_sad)-[:CO_OCCURS_WITH {strength:0.7,  source:"NIMH"}]->(b_wi);
MATCH (e_fea:EmotionalState{name:"Fear"}),     (b_hs:Behaviour{name:"HypervigilantSafetyBehaviours"}) MERGE (e_fea)-[:CO_OCCURS_WITH {strength:0.75, source:"WHO ICD-11"}]->(b_hs);
MATCH (e_emb:EmotionalState{name:"Embarrassment"}),(b_sb:Behaviour{name:"SafetyBehaviours"})          MERGE (e_emb)-[:CO_OCCURS_WITH {strength:0.7, source:"NIMH"}]->(b_sb);

// ── ContextCategory → EmotionalState  (TRIGGERS) ─────────
MATCH (ctx_ws:ContextCategory{name:"WorkStress"}),       (e_anx:EmotionalState{name:"Anxiety"}) MERGE (ctx_ws)-[:TRIGGERS {strength:0.7,  source:"manually-curated"}]->(e_anx);
MATCH (ctx_rc:ContextCategory{name:"RelationshipConflict"}),(e_ang:EmotionalState{name:"Anger"}) MERGE (ctx_rc)-[:TRIGGERS {strength:0.75, source:"PMC5421636"}]->(e_ang);
MATCH (ctx_te:ContextCategory{name:"TraumaticEvent"}),   (e_fea:EmotionalState{name:"Fear"})    MERGE (ctx_te)-[:TRIGGERS {strength:0.9,  source:"NIMH"}]->(e_fea);
MATCH (ctx_he:ContextCategory{name:"HealthAnxiety"}),    (e_anx:EmotionalState{name:"Anxiety"}) MERGE (ctx_he)-[:TRIGGERS {strength:0.65, source:"manually-curated"}]->(e_anx);
MATCH (ctx_fs:ContextCategory{name:"FamilyStress"}),     (e_sad:EmotionalState{name:"Sadness"}) MERGE (ctx_fs)-[:TRIGGERS {strength:0.6,  source:"manually-curated"}]->(e_sad);

// ── Behaviour → EmotionalState  (WORSENS) ────────────────
MATCH (b_av:Behaviour{name:"AvoidanceBehaviour"}),   (e_anx:EmotionalState{name:"Anxiety"}) MERGE (b_av)-[:WORSENS {source:"PMC8143038", note:"Mowrer two-factor theory: avoidance blocks extinction learning"}]->(e_anx);
MATCH (b_av:Behaviour{name:"AvoidanceBehaviour"}),   (e_fea:EmotionalState{name:"Fear"})    MERGE (b_av)-[:WORSENS {source:"PMC8143038", note:"Avoidance prevents disconfirmation of threat beliefs"}]->(e_fea);
MATCH (b_ru:Behaviour{name:"Rumination"}),           (e_sad:EmotionalState{name:"Sadness"}) MERGE (b_ru)-[:WORSENS {source:"fpsyt.2022.920315"}]->(e_sad);
MATCH (b_wi:Behaviour{name:"Withdrawal"}),           (e_sad:EmotionalState{name:"Sadness"}) MERGE (b_wi)-[:WORSENS {source:"NIMH"}]->(e_sad);
MATCH (b_hs:Behaviour{name:"HypervigilantSafetyBehaviours"}),(e_anx:EmotionalState{name:"Anxiety"}) MERGE (b_hs)-[:WORSENS {source:"WHO ICD-11"}]->(e_anx);

// ── Behaviour → CognitivePattern  (INDICATES) ────────────
MATCH (b_ru:Behaviour{name:"Rumination"}),  (cp_cat:CognitivePattern{name:"Catastrophising"})     MERGE (b_ru)-[:INDICATES {confidence:0.80, source:"fpsyt.2022.920315"}]->(cp_cat);
MATCH (b_av:Behaviour{name:"AvoidanceBehaviour"}),(cp_ft:CognitivePattern{name:"FortuneTelling"}) MERGE (b_av)-[:INDICATES {confidence:0.7,  source:"Beck1964+Burns1980"}]->(cp_ft);
MATCH (b_sb:Behaviour{name:"SafetyBehaviours"}), (cp_mir:CognitivePattern{name:"MindReading"})    MERGE (b_sb)-[:INDICATES {confidence:0.7,  source:"manually-curated"}]->(cp_mir);

// ── TherapeuticTechnique → CognitivePattern  (IMPROVES) ──
MATCH (t_cr:TherapeuticTechnique{name:"CognitiveRestructuring"})
MATCH (cp_cat:CognitivePattern{name:"Catastrophising"}),    (cp_baw:CognitivePattern{name:"BlackAndWhiteThinking"}),
      (cp_ovg:CognitivePattern{name:"Overgeneralization"}),  (cp_mir:CognitivePattern{name:"MindReading"}),
      (cp_ft:CognitivePattern{name:"FortuneTelling"}),       (cp_er:CognitivePattern{name:"EmotionalReasoning"}),
      (cp_sho:CognitivePattern{name:"ShouldStatements"}),    (cp_lab:CognitivePattern{name:"Labeling"}),
      (cp_per:CognitivePattern{name:"Personalization"}),     (cp_mf:CognitivePattern{name:"MentalFilter"}),
      (cp_dtp:CognitivePattern{name:"DisqualifyingThePositive"}),(cp_mag:CognitivePattern{name:"Magnification"})
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_cat)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_baw)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_ovg)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_mir)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_ft)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_er)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_sho)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_lab)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_per)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_mf)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_dtp)
MERGE (t_cr)-[:IMPROVES {source:"Beck1963+Burns1980+PsychologyTools"}]->(cp_mag);

MATCH (t_cr:TherapeuticTechnique{name:"CognitiveRestructuring"}),(cp_cof:CognitivePattern{name:"ControlFallacies"})
MERGE (t_cr)-[:IMPROVES {source:"McKay/Davis/Fanning-ThoughtsAndFeelings"}]->(cp_cof);

MATCH (t_tr:TherapeuticTechnique{name:"ThoughtRecord"}),(cp_cat:CognitivePattern{name:"Catastrophising"})
MERGE (t_tr)-[:IMPROVES {source:"Beck1979"}]->(cp_cat);

MATCH (t_cd:TherapeuticTechnique{name:"CognitiveDefusion"}),(cp_er:CognitivePattern{name:"EmotionalReasoning"})
MERGE (t_cd)-[:IMPROVES {source:"Hayes/Strosahl/Wilson"}]->(cp_er);

// ── TherapeuticTechnique → Target  (RECOMMENDED_FOR) ─────
MATCH (t_ge:TherapeuticTechnique{name:"GroundingExercise"}),       (e_anx:EmotionalState{name:"Anxiety"})    MERGE (t_ge)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:2, source:"manually-curated"}]->(e_anx);
MATCH (t_cr:TherapeuticTechnique{name:"CognitiveRestructuring"}),  (cp_cat:CognitivePattern{name:"Catastrophising"}) MERGE (t_cr)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Beck1979"}]->(cp_cat);
MATCH (t_ba:TherapeuticTechnique{name:"BehaviouralActivation"}),   (b_wi:Behaviour{name:"Withdrawal"})        MERGE (t_ba)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Nair2021-DOI:10.3233/SHTI210268"}]->(b_wi);
MATCH (t_ba:TherapeuticTechnique{name:"BehaviouralActivation"}),   (e_sad:EmotionalState{name:"Sadness"})    MERGE (t_ba)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH"}]->(e_sad);
MATCH (t_ie:TherapeuticTechnique{name:"InteroceptiveExposure"}),   (e_fea:EmotionalState{name:"Fear"})       MERGE (t_ie)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH"}]->(e_fea);
MATCH (t_eh:TherapeuticTechnique{name:"ExposureHierarchy"}),       (b_av:Behaviour{name:"AvoidanceBehaviour"}) MERGE (t_eh)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH"}]->(b_av);
MATCH (t_ss:TherapeuticTechnique{name:"SocialSkillsTraining"}),    (b_sb:Behaviour{name:"SafetyBehaviours"})  MERGE (t_ss)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:2, source:"NIMH"}]->(b_sb);
MATCH (t_pmr:TherapeuticTechnique{name:"ProgressiveMuscleRelaxation"}),(e_anx:EmotionalState{name:"Anxiety"}) MERGE (t_pmr)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:3, source:"manually-curated"}]->(e_anx);
MATCH (t_gd:TherapeuticTechnique{name:"GuidedDiscovery"}),         (cp_baw:CognitivePattern{name:"BlackAndWhiteThinking"}) MERGE (t_gd)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Beck1979"}]->(cp_baw);
MATCH (t_tr:TherapeuticTechnique{name:"ThoughtRecord"}),           (cp_cat:CognitivePattern{name:"Catastrophising"}) MERGE (t_tr)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Beck1979"}]->(cp_cat);
MATCH (t_cd:TherapeuticTechnique{name:"CognitiveDefusion"}),       (cp_er:CognitivePattern{name:"EmotionalReasoning"}) MERGE (t_cd)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Hayes/Strosahl/Wilson"}]->(cp_er);
MATCH (t_ca:TherapeuticTechnique{name:"CommunicationAnalysis"}),   (e_ang:EmotionalState{name:"Anger"}) MERGE (t_ca)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:2, source:"Weissman/Markowitz/Klerman"}]->(e_ang);

// ── CONTRAINDICATED_FOR ───────────────────────────────────
MATCH (t_eh:TherapeuticTechnique{name:"ExposureHierarchy"}),(e_fea:EmotionalState{name:"Fear"})   MERGE (t_eh)-[:CONTRAINDICATED_FOR {source:"PMC3406222", reason:"Requires clinician supervision during acute fear states"}]->(e_fea);
MATCH (t_eh:TherapeuticTechnique{name:"ExposureHierarchy"}),(s_aps:Symptom{name:"ActivePsychosis"}) MERGE (t_eh)-[:CONTRAINDICATED_FOR {source:"PMC3406222", reason:"Active psychosis is a contraindication for prolonged exposure"}]->(s_aps);
MATCH (t_eh:TherapeuticTechnique{name:"ExposureHierarchy"}),(s_ssi:Symptom{name:"SevereSuicidalIdeation"}) MERGE (t_eh)-[:CONTRAINDICATED_FOR {source:"PMC3406222", reason:"Severe suicidal ideation is a contraindication for prolonged exposure"}]->(s_ssi);
MATCH (t_ie:TherapeuticTechnique{name:"InteroceptiveExposure"}),(s_ccp:Symptom{name:"ChestPainOrDiscomfort"}) MERGE (t_ie)-[:CONTRAINDICATED_FOR {source:"NIMH", reason:"Rule out cardiac causes before interoceptive exposure for chest pain"}]->(s_ccp);

// ── BELONGS_TO (Techniques → Modalities) ─────────────────
MATCH (m_cbt:TherapeuticModality{name:"CBT"})
MATCH (t_cr:TherapeuticTechnique{name:"CognitiveRestructuring"}), (t_ge:TherapeuticTechnique{name:"GroundingExercise"}),
      (t_ba:TherapeuticTechnique{name:"BehaviouralActivation"}),  (t_tr:TherapeuticTechnique{name:"ThoughtRecord"}),
      (t_pmr:TherapeuticTechnique{name:"ProgressiveMuscleRelaxation"}), (t_eh:TherapeuticTechnique{name:"ExposureHierarchy"}),
      (t_gd:TherapeuticTechnique{name:"GuidedDiscovery"}),        (t_ie:TherapeuticTechnique{name:"InteroceptiveExposure"}),
      (t_ss:TherapeuticTechnique{name:"SocialSkillsTraining"})
MERGE (t_cr)-[:BELONGS_TO]->(m_cbt)
MERGE (t_ge)-[:BELONGS_TO]->(m_cbt)
MERGE (t_ba)-[:BELONGS_TO]->(m_cbt)
MERGE (t_tr)-[:BELONGS_TO]->(m_cbt)
MERGE (t_pmr)-[:BELONGS_TO]->(m_cbt)
MERGE (t_eh)-[:BELONGS_TO]->(m_cbt)
MERGE (t_gd)-[:BELONGS_TO]->(m_cbt)
MERGE (t_ie)-[:BELONGS_TO]->(m_cbt)
MERGE (t_ss)-[:BELONGS_TO]->(m_cbt);

MATCH (t_cd:TherapeuticTechnique{name:"CognitiveDefusion"}),    (m_act:TherapeuticModality{name:"AcceptanceAndCommitmentTherapy"}) MERGE (t_cd)-[:BELONGS_TO]->(m_act);
MATCH (t_ca:TherapeuticTechnique{name:"CommunicationAnalysis"}),(m_ipt:TherapeuticModality{name:"InterpersonalTherapy"})           MERGE (t_ca)-[:BELONGS_TO]->(m_ipt);

// ── SESSION INSTANCE LAYER (L6) ───────────────────────────
MATCH (sess1:Session{session_id:"s_demo_001"}), (sess2:Session{session_id:"s_demo_002"})
MATCH (ctx_ws:ContextCategory{name:"WorkStress"}),   (e_anx:EmotionalState{name:"Anxiety"}),
      (s_ins:Symptom{name:"Insomnia"}),               (t_cr:TherapeuticTechnique{name:"CognitiveRestructuring"})
MERGE (sess1)-[:HAS_CONTEXT {timestamp:sess1.timestamp}]->(ctx_ws)
MERGE (sess1)-[:EXPRESSED   {confidence:0.82, timestamp:sess1.timestamp}]->(e_anx)
MERGE (sess2)-[:EXPRESSED   {confidence:0.7,  timestamp:sess2.timestamp}]->(s_ins)
MERGE (sess2)-[:RECEIVED    {timestamp:sess2.timestamp}]->(t_cr)
MERGE (sess1)-[:OCCURRED_BEFORE {gap_duration:duration('P2D')}]->(sess2);

// ============================================================
// ═══════════════════════════════════════════════════════════
// PART 8 — VERIFICATION QUERIES
// Run these after loading to verify the graph counts match
// Section 7 (kg_demo_example_v2.pdf)
// ═══════════════════════════════════════════════════════════
// ============================================================

// Count nodes by label:
// MATCH (n) RETURN labels(n) AS label, count(n) AS count ORDER BY count DESC;

// Coverage query (Section 7.9):
// MATCH (d:Disorder)-[:MANIFESTS_AS]->(s:Symptom)
// OPTIONAL MATCH (s)-[:ASSOCIATED_WITH|CO_OCCURS_WITH|INDICATES|WORSENS|TRIGGERS*1..2]-(mid)
// WHERE mid:EmotionalState OR mid:Behaviour OR mid:CognitivePattern
// OPTIONAL MATCH (mid)<-[:RECOMMENDED_FOR]-(t:TherapeuticTechnique)
// WITH d, s, count(DISTINCT t) AS techniques
// WITH d, count(s) AS totalSymptoms, sum(CASE WHEN techniques > 0 THEN 1 ELSE 0 END) AS explainedSymptoms
// RETURN d.name AS disorder, totalSymptoms, explainedSymptoms,
//        round(100.0 * explainedSymptoms / totalSymptoms, 1) AS coveragePercentage
// ORDER BY coveragePercentage DESC;

// Explainability query (Section 4.4):
// MATCH path = (b:Behaviour {name:"AvoidanceBehaviour"})-[:WORSENS]->(e:EmotionalState)
// <-[:RECOMMENDED_FOR]-(t:TherapeuticTechnique)
// RETURN b.name AS behaviour, e.name AS emotion, t.name AS technique,
//        t.evidence_level AS evidence, path;

// Conflict detection (Section 7.8):
// MATCH (a)-[r1]->(b), (a)-[r2]->(b)
// WHERE type(r1) = type(r2) AND elementId(r1) < elementId(r2) AND r1.source <> r2.source
// RETURN a.name AS from, type(r1) AS relationship, b.name AS to,
//        r1.source AS source1, r2.source AS source2;
