# Test Values Reference for Diabetes Diagnosis Expert System

This document provides comprehensive test values for all five diagnostic categories supported by the system.

## Diagnostic Categories

### 1. HEALTHY (Normal Glucose Control)

**Diagnostic Criteria:**
- FPG < 100 mg/dL (normal fasting glucose)
- HbA1c < 5.7% (normal glycated hemoglobin)

| Test ID | Patient ID | FPG (mg/dL) | HbA1c (%) | Type-1 Indicators | Expected Result |
|---------|------------|-------------|-----------|-------------------|-----------------|
| H-001   | P_Healthy_001 | 90.0 | 5.5 | no | **Healthy** |
| H-002   | P_Healthy_002 | 80.0 | 5.0 | no | **Healthy** |
| H-003   | P_Healthy_003 | 95.0 | 5.6 | no | **Healthy** |
| H-004   | P_Healthy_004 | 99.0 | 5.6 | no | **Healthy** |
| H-005   | P_Healthy_005 | 85.0 | 5.2 | no | **Healthy** |

---

### 2. PREDIABETES (Impaired Fasting Glucose or Impaired A1c)

**Diagnostic Criteria:**
- (FPG 100-125 mg/dL OR HbA1c 5.7-6.4%)
- AND NOT both in diabetic range
- AND NOT discordant (one diabetic, one non-diabetic)

| Test ID | Patient ID | FPG (mg/dL) | HbA1c (%) | Type-1 Indicators | Expected Result |
|---------|------------|-------------|-----------|-------------------|-----------------|
| P-001   | P_Predia_001 | 110.0 | 5.5 | no | **Prediabetes** |
| P-002   | P_Predia_002 | 95.0 | 6.0 | no | **Prediabetes** |
| P-003   | P_Predia_003 | 110.0 | 6.0 | no | **Prediabetes** |
| P-004   | P_Predia_004 | 125.0 | 5.8 | no | **Prediabetes** |
| P-005   | P_Predia_005 | 100.0 | 5.7 | no | **Prediabetes** |
| P-006   | P_Predia_006 | 115.0 | 5.9 | no | **Prediabetes** |
| P-007   | P_Predia_007 | 105.0 | 6.3 | no | **Prediabetes** |

---

### 3. INCONCLUSIVE (Discordant Biomarkers)

**Diagnostic Criteria:**
- One biomarker in diabetic range (≥126 FPG or ≥6.5 HbA1c)
- One biomarker NOT in diabetic range (normal or prediabetic)
- Requires repeat testing and clinical correlation

| Test ID | Patient ID | FPG (mg/dL) | HbA1c (%) | Type-1 Indicators | Expected Result |
|---------|------------|-------------|-----------|-------------------|-----------------|
| I-001   | P_Inconclusive_001 | 140.0 | 6.2 | no | **Inconclusive** |
| I-002   | P_Inconclusive_002 | 150.0 | 5.5 | no | **Inconclusive** |
| I-003   | P_Inconclusive_003 | 110.0 | 7.0 | no | **Inconclusive** |
| I-004   | P_Inconclusive_004 | 200.0 | 6.3 | no | **Inconclusive** |
| I-005   | P_Inconclusive_005 | 130.0 | 5.9 | no | **Inconclusive** |
| I-006   | P_Inconclusive_006 | 180.0 | 6.1 | no | **Inconclusive** |
| I-007   | P_Inconclusive_007 | 120.0 | 6.7 | no | **Inconclusive** |

---

### 4. TYPE-2-DIABETES (Adult-Onset Diabetes)

**Diagnostic Criteria:**
- FPG ≥ 126 mg/dL (high fasting glucose)
- AND HbA1c ≥ 6.5% (high glycated hemoglobin)
- AND type-1-indicators = no (no autoimmune/early-onset markers)

| Test ID | Patient ID | FPG (mg/dL) | HbA1c (%) | Type-1 Indicators | Expected Result |
|---------|------------|-------------|-----------|-------------------|-----------------|
| T2-001  | P_Type2_001 | 135.0 | 7.2 | no | **Type-2-Diabetes** |
| T2-002  | P_Type2_002 | 180.0 | 6.8 | no | **Type-2-Diabetes** |
| T2-003  | P_Type2_003 | 126.0 | 6.5 | no | **Type-2-Diabetes** |
| T2-004  | P_Type2_004 | 200.0 | 9.0 | no | **Type-2-Diabetes** |
| T2-005  | P_Type2_005 | 250.0 | 8.5 | no | **Type-2-Diabetes** |
| T2-006  | P_Type2_006 | 140.0 | 7.0 | no | **Type-2-Diabetes** |
| T2-007  | P_Type2_007 | 160.0 | 7.5 | no | **Type-2-Diabetes** |

