// ============================================================
// KG EXPANSION 2 — 6 EDGE CASE DISORDERS (making 21 total)
// ============================================================

// ─────────────────────────────────────────────────────────────
// DISORDER NODES
// ─────────────────────────────────────────────────────────────

MERGE (ppd:Disorder {name:"PostpartumDepression"})
ON CREATE SET ppd.dsm_ref="296.2x", ppd.icd11_ref="6E20", ppd.description="A major depressive episode with peripartum onset, occurring during pregnancy or within the 4 weeks following delivery. Includes severe mood swings, crying spells, and difficulty bonding with the baby.", ppd.source="NIMH + DSM-5", ppd.confidence=1.0, ppd.date_added=date();

MERGE (ins:Disorder {name:"InsomniaDisorder"})
ON CREATE SET ins.dsm_ref="780.52", ins.icd11_ref="7A00", ins.description="A predominant complaint of dissatisfaction with sleep quantity or quality, associated with difficulty initiating sleep, maintaining sleep, or early-morning awakening.", ins.source="NIMH + DSM-5", ins.confidence=1.0, ins.date_added=date();

MERGE (iad:Disorder {name:"IllnessAnxietyDisorder"})
ON CREATE SET iad.dsm_ref="300.7", iad.icd11_ref="6B23", iad.description="Preoccupation with having or acquiring a serious illness. Somatic symptoms are not present or, if present, are only mild in intensity. High level of anxiety about health.", iad.source="NIMH + DSM-5", iad.confidence=1.0, iad.date_added=date();

MERGE (bdd:Disorder {name:"BodyDysmorphicDisorder"})
ON CREATE SET bdd.dsm_ref="300.3", bdd.icd11_ref="6B21", bdd.description="Preoccupation with one or more perceived defects or flaws in physical appearance that are not observable or appear slight to others. Often accompanied by repetitive checking behaviours.", bdd.source="NIMH + DSM-5", bdd.confidence=1.0, bdd.date_added=date();

MERGE (sad:Disorder {name:"SeasonalAffectiveDisorder"})
ON CREATE SET sad.dsm_ref="296.3x", sad.icd11_ref="6A71", sad.description="Major depressive disorder with a seasonal pattern. Usually begins in autumn/winter and remits in spring. Characterised by hypersomnia, overeating, and lethargy.", sad.source="NIMH + DSM-5", sad.confidence=1.0, sad.date_added=date();

MERGE (pmdd:Disorder {name:"PMDD"})
ON CREATE SET pmdd.dsm_ref="625.4", pmdd.icd11_ref="GA34.41", pmdd.description="Premenstrual Dysphoric Disorder. Expression of mood lability, irritability, dysphoria, and anxiety symptoms that occur repeatedly during the premenstrual phase of the cycle.", pmdd.source="NIMH + DSM-5", pmdd.confidence=1.0, pmdd.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW SYMPTOMS
// ─────────────────────────────────────────────────────────────
MERGE (s_db:Symptom {name:"DifficultyBondingWithBaby"}) ON CREATE SET s_db.source="NIMH", s_db.confidence=1.0, s_db.date_added=date();
MERGE (s_sms:Symptom {name:"SevereMoodSwings"}) ON CREATE SET s_sms.source="NIMH", s_sms.confidence=1.0, s_sms.date_added=date();
MERGE (s_fh:Symptom {name:"FearOfHavingSeriousDisease"}) ON CREATE SET s_fh.source="NIMH", s_fh.confidence=1.0, s_fh.date_added=date();
MERGE (s_hc:Symptom {name:"RepeatedHealthChecking"}) ON CREATE SET s_hc.source="NIMH", s_hc.confidence=1.0, s_hc.date_added=date();
MERGE (s_pad:Symptom {name:"PerceivedAppearanceDefect"}) ON CREATE SET s_pad.source="NIMH", s_pad.confidence=1.0, s_pad.date_added=date();
MERGE (s_cam:Symptom {name:"CamouflagingBehaviour"}) ON CREATE SET s_cam.source="NIMH", s_cam.confidence=1.0, s_cam.date_added=date();
MERGE (s_wl:Symptom {name:"WinterLethargy"}) ON CREATE SET s_wl.source="NIMH", s_wl.confidence=1.0, s_wl.date_added=date();
MERGE (s_cc:Symptom {name:"CarbohydrateCraving"}) ON CREATE SET s_cc.source="NIMH", s_cc.confidence=1.0, s_cc.date_added=date();
MERGE (s_pmi:Symptom {name:"PreMenstrualIrritability"}) ON CREATE SET s_pmi.source="NIMH", s_pmi.confidence=1.0, s_pmi.date_added=date();
MERGE (s_bt:Symptom {name:"BreastTenderness"}) ON CREATE SET s_bt.source="NIMH", s_bt.confidence=1.0, s_bt.date_added=date();
MERGE (s_dis:Symptom {name:"DifficultyInitiatingSleep"}) ON CREATE SET s_dis.source="NIMH", s_dis.confidence=1.0, s_dis.date_added=date();
MERGE (s_dms:Symptom {name:"DifficultyMaintainingSleep"}) ON CREATE SET s_dms.source="NIMH", s_dms.confidence=1.0, s_dms.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW CONTEXT CATEGORIES
// ─────────────────────────────────────────────────────────────
MERGE (c_cb:ContextCategory {name:"Childbirth"}) ON CREATE SET c_cb.domain="medical", c_cb.source="manually-curated", c_cb.confidence=1.0, c_cb.date_added=date();
MERGE (c_sc:ContextCategory {name:"SeasonalChange"}) ON CREATE SET c_sc.domain="environmental", c_sc.source="manually-curated", c_sc.confidence=1.0, c_sc.date_added=date();
MERGE (c_hf:ContextCategory {name:"HormonalFluctuation"}) ON CREATE SET c_hf.domain="biological", c_hf.source="manually-curated", c_hf.confidence=1.0, c_hf.date_added=date();
MERGE (c_cmc:ContextCategory {name:"ChronicMedicalCondition"}) ON CREATE SET c_cmc.domain="medical", c_cmc.source="manually-curated", c_cmc.confidence=1.0, c_cmc.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW THERAPEUTIC MODALITIES & TECHNIQUES
// ─────────────────────────────────────────────────────────────
MERGE (m_cbti:TherapeuticModality {name:"CBT-I"}) ON CREATE SET m_cbti.phase="PhaseI", m_cbti.source="Perlis2005", m_cbti.confidence=1.0, m_cbti.date_added=date();

