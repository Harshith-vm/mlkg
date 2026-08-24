// ============================================================
// KG EXPANSION — 10 ADDITIONAL DISORDERS (making 15 total)
// For near-usable product grade MLKG
// Sources: NIMH, DSM-5, ICD-11, WHO, UMLS
//
// NEW DISORDERS:
//   6.  OCD (Obsessive-Compulsive Disorder)
//   7.  BPD (Borderline Personality Disorder)
//   8.  ComplexPTSD (ICD-11: 6B41)
//   9.  PersistentDepressiveDisorder (Dysthymia)
//   10. SpecificPhobia
//   11. BipolarIIDisorder
//   12. AnorexiaNervosa
//   13. BulimiaNervosa
//   14. AlcoholUseDisorder
//   15. ADHD (Adult)
// ============================================================

// ─────────────────────────────────────────────────────────────
// DISORDER NODES (10 new)
// ─────────────────────────────────────────────────────────────

MERGE (ocd:Disorder {name:"OCD"})
ON CREATE SET
  ocd.dsm_ref="300.3", ocd.icd10_ref="F42", ocd.icd11_ref="6B20",
  ocd.umls_cui="C0028768", ocd.snomed_id="191736004",
  ocd.description="OCD is characterised by the presence of obsessions and/or compulsions. Obsessions are repetitive, intrusive thoughts, images, or urges that cause marked anxiety. Compulsions are repetitive behaviours or mental acts performed to reduce distress.",
  ocd.source="NIMH + DSM-5 + WHO ICD-11", ocd.confidence=1.0, ocd.date_added=date();

MERGE (bpd:Disorder {name:"BorderlinePersonalityDisorder"})
ON CREATE SET
  bpd.dsm_ref="301.83", bpd.icd10_ref="F60.3", bpd.icd11_ref="6D11.5",
  bpd.umls_cui="C0006012", bpd.snomed_id="20010003",
  bpd.description="BPD is characterised by a pervasive pattern of instability in interpersonal relationships, self-image, and affect, with marked impulsivity. Key features include fear of abandonment, identity disturbance, self-harm, and emotional dysregulation.",
  bpd.source="NIMH + DSM-5 + WHO ICD-11", bpd.confidence=1.0, bpd.date_added=date();

MERGE (cptsd:Disorder {name:"ComplexPTSD"})
ON CREATE SET
  cptsd.dsm_ref="N/A", cptsd.icd10_ref="F43.1", cptsd.icd11_ref="6B41",
  cptsd.umls_cui="C0948008", cptsd.snomed_id="47505003",
  cptsd.description="Complex PTSD arises following prolonged, repeated traumatic events. In addition to PTSD core symptoms, it includes severe emotional dysregulation, negative self-concept, and disturbed relationships. It is a distinct entity in ICD-11 but not yet in DSM-5.",
  cptsd.source="WHO ICD-11 + NIMH", cptsd.confidence=1.0, cptsd.date_added=date();

MERGE (pdd:Disorder {name:"PersistentDepressiveDisorder"})
ON CREATE SET
  pdd.dsm_ref="300.4", pdd.icd10_ref="F34.1", pdd.icd11_ref="6A72",
  pdd.umls_cui="C0011581", pdd.snomed_id="35489007",
  pdd.description="Persistent depressive disorder (dysthymia) is characterised by depressed mood for at least 2 years (1 year in children/adolescents), with at least two additional depressive symptoms. Milder but more chronic than MDE.",
  pdd.source="NIMH + DSM-5 + WHO ICD-11", pdd.confidence=1.0, pdd.date_added=date();

MERGE (sph:Disorder {name:"SpecificPhobia"})
ON CREATE SET
  sph.dsm_ref="300.29", sph.icd10_ref="F40.2", sph.icd11_ref="6B03",
  sph.umls_cui="C0031572", sph.snomed_id="386810004",
  sph.description="Specific phobia is characterised by marked fear or anxiety about a specific object or situation (e.g., flying, heights, animals, blood) that is disproportionate to actual danger and leads to avoidance or intense distress.",
  sph.source="NIMH + DSM-5 + WHO ICD-11", sph.confidence=1.0, sph.date_added=date();

MERGE (bp2:Disorder {name:"BipolarIIDisorder"})
ON CREATE SET
  bp2.dsm_ref="296.89", bp2.icd10_ref="F31.8", bp2.icd11_ref="6A61",
  bp2.umls_cui="C0005586", bp2.snomed_id="191590005",
  bp2.description="Bipolar II disorder is characterised by at least one major depressive episode and at least one hypomanic episode, but no full manic episodes. Often misdiagnosed as unipolar depression. Mood stabilisers are the primary treatment, not antidepressants alone.",
  bp2.source="NIMH + DSM-5 + WHO ICD-11", bp2.confidence=1.0, bp2.date_added=date();