---

### 5. TYPE-1-DIABETES (Autoimmune Diabetes)

**Diagnostic Criteria:**
- FPG ≥ 126 mg/dL (high fasting glucose)
- AND HbA1c ≥ 6.5% (high glycated hemoglobin)
- AND type-1-indicators = yes (family history, early onset, or autoimmune markers present)

**Note:** In this educational system, Type-1 indicators are provided by user input (yes/no). In clinical practice, Type-1 diabetes is confirmed by:
- C-peptide levels (low or absent)
- Autoimmune antibodies (GAD, IA-2, ICA, ZnT8)
- Age of onset (typically <30 years old, often childhood)

| Test ID | Patient ID | FPG (mg/dL) | HbA1c (%) | Type-1 Indicators | Expected Result |
|---------|------------|-------------|-----------|-------------------|-----------------|
| T1-001  | P_Type1_001 | 200.0 | 8.5 | yes | **Type-1-Diabetes** |
| T1-002  | P_Type1_002 | 250.0 | 9.0 | yes | **Type-1-Diabetes** |
| T1-003  | P_Type1_003 | 126.0 | 6.5 | yes | **Type-1-Diabetes** |
| T1-004  | P_Type1_004 | 300.0 | 10.0 | yes | **Type-1-Diabetes** |
| T1-005  | P_Type1_005 | 180.0 | 8.0 | yes | **Type-1-Diabetes** |
| T1-006  | P_Type1_006 | 220.0 | 8.8 | yes | **Type-1-Diabetes** |
| T1-007  | P_Type1_007 | 280.0 | 9.5 | yes | **Type-1-Diabetes** |

---

## Boundary Test Cases

These test values verify proper behavior at diagnostic thresholds.

| Test ID | Category | FPG | HbA1c | Type-1 Ind. | Expected | Notes |
|---------|----------|-----|-------|-------------|----------|-------|
| B-001   | Boundary | 99.9 | 5.69 | no | Healthy | Just below thresholds |
| B-002   | Boundary | 100.0 | 5.70 | no | Prediabetes | At prediabetic thresholds |
| B-003   | Boundary | 125.9 | 6.49 | no | Prediabetes | Just below diabetic |
| B-004   | Boundary | 126.0 | 6.50 | no | Type-2-Diabetes | At diabetic thresholds |
| B-005   | Boundary | 126.0 | 6.50 | yes | Type-1-Diabetes | At thresholds with indicators |

---

## Running Tests

### Interactive Testing (Manual)

```bash
cd knowledge_base
./run_interactive.sh          # English version
./run_interactive_es.sh       # Spanish version
```

### Automated Testing

```bash
# Run complete English test suite (16 tests)
./test_all_diagnostics.sh

# Run complete Spanish test suite (7 tests)
./test_all_diagnostics_es.sh
```

---

## Clinical Correlation Notes

### Healthy
- No intervention needed
- Annual or triennial screening recommended
- Emphasize lifestyle maintenance

### Prediabetes
- Increased risk of developing Type-2 Diabetes
- Lifestyle modification is first-line treatment
- Metformin may be considered in high-risk patients
- Follow-up testing every 6-12 months

### Inconclusive
- Results conflict (one normal/prediabetic, one diabetic)
- May indicate stress hyperglycemia, acute illness, or early disease
- Repeat testing within 1-2 weeks recommended
- Consider OGTT (Oral Glucose Tolerance Test)
- Assess for secondary causes of hyperglycemia

### Type-2-Diabetes
- Long-term diabetes management needed
- Lifestyle modification plus pharmacotherapy
- Possible agents: Metformin, GLP-1 RA, SGLT-2i, sulfonylureas, etc.
- Monitor for complications (retinopathy, nephropathy, neuropathy)
- Follow-up every 3 months initially, then quarterly

### Type-1-Diabetes
- **URGENT**: Requires immediate endocrinology referral
- Insulin therapy is mandatory
- Comprehensive autoimmune workup
- Diabetes education and self-management training
- Frequent follow-up (weekly to biweekly initially)
- Screening for other autoimmune conditions (thyroid, celiac, Addison's)