MERGE (t_sh:TherapeuticTechnique {name:"SleepHygiene"}) ON CREATE SET t_sh.evidence_level="moderate", t_sh.source="Perlis2005", t_sh.confidence=1.0, t_sh.date_added=date();
MERGE (t_sc:TherapeuticTechnique {name:"StimulusControl"}) ON CREATE SET t_sc.evidence_level="strong", t_sc.source="Perlis2005", t_sc.confidence=1.0, t_sc.date_added=date();
MERGE (t_sr:TherapeuticTechnique {name:"SleepRestriction"}) ON CREATE SET t_sr.evidence_level="strong", t_sr.source="Perlis2005", t_sr.confidence=1.0, t_sr.date_added=date();
MERGE (t_lt:TherapeuticTechnique {name:"LightTherapy"}) ON CREATE SET t_lt.evidence_level="strong", t_lt.source="Rosenthal1984", t_lt.confidence=1.0, t_lt.date_added=date();

// ─────────────────────────────────────────────────────────────
// NEW BEHAVIOURS
// ─────────────────────────────────────────────────────────────
MERGE (b_nbp:Behaviour {name:"NonBedtimePoorSleepHabits"}) ON CREATE SET b_nbp.source="manually-curated", b_nbp.confidence=1.0, b_nbp.description="Using phone in bed, irregular sleep schedule.", b_nbp.date_added=date();
MERGE (b_mr:Behaviour {name:"MedicalReassuranceSeeking"}) ON CREATE SET b_mr.source="manually-curated", b_mr.confidence=1.0, b_mr.description="Constantly visiting doctors or googling symptoms.", b_mr.date_added=date();

// ─────────────────────────────────────────────────────────────
// RELATIONSHIPS
// ─────────────────────────────────────────────────────────────
// Modalities to Techniques
MATCH (m_cbti:TherapeuticModality{name:"CBT-I"})
MATCH (t_sh:TherapeuticTechnique{name:"SleepHygiene"}), (t_sc:TherapeuticTechnique{name:"StimulusControl"}), (t_sr:TherapeuticTechnique{name:"SleepRestriction"})
MERGE (t_sh)-[:BELONGS_TO]->(m_cbti)
MERGE (t_sc)-[:BELONGS_TO]->(m_cbti)
MERGE (t_sr)-[:BELONGS_TO]->(m_cbti);

// Context -> Emotion / Disorder Triggers
MATCH (c_cb:ContextCategory{name:"Childbirth"}), (e_sad:EmotionalState{name:"Sadness"}) MERGE (c_cb)-[:TRIGGERS {strength:0.8, source:"NIMH"}]->(e_sad);
MATCH (c_sc:ContextCategory{name:"SeasonalChange"}), (e_sad:EmotionalState{name:"Sadness"}) MERGE (c_sc)-[:TRIGGERS {strength:0.8, source:"NIMH"}]->(e_sad);
MATCH (c_hf:ContextCategory{name:"HormonalFluctuation"}), (e_ang:EmotionalState{name:"Anger"}) MERGE (c_hf)-[:TRIGGERS {strength:0.7, source:"NIMH"}]->(e_ang);
MATCH (c_cmc:ContextCategory{name:"ChronicMedicalCondition"}), (e_anx:EmotionalState{name:"Anxiety"}) MERGE (c_cmc)-[:TRIGGERS {strength:0.8, source:"NIMH"}]->(e_anx);