MERGE (anx_n:Disorder {name:"AnorexiaNervosa"})
ON CREATE SET
  anx_n.dsm_ref="307.1", anx_n.icd10_ref="F50.0", anx_n.icd11_ref="6B80",
  anx_n.umls_cui="C0003125", anx_n.snomed_id="56882008",
  anx_n.description="Anorexia nervosa is characterised by restricted energy intake, intense fear of weight gain, and disturbed body image. It has the highest mortality rate of any psychiatric disorder. Treatment requires medical stabilisation alongside CBT/FBT.",
  anx_n.source="NIMH + DSM-5 + WHO ICD-11", anx_n.confidence=1.0, anx_n.date_added=date();

MERGE (bul:Disorder {name:"BulimiaNervosa"})
ON CREATE SET
  bul.dsm_ref="307.51", bul.icd10_ref="F50.2", bul.icd11_ref="6B81",
  bul.umls_cui="C0006370", bul.snomed_id="78004001",
  bul.description="Bulimia nervosa is characterised by recurrent episodes of binge eating followed by compensatory behaviours (purging, fasting, excessive exercise) to prevent weight gain, accompanied by shame and guilt.",
  bul.source="NIMH + DSM-5 + WHO ICD-11", bul.confidence=1.0, bul.date_added=date();

MERGE (aud:Disorder {name:"AlcoholUseDisorder"})
ON CREATE SET
  aud.dsm_ref="303.90", aud.icd10_ref="F10.2", aud.icd11_ref="6C40.2",
  aud.umls_cui="C0001956", aud.snomed_id="7200002",
  aud.description="Alcohol use disorder is characterised by a pattern of alcohol use causing significant impairment or distress, including tolerance, withdrawal, loss of control, continued use despite harm, and craving. Highly comorbid with anxiety and depression.",
  aud.source="NIMH + DSM-5 + WHO ICD-11", aud.confidence=1.0, aud.date_added=date();

MERGE (adhd:Disorder {name:"ADHD"})
ON CREATE SET
  adhd.dsm_ref="314.01", adhd.icd10_ref="F90.0", adhd.icd11_ref="6A05",
  adhd.umls_cui="C1263846", adhd.snomed_id="406506008",
  adhd.description="Adult ADHD is characterised by persistent patterns of inattention and/or hyperactivity-impulsivity that interfere with functioning. In adults, hyperactivity may manifest as restlessness and difficulty relaxing. CBT and behavioural coaching are evidence-based alongside medication.",
  adhd.source="NIMH + DSM-5 + WHO ICD-11", adhd.confidence=1.0, adhd.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW SYMPTOMS for the 10 new disorders
// All sourced from NIMH clinical brochures
// ─────────────────────────────────────────────────────────────

// OCD symptoms
MERGE (s_obs:Symptom  {name:"Obsessions"})              ON CREATE SET s_obs.source="NIMH",  s_obs.confidence=1.0, s_obs.date_added=date();
MERGE (s_comp:Symptom {name:"Compulsions"})              ON CREATE SET s_comp.source="NIMH", s_comp.confidence=1.0, s_comp.date_added=date();
MERGE (s_eg:Symptom   {name:"EgoDistress"})              ON CREATE SET s_eg.source="NIMH",   s_eg.confidence=1.0,  s_eg.date_added=date();
MERGE (s_rr:Symptom   {name:"RepetitiveRituals"})        ON CREATE SET s_rr.source="NIMH",   s_rr.confidence=1.0,  s_rr.date_added=date();

// BPD symptoms
MERGE (s_foa:Symptom  {name:"FearOfAbandonment"})        ON CREATE SET s_foa.source="NIMH",  s_foa.confidence=1.0, s_foa.date_added=date();
MERGE (s_uid:Symptom  {name:"UnstableIdentity"})         ON CREATE SET s_uid.source="NIMH",  s_uid.confidence=1.0, s_uid.date_added=date();
MERGE (s_shr:Symptom  {name:"SelfHarmOrSuicidalBehaviour"}) ON CREATE SET s_shr.source="NIMH", s_shr.confidence=1.0, s_shr.date_added=date();
MERGE (s_edys:Symptom {name:"EmotionalDysregulation"})   ON CREATE SET s_edys.source="NIMH", s_edys.confidence=1.0, s_edys.date_added=date();
MERGE (s_imp:Symptom  {name:"Impulsivity"})              ON CREATE SET s_imp.source="NIMH",  s_imp.confidence=1.0, s_imp.date_added=date();
MERGE (s_par:Symptom  {name:"ParanoidIdeation"})         ON CREATE SET s_par.source="NIMH",  s_par.confidence=1.0, s_par.date_added=date();
MERGE (s_emp:Symptom  {name:"EmptinessOrVoidFeeling"})   ON CREATE SET s_emp.source="NIMH",  s_emp.confidence=1.0, s_emp.date_added=date();
MERGE (s_unst:Symptom {name:"UnstableIntenseRelationships"}) ON CREATE SET s_unst.source="NIMH", s_unst.confidence=1.0, s_unst.date_added=date();

