/* 05. Using JOINs to Answer Business-Related Questions
   In this file, I demonstrate
   how to deploy JOINs in order to answer various business-related questions
   regarding US personal debit and credit cards transactions
 */

-- Begin this operation by selecting corresponding database
USE usa_debit_credit_transactions;


-- Q1: What are the totals of transactions amount for each user in 2019? Limit the result for Top 250 Users
SELECT
    TOP 250 ui.user_id AS userid,
    DATEPART(YEAR, ctf.transactions_date) AS year,
    ui.user_name AS username,
    SUM(transactions_amount) AS total_transactions
FROM card_transactions_fact AS ctf
INNER JOIN user_information AS ui
    ON ctf.user_id = ui.user_id
WHERE
    DATEPART(YEAR, ctf.transactions_date) = 2019
GROUP BY
    ui.user_id, ui.user_name,
    DATEPART(YEAR, ctf.transactions_date)
ORDER BY
    total_transactions DESC;


-- Q2: How much transactions value occurred for each MCC General Category
-- in Card Brand's Headquarter State between 2010 and 2020?
SELECT
    si.state_code AS stateid,
    si.state_name AS statename,
    gmcs.mccgeneral_id AS mccgeneral_id,
    gmcs.general_category AS category,
    SUM(ctf.transactions_amount) AS total_transactions_value
FROM card_transactions_fact AS ctf
INNER JOIN states_info AS si
    ON ctf.states_code = si.state_code
INNER JOIN mccs_code AS mcs
    ON ctf.mccode_id = mcs.mccode_id
INNER JOIN general_mccs_code AS gmcs
    ON mcs.mccgeneral_id = gmcs.mccgeneral_id
WHERE
    ctf.states_code IN (
        SELECT
            headquarter_state
        FROM
            card_brand_info
        ) AND
    DATEPART(YEAR, ctf.transactions_date) BETWEEN 2010 AND 2020
GROUP BY
    si.state_code, si.state_name,
    gmcs.mccgeneral_id, gmcs.general_category
ORDER BY
    statename,
    total_transactions_value DESC;


-- Q3: How much transactions value and volume occurred for each gender per general category?
SELECT
    gi.gender_id AS genderid,
    gi.gender_name AS gender,
    gmcs.mccgeneral_id AS mccgeneralid,
    gmcs.general_category AS category,
    SUM(ctf.transactions_amount) AS total_transactions_value,
    COUNT(ctf.transactions_amount) AS total_transactions_volume
FROM card_transactions_fact AS ctf
INNER JOIN user_information AS ui
    ON ctf.user_id = ui.user_id
INNER JOIN gender_infO AS gi
    ON ui.gender_id = gi.gender_id
INNER JOIN mccs_code AS mcs
    ON ctf.mccode_id = mcs.mccode_id
INNER JOIN general_mccs_code AS gmcs
    ON mcs.mccgeneral_id = gmcs.mccgeneral_id
GROUP BY
    gi.gender_id, gmcs.mccgeneral_id,
    gi.gender_name, gmcs.general_category
ORDER BY
    gender,
    total_transactions_volume DESC,
    total_transactions_value DESC;


-- Q4: How Many Debit Cards issued for each card brand?
SELECT
    cbi.brand_id AS brand_id,
    cbi.brand_name AS brand_name,
    COUNT(ci.card_number) AS number_of_debitcards_issued
FROM user_information AS ui
INNER JOIN card_information AS ci
    ON ui.user_id = ci.user_id
INNER JOIN card_brand_info AS cbi
    ON ci.card_brand_id = cbi.brand_id
WHERE
    ci.card_type = 'Debit'
GROUP BY
    cbi.brand_id, cbi.brand_name
ORDER BY
    number_of_debitcards_issued;


-- Q5: How much transactions value and volume for each state
-- in both Midwest and South Region between 2015 and 2020?
SELECT
    ri.region_id AS region_id,
    ri.region_name AS region,
    si.state_code AS state_id,
    si.state_name AS state,
    SUM(ctf.transactions_amount) AS transactions_value,
    COUNT(ctf.transactions_amount) AS transactions_volume
FROM card_transactions_fact AS ctf
INNER JOIN states_info AS si
    ON ctf.states_code = si.state_code
INNER JOIN geo_division_info AS gdi
    ON si.geo_division_id = gdi.geo_id
INNER JOIN region_info AS ri
    ON gdi.region_id = ri.region_id
WHERE
    DATEPART(YEAR, ctf.transactions_date) BETWEEN 2015 AND 2020
    AND ri.region_id IN ('MW', 'SH')
GROUP BY
    si.state_code, si.state_name,
    ri.region_id, ri.region_name
ORDER BY
    region,
    transactions_value DESC;
