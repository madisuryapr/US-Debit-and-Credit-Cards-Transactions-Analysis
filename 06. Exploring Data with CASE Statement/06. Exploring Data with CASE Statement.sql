/* Exploring Data with CASE Statement
   In this file, I would like to demonstrate the application
   of CASE Statement in order to obtain diverse business-related insights
 */

-- Select the corresponding Database
USE  usa_debit_credit_transactions;

-- Q1: Determine the FICO score's rating for each user in user_information
-- table based on Fair Isaac Corporation standard
SELECT
    ui.user_id AS user_id,
    ui.user_name AS username,
    ui.states AS state_code,
    si.state_name AS name_of_state,
    ui.personal_annual_income AS annual_income,
    ui.total_debt AS total_debt,
    ui.fico_score AS fico_score,
    CASE
        WHEN ui.fico_score < 580
            THEN 'Poor Rating'
        WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
            THEN 'Fair Rating'
        WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
            THEN 'Good Rating'
        WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
            THEN 'Very Good Rating'
        WHEN ui.fico_score >= 800
            THEN 'Exceptional Rating'
        ELSE 'Unidentified'
    END AS credit_rating
FROM user_information AS ui
INNER JOIN states_info AS si
    ON ui.states = si.state_code
ORDER BY
    user_id ASC;

-- Q2: What are the averages of FICO score for each credit rating category?
SELECT
    CASE
        WHEN ui.fico_score < 580
            THEN 'Poor Rating'
        WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
            THEN 'Fair Rating'
        WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
            THEN 'Good Rating'
        WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
            THEN 'Very Good Rating'
        WHEN ui.fico_score >= 800
            THEN 'Exceptional Rating'
        ELSE 'Unidentified'
    END AS credit_rating,
    AVG(ui.fico_score) AS average_fico_score
FROM user_information AS ui
INNER JOIN states_info AS si
    ON ui.states = si.state_code
GROUP BY
    CASE
        WHEN ui.fico_score < 580
            THEN 'Poor Rating'
        WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
            THEN 'Fair Rating'
        WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
            THEN 'Good Rating'
        WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
            THEN 'Very Good Rating'
        WHEN ui.fico_score >= 800
            THEN 'Exceptional Rating'
        ELSE 'Unidentified'
    END
ORDER BY
    average_fico_score ASC;

-- Q3: How many users in a region based on the FICO score's credit rating?
SELECT
    ri.region_id AS region_id,
    ri.region_name AS region_name,
    COUNT(
        CASE WHEN ui.fico_score < 580
        THEN ui.user_id
            END ) AS user_poor_rating,
    COUNT(
        CASE WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
        THEN ui.user_id
            END ) AS user_fair_rating,
    COUNT(
        CASE WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
        THEN ui.user_id
            END ) AS user_good_rating,
    COUNT(
        CASE WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
        THEN ui.user_id
            END ) AS user_verygood_rating,
    COUNT(
        CASE WHEN ui.fico_score >= 800
        THEN ui.user_id
            END ) AS user_exceptional_rating
FROM user_information AS ui
INNER JOIN states_info AS si
    ON ui.states = si.state_code
INNER JOIN geo_division_info AS gdi
    ON si.geo_division_id = gdi.geo_id
INNER JOIN region_info AS ri
    ON gdi.region_id = ri.region_id
GROUP BY
    ri.region_name,
    ri.region_id
ORDER BY
    region_name ASC;

-- Q4: What are the totals of personal annual income for all users per geo division
-- based on their FICO Score?
SELECT
    gdi.geo_id AS geo_id,
    gdi.geographic_division AS geographic_name,
    SUM(
        CASE WHEN ui.fico_score < 580
        THEN ui.personal_annual_income
            END ) AS total_pai_poor_rating,
    SUM(
        CASE WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
        THEN ui.personal_annual_income
            END ) AS total_pai_fair_rating,
    SUM(
        CASE WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
        THEN ui.personal_annual_income
            END ) AS total_pai_good_rating,
    SUM(
        CASE WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
        THEN ui.personal_annual_income
            END ) AS total_pai_verygood_rating,
    SUM(
        CASE WHEN ui.fico_score >= 800
        THEN ui.personal_annual_income
            END ) AS total_pai_exceptional_rating
FROM user_information AS ui
INNER JOIN states_info AS si
    ON ui.states = si.state_code
INNER JOIN geo_division_info AS gdi
    ON si.geo_division_id = gdi.geo_id
GROUP BY
    gdi.geographic_division,
    gdi.geo_id
ORDER BY
    geographic_name ASC;

-- Q5: What are the averages of personal annual income for all users per geo division
-- based on their FICO Score?
SELECT
    gdi.geo_id AS geo_id,
    gdi.geographic_division AS geographic_name,
    AVG(
        CASE WHEN ui.fico_score < 580
        THEN ui.personal_annual_income
            END ) AS total_pai_poor_rating,
    AVG(
        CASE WHEN ui.fico_score >= 580 AND ui.fico_score <= 669
        THEN ui.personal_annual_income
            END ) AS total_pai_fair_rating,
    AVG(
        CASE WHEN ui.fico_score >= 670 AND ui.fico_score <= 739
        THEN ui.personal_annual_income
            END ) AS total_pai_good_rating,
    AVG(
        CASE WHEN ui.fico_score >= 740 AND ui.fico_score <= 799
        THEN ui.personal_annual_income
            END ) AS total_pai_verygood_rating,
    AVG(
        CASE WHEN ui.fico_score >= 800
        THEN ui.personal_annual_income
            END ) AS total_pai_exceptional_rating
FROM user_information AS ui
INNER JOIN states_info AS si
    ON ui.states = si.state_code
INNER JOIN geo_division_info AS gdi
    ON si.geo_division_id = gdi.geo_id
GROUP BY
    gdi.geographic_division,
    gdi.geo_id
ORDER BY
    geographic_name ASC;