// C-PTSD additional (beyond PTSD symptoms)
MERGE (s_nsc:Symptom  {name:"NegativeSelfConcept"})       ON CREATE SET s_nsc.source="WHO ICD-11", s_nsc.confidence=1.0, s_nsc.date_added=date();
MERGE (s_reldis:Symptom{name:"RelationshipDisturbances"}) ON CREATE SET s_reldis.source="WHO ICD-11",s_reldis.confidence=1.0, s_reldis.date_added=date();

// PDD (Dysthymia) symptoms
MERGE (s_lsi:Symptom  {name:"LowSelfImage"})              ON CREATE SET s_lsi.source="NIMH",  s_lsi.confidence=1.0, s_lsi.date_added=date();
MERGE (s_hop:Symptom  {name:"HopelessnessOrPessimism"})   ON CREATE SET s_hop.source="NIMH",  s_hop.confidence=1.0, s_hop.date_added=date();

// Specific Phobia symptoms
MERGE (s_pav:Symptom  {name:"PhobicAvoidance"})           ON CREATE SET s_pav.source="NIMH",  s_pav.confidence=1.0, s_pav.date_added=date();
MERGE (s_ipr:Symptom  {name:"ImmediatePanicResponse"})    ON CREATE SET s_ipr.source="NIMH",  s_ipr.confidence=1.0, s_ipr.date_added=date();

// Bipolar II symptoms
MERGE (s_hyp:Symptom  {name:"HypomanicEpisode"})          ON CREATE SET s_hyp.source="NIMH",  s_hyp.confidence=1.0, s_hyp.date_added=date();
MERGE (s_grd:Symptom  {name:"Grandiosity"})               ON CREATE SET s_grd.source="NIMH",  s_grd.confidence=1.0, s_grd.date_added=date();
MERGE (s_rsp:Symptom  {name:"ReducedSleepWithoutFatigue"})ON CREATE SET s_rsp.source="NIMH",  s_rsp.confidence=1.0, s_rsp.date_added=date();
MERGE (s_rth:Symptom  {name:"RacingThoughts"})            ON CREATE SET s_rth.source="NIMH",  s_rth.confidence=1.0, s_rth.date_added=date();

// Anorexia symptoms
MERGE (s_wres:Symptom {name:"WeightRestrictiveEating"})   ON CREATE SET s_wres.source="NIMH", s_wres.confidence=1.0, s_wres.date_added=date();
MERGE (s_bdi:Symptom  {name:"BodyDysmorphicImage"})       ON CREATE SET s_bdi.source="NIMH",  s_bdi.confidence=1.0, s_bdi.date_added=date();
MERGE (s_wfg:Symptom  {name:"IntenseWeightFearGain"})     ON CREATE SET s_wfg.source="NIMH",  s_wfg.confidence=1.0, s_wfg.date_added=date();

// Bulimia symptoms
MERGE (s_bng:Symptom  {name:"BingeEatingEpisodes"})       ON CREATE SET s_bng.source="NIMH",  s_bng.confidence=1.0, s_bng.date_added=date();
MERGE (s_pur:Symptom  {name:"CompensatoryPurgingBehaviour"}) ON CREATE SET s_pur.source="NIMH", s_pur.confidence=1.0, s_pur.date_added=date();
MERGE (s_shg:Symptom  {name:"ShameOrGuiltAfterBinge"})    ON CREATE SET s_shg.source="NIMH",  s_shg.confidence=1.0, s_shg.date_added=date();