// Disorder Manifestations
// PPD
MATCH (ppd:Disorder{name:"PostpartumDepression"})
MATCH (s_db:Symptom{name:"DifficultyBondingWithBaby"}), (s_sms:Symptom{name:"SevereMoodSwings"}), (s_psm:Symptom{name:"PersistentSadMood"}), (s_ins:Symptom{name:"Insomnia"})
MERGE (ppd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_db)
MERGE (ppd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_sms)
MERGE (ppd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_psm)
MERGE (ppd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_ins);

// Insomnia
MATCH (ins:Disorder{name:"InsomniaDisorder"})
MATCH (s_dis:Symptom{name:"DifficultyInitiatingSleep"}), (s_dms:Symptom{name:"DifficultyMaintainingSleep"}), (s_fat:Symptom{name:"Fatigue"})
MERGE (ins)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_dis)
MERGE (ins)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_dms)
MERGE (ins)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_fat);

// IAD
MATCH (iad:Disorder{name:"IllnessAnxietyDisorder"})
MATCH (s_fh:Symptom{name:"FearOfHavingSeriousDisease"}), (s_hc:Symptom{name:"RepeatedHealthChecking"}), (s_anx:Symptom{name:"Restlessness"})
MERGE (iad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_fh)
MERGE (iad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_hc)
MERGE (iad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_anx);

// BDD
MATCH (bdd:Disorder{name:"BodyDysmorphicDisorder"})
MATCH (s_pad:Symptom{name:"PerceivedAppearanceDefect"}), (s_cam:Symptom{name:"CamouflagingBehaviour"}), (s_comp:Symptom{name:"Compulsions"})
MERGE (bdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_pad)
MERGE (bdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_cam)
MERGE (bdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_comp);

// SAD (Seasonal)
MATCH (sad:Disorder{name:"SeasonalAffectiveDisorder"})
MATCH (s_wl:Symptom{name:"WinterLethargy"}), (s_cc:Symptom{name:"CarbohydrateCraving"}), (s_psm:Symptom{name:"PersistentSadMood"}), (s_fat:Symptom{name:"Fatigue"})
MERGE (sad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_wl)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_cc)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_psm)
MERGE (sad)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_fat);

// PMDD
MATCH (pmdd:Disorder{name:"PMDD"})
MATCH (s_pmi:Symptom{name:"PreMenstrualIrritability"}), (s_bt:Symptom{name:"BreastTenderness"}), (s_sms:Symptom{name:"SevereMoodSwings"})
MERGE (pmdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_pmi)
MERGE (pmdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_bt)
MERGE (pmdd)-[:MANIFESTS_AS {frequency:"common", source:"NIMH"}]->(s_sms);

// Recommendations
MATCH (t_sc:TherapeuticTechnique{name:"StimulusControl"}), (s_dis:Symptom{name:"DifficultyInitiatingSleep"})
MERGE (t_sc)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Perlis2005"}]->(s_dis);
MATCH (t_sr:TherapeuticTechnique{name:"SleepRestriction"}), (s_dms:Symptom{name:"DifficultyMaintainingSleep"})
MERGE (t_sr)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Perlis2005"}]->(s_dms);
MATCH (t_lt:TherapeuticTechnique{name:"LightTherapy"}), (sad:Disorder{name:"SeasonalAffectiveDisorder"})
MERGE (t_lt)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"Rosenthal1984"}]->(sad);
MATCH (t_erp:TherapeuticTechnique{name:"ExposureResponsePrevention"}), (s_pad:Symptom{name:"PerceivedAppearanceDefect"})
MERGE (t_erp)-[:RECOMMENDED_FOR {evidence_level:"strong", priority:1, source:"NIMH"}]->(s_pad);

// Worsens / Indicates
MATCH (b_nbp:Behaviour{name:"NonBedtimePoorSleepHabits"}), (s_dis:Symptom{name:"DifficultyInitiatingSleep"})
MERGE (b_nbp)-[:WORSENS {source:"Perlis2005"}]->(s_dis);
MATCH (b_mr:Behaviour{name:"MedicalReassuranceSeeking"}), (iad:Disorder{name:"IllnessAnxietyDisorder"})
MERGE (b_mr)-[:INDICATES {confidence:0.8, source:"NIMH"}]->(iad);
