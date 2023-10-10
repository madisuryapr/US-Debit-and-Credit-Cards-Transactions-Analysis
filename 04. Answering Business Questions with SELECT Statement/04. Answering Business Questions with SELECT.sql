/* Answering Business Question with SELECT statement
   This file demonstrates how to answer various business questions using
   SELECT statement regarding USA Personal Debit and Credit Cards Transactions
 */

-- Begin this query by selecting corresponding database
USE usa_debit_credit_transactions;

-- Q1. How many users are listed within this database based on their residence state?
-- Order the result by Number of Users
SELECT
    si.state_code AS StateCode,
    si.state_name AS StateName,
    COUNT(*) AS NumberOfUsers
FROM
    user_information AS ui
INNER JOIN
    states_info AS si
    ON ui.states = si.state_code
GROUP BY
    si.state_code,
    si.state_name
ORDER BY
    NumberOfUsers DESC;

-- Q2. How much transactions value and volume for both debit and credit cards of
-- each state of card brand headquarter between 2010 and 2020?
SELECT
    si.state_code AS StatesCode,
    si.state_name AS StatesName,
    SUM(transactions_amount) AS TransactionsValue,
    COUNT(transactions_amount) AS TransactionsVolume
FROM
    card_transactions_fact AS ctf
INNER JOIN
    states_info AS si
    ON ctf.states_code = si.state_code
WHERE
    si.state_code IN (
        SELECT
            headquarter_state
        FROM card_brand_info
        ) AND
    DATEPART(YEAR, ctf.transactions_date) BETWEEN 2010 AND 2020
GROUP BY
    si.state_code,
    si.state_name
ORDER BY
    TransactionsValue DESC;

-- Q3. How many transactions volume were occurred for each state? Retrieve the result with descending order.
SELECT
    ctf.states_code AS StateCode,
    si.state_name AS StateName,
    COUNT(*) AS TransactionsVolume
FROM
    card_transactions_fact AS ctf
INNER JOIN
    states_info AS si
    ON ctf.states_code = si.state_code
GROUP BY
    ctf.states_code,
    si.state_name
ORDER BY
    TransactionsVolume DESC;

-- Q4. What is the total transactions value for debit cards of California, New York, and Texas?
SELECT
    SUM(transactions_amount) AS TotalTransactionsValue
FROM
    card_transactions_fact AS ctf
INNER JOIN
    states_info AS si
    ON ctf.states_code = si.state_code
WHERE
    si.state_code IN ('CA', 'NY', 'TX');

-- Q5. What are the total cards issued for each card brand?
SELECT
    cbi.brand_name AS CardBrandName,
    COUNT(*) AS NumberofCards
FROM
    card_information AS ci
INNER JOIN
    card_brand_info AS cbi
    ON ci.card_brand_id = cbi.brand_id
GROUP BY
    cbi.brand_name
ORDER BY
    NumberofCards DESC;