// Alcohol Use Disorder symptoms
MERGE (s_crav:Symptom {name:"AlcoholCraving"})            ON CREATE SET s_crav.source="NIMH", s_crav.confidence=1.0, s_crav.date_added=date();
MERGE (s_tol:Symptom  {name:"AlcoholTolerance"})          ON CREATE SET s_tol.source="NIMH",  s_tol.confidence=1.0, s_tol.date_added=date();
MERGE (s_wdr:Symptom  {name:"WithdrawalSymptoms"})        ON CREATE SET s_wdr.source="NIMH",  s_wdr.confidence=1.0, s_wdr.date_added=date();
MERGE (s_loc:Symptom  {name:"LossOfControlOverUse"})      ON CREATE SET s_loc.source="NIMH",  s_loc.confidence=1.0, s_loc.date_added=date();

// ADHD symptoms
MERGE (s_inn:Symptom  {name:"Inattention"})               ON CREATE SET s_inn.source="NIMH",  s_inn.confidence=1.0, s_inn.date_added=date();
MERGE (s_hypa:Symptom {name:"Hyperactivity"})             ON CREATE SET s_hypa.source="NIMH", s_hypa.confidence=1.0, s_hypa.date_added=date();
MERGE (s_for:Symptom  {name:"Forgetfulness"})             ON CREATE SET s_for.source="NIMH",  s_for.confidence=1.0, s_for.date_added=date();
MERGE (s_org:Symptom  {name:"DifficultyOrganising"})      ON CREATE SET s_org.source="NIMH",  s_org.confidence=1.0, s_org.date_added=date();
MERGE (s_int:Symptom  {name:"Interrupting"})              ON CREATE SET s_int.source="NIMH",  s_int.confidence=1.0, s_int.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW THERAPEUTIC MODALITIES + TECHNIQUES
// ─────────────────────────────────────────────────────────────

// DBT (Dialectical Behaviour Therapy) — primary for BPD
MERGE (m_dbt:TherapeuticModality {name:"DialecticalBehaviourTherapy"})
ON CREATE SET m_dbt.phase="PhaseI", m_dbt.source="Linehan1993", m_dbt.confidence=1.0, m_dbt.date_added=date();

// EMDR (Eye Movement Desensitisation and Reprocessing) — PTSD/C-PTSD
MERGE (m_emdr:TherapeuticModality {name:"EMDR"})
ON CREATE SET m_emdr.phase="PhaseI", m_emdr.source="Shapiro1989", m_emdr.confidence=1.0, m_emdr.date_added=date();

// Motivational Interviewing — AUD
MERGE (m_mi:TherapeuticModality {name:"MotivationalInterviewing"})
ON CREATE SET m_mi.phase="PhaseI", m_mi.source="Miller/Rollnick2002", m_mi.confidence=1.0, m_mi.date_added=date();

// FBT (Family-Based Treatment) — eating disorders
MERGE (m_fbt:TherapeuticModality {name:"FamilyBasedTherapy"})
ON CREATE SET m_fbt.phase="PhaseI", m_fbt.source="Loeb/LeGrange2009", m_fbt.confidence=1.0, m_fbt.date_added=date();

// New Techniques
MERGE (t_erp:TherapeuticTechnique {name:"ExposureResponsePrevention"})
ON CREATE SET t_erp.evidence_level="strong", t_erp.source="NIMH+Rosa-Alcazar2008", t_erp.confidence=1.0, t_erp.date_added=date();

MERGE (t_dst:TherapeuticTechnique {name:"DistressToleranceSkills"})
ON CREATE SET t_dst.evidence_level="strong", t_dst.source="Linehan1993-DBT", t_dst.confidence=1.0, t_dst.date_added=date();

MERGE (t_emr:TherapeuticTechnique {name:"EMDRProcessing"})
ON CREATE SET t_emr.evidence_level="strong", t_emr.source="Shapiro1989+WHO2013", t_emr.confidence=1.0, t_emr.date_added=date();

MERGE (t_mir:TherapeuticTechnique {name:"MotivationalInterviewingTechnique"})
ON CREATE SET t_mir.evidence_level="strong", t_mir.source="Miller/Rollnick2002", t_mir.confidence=1.0, t_mir.date_added=date();

MERGE (t_mre:TherapeuticTechnique {name:"MindfulEating"})
ON CREATE SET t_mre.evidence_level="moderate", t_mre.source="Kristeller2015", t_mre.confidence=1.0, t_mre.date_added=date();

MERGE (t_emreg:TherapeuticTechnique {name:"EmotionRegulationSkills"})
ON CREATE SET t_emreg.evidence_level="strong", t_emreg.source="Linehan1993-DBT", t_emreg.confidence=1.0, t_emreg.date_added=date();

