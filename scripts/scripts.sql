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
SELECT specialty_description, COUNT(opioid_drug_flag) AS opioid_claim
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

---opt2
SELECT MAX(total_drug_cost) AS drug_cost, generic_name
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY generic_name
ORDER BY drug_cost DESC;
---PIRFENIDONE, $2,829,174.3

---Question3b
SELECT ROUND(SUM(total_drug_cost)/SUM(total_day_supply),2) AS total_cost_per_day, generic_name
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY generic_name
ORDER BY total_cost_per_day DESC;
---ANSWER: C1 ESTERASE INHIBITOR, $3495.22

---Question4a 
SELECT drug_name, 
CASE
    WHEN opioid_drug_flag = 'Y' THEN 'opioid'
    WHEN antibiotic_drug_flag ='Y' THEN 'antibiotic'
    ELSE 'neither'
END AS drug_type
FROM drug;

---Question4b -- COME BACK TO THIS ONE
SELECT SUM(total_drug_cost) AS MONEY, drug_name, 
CASE 
    WHEN opioid_drug_flag = 'Y' THEN 'opioid'
    WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic'
    ELSE 'neither'
END AS drug_type
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY drug_name, opioid_drug_flag, antibiotic_drug_flag
ORDER BY MONEY DESC;

---testing a count--- didn't work like i hoped
SELECT SUM(total_drug_cost) AS MONEY, drug_name,  
   COUNT(CASE WHEN opioid_drug_flag = 'Y' THEN 'opioid' ELSE NULL END) AS opioid,
   COUNT(CASE WHEN antibiotic_drug_flag = 'Y' THEN 'antibiotic' ELSE NULL END) AS antibiotic
FROM prescription
INNER JOIN drug
USING (drug_name)
GROUP BY drug_name
ORDER BY MONEY, opioid, antibiotic DESC;

---Question5a
SELECT COUNT(cbsaname)
FROM cbsa
WHERE cbsaname LIKE '%TN%'
---ANSWER: 56

---Question5b
SELECT cbsa, SUM(population) AS population
FROM cbsa
LEFT JOIN population
USING (fipscounty)
GROUP BY cbsa
ORDER BY population;
----ANSWER: largest= 34980, 1830410; smallest=34100, 116352

---QUESTION5c
SELECT county, SUM(population) AS population, cbsa
FROM fips_county
LEFT JOIN population
USING (fipscounty)
GROUP BY county
ORDER BY population;

--- Question5c ACTUAL
SELECT county, SUM(population) AS population
FROM fips_county
INNER JOIN population
USING (fipscounty)
INNER JOIN cbsa
USING (fipscounty)
GROUP BY county, cbsa
ORDER BY population DESC;
---ANSWER: SHELBY COUNTRY, 937847


---Question6a
SELECT drug_name, SUM(total_claim_count) AS total_claims
FROM prescription
WHERE total_claim_count > 3000
GROUP BY drug_name
ORDER BY total_claims DESC;


---CHECK FOR 3a
SELECT generic_name
FROM drug
WHERE generic_name = 'INSULIN GLARGINE,HUM.REC.ANLOG';

---CHECK FOR 6a
SELECT drug_name, SUM(total_claim_count) AS total_claims
FROM prescription
GROUP BY drug_name
ORDER BY total_claims DESC;
