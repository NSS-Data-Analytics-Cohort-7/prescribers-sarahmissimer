----QUESTION1a
SELECT npi, SUM(total_claim_count) AS total_claim
FROM prescription
GROUP BY npi
ORDER BY total_claim DESC;
---ANSWER 1881634483, 99707

---Question1b
SELECT nppes_provider_first_name AS first_name, nppes_provider_last_org_name AS last_name, specialty_description, SUM(total_claim_count) AS total_claim
FROM prescriber
INNER JOIN prescription
USING (npi)
GROUP BY first_name, last_name, specialty_description
ORDER BY total_claim DESC;
---ANSWER: BRUCE PENDLEY, FAMILY PRACTICE, 99707

---Question2a
SELECT specialty_description, SUM(total_claim_count) AS total_claim
FROM prescription
INNER JOIN prescriber
USING (npi)
GROUP BY specialty_description
ORDER BY total_claim DESC;
---ANSWER:Family Practice, 9752347

---Question2b
SELECT specialty_description, SUM(total_claim_count) AS total_claim, COUNT(opioid_drug_flag) AS opioid_claim
FROM prescription
INNER JOIN prescriber
USING (npi)
INNER JOIN drug
USING (drug_name)
WHERE opioid_drug_flag = 'Y'
GROUP BY specialty_description
ORDER BY opioid_claim DESC;
--- ANSWER: Nurse Practitioner, 9551

---Question2c

---Question2d

---Question3a
SELECT SUM(total_drug_cost) AS drug_cost, generic_name
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY generic_name
ORDER BY drug_cost DESC;
---INSULIN GLARGINE,HUM.REC.ANLOG,  $104,264,066.35

---Question3b
SELECT ROUND(SUM(total_drug_cost)/SUM(total_day_supply),2) AS total_cost_per_day, generic_name
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY generic_name
ORDER BY total_cost_per_day DESC;
---ANSWER: C1 ESTERASE INHIBITOR, $3495.22

---Question4a-- pretty sure this is going to be a where condition 
SELECT drug_name