MERGE (t_ips:TherapeuticTechnique {name:"InterpersonalEffectiveness"})
ON CREATE SET t_ips.evidence_level="strong", t_ips.source="Linehan1993-DBT", t_ips.confidence=1.0, t_ips.date_added=date();

MERGE (t_bco:TherapeuticTechnique {name:"BehaviouralCoaching"})
ON CREATE SET t_bco.evidence_level="moderate", t_bco.source="NIMH-ADHD", t_bco.confidence=1.0, t_bco.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW EMOTIONAL STATES
// ─────────────────────────────────────────────────────────────
MERGE (e_emy:EmotionalState {name:"EmotionalDysregulation"})
ON CREATE SET e_emy.valence=-0.7, e_emy.arousal=0.8, e_emy.source="manually-curated+Linehan1993", e_emy.confidence=1.0, e_emy.date_added=date();

MERGE (e_emp:EmotionalState {name:"Emptiness"})
ON CREATE SET e_emp.valence=-0.8, e_emp.arousal=0.1, e_emp.source="manually-curated", e_emp.confidence=1.0, e_emp.date_added=date();

MERGE (e_crav2:EmotionalState {name:"Craving"})
ON CREATE SET e_crav2.valence=-0.3, e_crav2.arousal=0.7, e_crav2.source="manually-curated", e_crav2.confidence=1.0, e_crav2.date_added=date();

MERGE (e_elat:EmotionalState {name:"Elation"})
ON CREATE SET e_elat.valence=0.8, e_elat.arousal=0.9, e_elat.source="manually-curated", e_elat.confidence=1.0, e_elat.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW BEHAVIOURS
// ─────────────────────────────────────────────────────────────
MERGE (b_shb:Behaviour {name:"SelfHarmBehaviour"})
ON CREATE SET b_shb.source="NIMH", b_shb.confidence=1.0, b_shb.description="Deliberate self-harm (cutting, burning) as emotion regulation.", b_shb.date_added=date();

MERGE (b_bing:Behaviour {name:"BingeEating"})
ON CREATE SET b_bing.source="NIMH", b_bing.confidence=1.0, b_bing.description="Recurrent episodes of eating large amounts rapidly with loss of control.", b_bing.date_added=date();

MERGE (b_purg:Behaviour {name:"PurgingBehaviour"})
ON CREATE SET b_purg.source="NIMH", b_purg.confidence=1.0, b_purg.description="Compensatory behaviours: self-induced vomiting, laxatives, excessive exercise.", b_purg.date_added=date();

MERGE (b_alc:Behaviour {name:"AlcoholUse"})
ON CREATE SET b_alc.source="NIMH", b_alc.confidence=1.0, b_alc.description="Alcohol consumption used as self-medication for anxiety/depression.", b_alc.date_added=date();

MERGE (b_comp:Behaviour {name:"CompulsiveChecking"})
ON CREATE SET b_comp.source="NIMH", b_comp.confidence=1.0, b_comp.description="Compulsive checking, counting, or ordering rituals to reduce obsessional distress.", b_comp.date_added=date();

MERGE (b_imp:Behaviour {name:"ImpulsiveDecisions"})
ON CREATE SET b_imp.source="NIMH", b_imp.confidence=1.0, b_imp.description="Acting on impulse without considering consequences — common in BPD and ADHD.", b_imp.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW CONTEXT CATEGORIES
// ─────────────────────────────────────────────────────────────
MERGE (ctx_fi:ContextCategory {name:"FinancialInstability"}) ON CREATE SET ctx_fi.domain="economic", ctx_fi.source="manually-curated", ctx_fi.confidence=0.9, ctx_fi.date_added=date();
MERGE (ctx_so:ContextCategory {name:"SocialRejection"})      ON CREATE SET ctx_so.domain="interpersonal", ctx_so.source="manually-curated", ctx_so.confidence=0.9, ctx_so.date_added=date();
MERGE (ctx_ab:ContextCategory {name:"ChildhoodAbuse"})       ON CREATE SET ctx_ab.domain="trauma", ctx_ab.source="WHO ICD-11", ctx_ab.confidence=1.0, ctx_ab.date_added=date();
MERGE (ctx_ac:ContextCategory {name:"AcademicPressure"})     ON CREATE SET ctx_ac.domain="academic", ctx_ac.source="manually-curated", ctx_ac.confidence=0.8, ctx_ac.date_added=date();

// ─────────────────────────────────────────────────────────────
// RELATIONSHIPS — new disorders → symptoms (MANIFESTS_AS)
// ─────────────────────────────────────────────────────────────

// OCD
MATCH (ocd:Disorder{name:"OCD"})
MATCH (s_obs:Symptom{name:"Obsessions"}), (s_comp:Symptom{name:"Compulsions"}),
      (s_eg:Symptom{name:"EgoDistress"}), (s_rr:Symptom{name:"RepetitiveRituals"}),
      (s_anx:Symptom{name:"Restlessness"}), (s_ins:Symptom{name:"Insomnia"})
MERGE (ocd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_obs)
MERGE (ocd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_comp)
MERGE (ocd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_eg)
MERGE (ocd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_rr)
MERGE (ocd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_anx)
MERGE (ocd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_ins);

// BPD
MATCH (bpd:Disorder{name:"BorderlinePersonalityDisorder"})
MATCH (s_foa:Symptom{name:"FearOfAbandonment"}), (s_uid:Symptom{name:"UnstableIdentity"}),
      (s_shr:Symptom{name:"SelfHarmOrSuicidalBehaviour"}), (s_edys:Symptom{name:"EmotionalDysregulation"}),
      (s_imp:Symptom{name:"Impulsivity"}), (s_par:Symptom{name:"ParanoidIdeation"}),
      (s_emp:Symptom{name:"EmptinessOrVoidFeeling"}), (s_unst:Symptom{name:"UnstableIntenseRelationships"})
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_foa)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_uid)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_shr)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_edys)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_imp)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_par)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_emp)
MERGE (bpd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_unst);

// Complex PTSD (reuses PTSD symptoms + adds 2 new)
MATCH (cptsd:Disorder{name:"ComplexPTSD"})
MATCH (s_flb:Symptom{name:"Flashbacks"}), (s_nig:Symptom{name:"Nightmares"}),
      (s_dto:Symptom{name:"DistressingThoughtsOrMemories"}), (s_edys:Symptom{name:"EmotionalDysregulation"}),
      (s_nsc:Symptom{name:"NegativeSelfConcept"}), (s_reldis:Symptom{name:"RelationshipDisturbances"}),
      (s_atr:Symptom{name:"AvoidingTraumaReminders"}), (s_ins:Symptom{name:"Insomnia"})
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_flb)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_nig)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_dto)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_edys)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_nsc)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_reldis)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_atr)
MERGE (cptsd)-[:MANIFESTS_AS {frequency:"common",    source:"WHO ICD-11"}]->(s_ins);

// PDD (Dysthymia) — reuses MDE symptoms mostly
MATCH (pdd:Disorder{name:"PersistentDepressiveDisorder"})
MATCH (s_psm:Symptom{name:"PersistentSadMood"}), (s_lsi:Symptom{name:"LowSelfImage"}),
      (s_hop:Symptom{name:"HopelessnessOrPessimism"}), (s_fat:Symptom{name:"Fatigue"}),
      (s_ins:Symptom{name:"Insomnia"}), (s_dc:Symptom{name:"DifficultyConcentrating"}),
      (s_awc:Symptom{name:"AppetiteOrWeightChanges"})
MERGE (pdd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_psm)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_lsi)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_hop)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_fat)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_ins)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_dc)
MERGE (pdd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_awc);

// Specific Phobia
MATCH (sph:Disorder{name:"SpecificPhobia"})
MATCH (s_pav:Symptom{name:"PhobicAvoidance"}), (s_ipr:Symptom{name:"ImmediatePanicResponse"}),
      (s_fea2:Symptom{name:"FearOfDying"}), (s_palp:Symptom{name:"PalpitationsOrRacingHeart"}),
      (s_sw:Symptom{name:"SweatingOrLightheadedness"})
MERGE (sph)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_pav)
MERGE (sph)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_ipr)
MERGE (sph)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_fea2)
MERGE (sph)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_palp)
MERGE (sph)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_sw);

// Bipolar II
MATCH (bp2:Disorder{name:"BipolarIIDisorder"})
MATCH (s_hyp:Symptom{name:"HypomanicEpisode"}), (s_grd:Symptom{name:"Grandiosity"}),
      (s_rsp:Symptom{name:"ReducedSleepWithoutFatigue"}), (s_rth:Symptom{name:"RacingThoughts"}),
      (s_psm:Symptom{name:"PersistentSadMood"}), (s_de:Symptom{name:"DecreasedEnergy"}),
      (s_imp:Symptom{name:"Impulsivity"})
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_hyp)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_grd)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_rsp)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_rth)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_psm)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_de)
MERGE (bp2)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_imp);

// Anorexia
MATCH (anx_n:Disorder{name:"AnorexiaNervosa"})
MATCH (s_wres:Symptom{name:"WeightRestrictiveEating"}), (s_bdi:Symptom{name:"BodyDysmorphicImage"}),
      (s_wfg:Symptom{name:"IntenseWeightFearGain"}), (s_fat:Symptom{name:"Fatigue"}),
      (s_ins:Symptom{name:"Insomnia"}), (s_de:Symptom{name:"DecreasedEnergy"})
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_wres)
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_bdi)
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_wfg)
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_fat)
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_ins)
MERGE (anx_n)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_de);

// Bulimia
MATCH (bul:Disorder{name:"BulimiaNervosa"})
MATCH (s_bng:Symptom{name:"BingeEatingEpisodes"}), (s_pur:Symptom{name:"CompensatoryPurgingBehaviour"}),
      (s_shg:Symptom{name:"ShameOrGuiltAfterBinge"}), (s_gwh:Symptom{name:"GuiltWorthlessnessOrHelplessness"}),
      (s_bdi:Symptom{name:"BodyDysmorphicImage"})
MERGE (bul)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_bng)
MERGE (bul)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_pur)
MERGE (bul)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_shg)
MERGE (bul)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_gwh)
MERGE (bul)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_bdi);

// Alcohol Use Disorder
MATCH (aud:Disorder{name:"AlcoholUseDisorder"})
MATCH (s_crav:Symptom{name:"AlcoholCraving"}), (s_tol:Symptom{name:"AlcoholTolerance"}),
      (s_wdr:Symptom{name:"WithdrawalSymptoms"}), (s_loc:Symptom{name:"LossOfControlOverUse"}),
      (s_ins:Symptom{name:"Insomnia"}), (s_dc:Symptom{name:"DifficultyConcentrating"})
MERGE (aud)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_crav)
MERGE (aud)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_tol)
MERGE (aud)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_wdr)
MERGE (aud)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_loc)
MERGE (aud)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_ins)
MERGE (aud)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_dc);

// ADHD
MATCH (adhd:Disorder{name:"ADHD"})
MATCH (s_inn:Symptom{name:"Inattention"}), (s_hypa:Symptom{name:"Hyperactivity"}),
      (s_for:Symptom{name:"Forgetfulness"}), (s_org:Symptom{name:"DifficultyOrganising"}),
      (s_int:Symptom{name:"Interrupting"}), (s_rst:Symptom{name:"Restlessness"}),
      (s_dc:Symptom{name:"DifficultyConcentrating"})
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_inn)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_hypa)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_for)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_org)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"occasional",source:"NIMH"}]->(s_int)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_rst)
MERGE (adhd)-[:MANIFESTS_AS {frequency:"common",    source:"NIMH"}]->(s_dc);

// ─────────────────────────────────────────────────────────────
// NEW THERAPEUTIC RELATIONSHIPS
// ─────────────────────────────────────────────────────────────

// ERP → OCD
MATCH (t_erp:TherapeuticTechnique{name:"ExposureResponsePrevention"}),(ocd:Disorder{name:"OCD"})
MATCH (s_comp:Symptom{name:"Compulsions"}), (s_obs:Symptom{name:"Obsessions"})
MERGE (t_erp)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH+Rosa-Alcazar2008"}]->(s_comp)
MERGE (t_erp)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH+Rosa-Alcazar2008"}]->(s_obs);

MATCH (t_erp:TherapeuticTechnique{name:"ExposureResponsePrevention"}),(m_cbt:TherapeuticModality{name:"CBT"})
MERGE (t_erp)-[:BELONGS_TO]->(m_cbt);

// DBT techniques → BPD
MATCH (t_dst:TherapeuticTechnique{name:"DistressToleranceSkills"}),(m_dbt:TherapeuticModality{name:"DialecticalBehaviourTherapy"})
MERGE (t_dst)-[:BELONGS_TO]->(m_dbt);
MATCH (t_emreg:TherapeuticTechnique{name:"EmotionRegulationSkills"}),(m_dbt:TherapeuticModality{name:"DialecticalBehaviourTherapy"})
MERGE (t_emreg)-[:BELONGS_TO]->(m_dbt);
MATCH (t_ips:TherapeuticTechnique{name:"InterpersonalEffectiveness"}),(m_dbt:TherapeuticModality{name:"DialecticalBehaviourTherapy"})
MERGE (t_ips)-[:BELONGS_TO]->(m_dbt);

MATCH (t_dst:TherapeuticTechnique{name:"DistressToleranceSkills"}),(e_emy:EmotionalState{name:"EmotionalDysregulation"})
MERGE (t_dst)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Linehan1993"}]->(e_emy);
MATCH (t_emreg:TherapeuticTechnique{name:"EmotionRegulationSkills"}),(e_emy:EmotionalState{name:"EmotionalDysregulation"})
MERGE (t_emreg)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Linehan1993"}]->(e_emy);

// EMDR → PTSD / C-PTSD
MATCH (t_emr:TherapeuticTechnique{name:"EMDRProcessing"}),(m_emdr:TherapeuticModality{name:"EMDR"})
MERGE (t_emr)-[:BELONGS_TO]->(m_emdr);
MATCH (t_emr:TherapeuticTechnique{name:"EMDRProcessing"}),(e_fea:EmotionalState{name:"Fear"})
MERGE (t_emr)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Shapiro1989+WHO2013"}]->(e_fea);

// MI → AUD
MATCH (t_mir:TherapeuticTechnique{name:"MotivationalInterviewingTechnique"}),(m_mi:TherapeuticModality{name:"MotivationalInterviewing"})
MERGE (t_mir)-[:BELONGS_TO]->(m_mi);
MATCH (t_mir:TherapeuticTechnique{name:"MotivationalInterviewingTechnique"}),(b_alc:Behaviour{name:"AlcoholUse"})
MERGE (t_mir)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Miller/Rollnick2002"}]->(b_alc);

// MindfulEating → Bulimia/Anorexia
MATCH (t_mre:TherapeuticTechnique{name:"MindfulEating"}),(m_act:TherapeuticModality{name:"AcceptanceAndCommitmentTherapy"})
MERGE (t_mre)-[:BELONGS_TO]->(m_act);
MATCH (t_mre:TherapeuticTechnique{name:"MindfulEating"}),(b_bing:Behaviour{name:"BingeEating"})
MERGE (t_mre)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:2, source:"Kristeller2015"}]->(b_bing);

// BehaviouralCoaching → ADHD
MATCH (t_bco:TherapeuticTechnique{name:"BehaviouralCoaching"}),(m_cbt:TherapeuticModality{name:"CBT"})
MERGE (t_bco)-[:BELONGS_TO]->(m_cbt);
MATCH (t_bco:TherapeuticTechnique{name:"BehaviouralCoaching"}),(s_org:Symptom{name:"DifficultyOrganising"})
MERGE (t_bco)-[:RECOMMENDED_FOR {evidence_level:"moderate", priority:1, source:"NIMH-ADHD"}]->(s_org);

// ─────────────────────────────────────────────────────────────
// CONTEXT TRIGGERS (new)
// ─────────────────────────────────────────────────────────────
MATCH (ctx_ab:ContextCategory{name:"ChildhoodAbuse"}),(e_fea:EmotionalState{name:"Fear"})
MERGE (ctx_ab)-[:TRIGGERS {strength:0.9, source:"WHO ICD-11"}]->(e_fea);

MATCH (ctx_so:ContextCategory{name:"SocialRejection"}),(e_sha:EmotionalState{name:"Shame"})
MERGE (ctx_so)-[:TRIGGERS {strength:0.8, source:"manually-curated"}]->(e_sha);

MATCH (ctx_ac:ContextCategory{name:"AcademicPressure"}),(e_anx:EmotionalState{name:"Anxiety"})
MERGE (ctx_ac)-[:TRIGGERS {strength:0.7, source:"manually-curated"}]->(e_anx);

MATCH (ctx_fi:ContextCategory{name:"FinancialInstability"}),(e_anx:EmotionalState{name:"Anxiety"})
MERGE (ctx_fi)-[:TRIGGERS {strength:0.65, source:"manually-curated"}]->(e_anx);

// WORSENS (new behaviours)
MATCH (b_shb:Behaviour{name:"SelfHarmBehaviour"}),(e_emy:EmotionalState{name:"EmotionalDysregulation"})
MERGE (b_shb)-[:WORSENS {source:"NIMH+Linehan1993"}]->(e_emy);
MATCH (b_bing:Behaviour{name:"BingeEating"}),(e_sha:EmotionalState{name:"Shame"})
MERGE (b_bing)-[:WORSENS {source:"NIMH"}]->(e_sha);
MATCH (b_alc:Behaviour{name:"AlcoholUse"}),(e_anx:EmotionalState{name:"Anxiety"})
MERGE (b_alc)-[:WORSENS {source:"NIMH"}]->(e_anx);
MATCH (b_comp:Behaviour{name:"CompulsiveChecking"}),(e_anx:EmotionalState{name:"Anxiety"})
MERGE (b_comp)-[:WORSENS {source:"NIMH+OCD-literature"}]->(e_anx);
