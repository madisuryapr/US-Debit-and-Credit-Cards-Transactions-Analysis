/* USA Debit and Credit Cards Database
   This query presents the procedure in constructing a database for USA Debit and Credit Cards Transactions
   The procedures begin with creating database and tables
 */

-- A) Create a database named usa_debit_credit_transactions
CREATE DATABASE usa_debit_credit_transactions;

-- B) Use the created database for creating related tables
USE usa_debit_credit_transactions;

-- C) Create all tables for this database
-- 1. User Information table
CREATE TABLE user_information (
    user_id INTEGER NOT NULL,
    user_name VARCHAR(MAX),
    birth_date DATE,
    current_age INTEGER,
    retirement_age INTEGER,
    retirement_status VARCHAR(MAX),
    gender_id VARCHAR(10),
    address VARCHAR(MAX),
    city VARCHAR(MAX),
    states VARCHAR(25),
    zipcode INTEGER,
    personal_annual_income BIGINT,
    total_debt BIGINT,
    fico_score INTEGER
);

-- 2. Card Transactions fact table
CREATE TABLE card_transactions_fact (
    card_brand VARCHAR(MAX),
    card_id INTEGER NOT NULL,
    card_type VARCHAR(MAX),
    description VARCHAR(MAX),
    general_category VARCHAR(MAX),
    mccode_id BIGINT,
    mccgeneral_id VARCHAR(250),
    month INTEGER,
    name VARCHAR(MAX),
    state VARCHAR(MAX),
    states_code VARCHAR(20),
    transactions_date DATE,
    transactions_type VARCHAR(MAX),
    user_id INTEGER,
    year INTEGER,
    transactions_amount BIGINT
);

-- 3. Merchant Category Codes (MCCs) table
CREATE TABLE mccs_code (
    mccode_id INTEGER NOT NULL,
    description VARCHAR(MAX),
    valid_payment_brand VARCHAR(500),
    mccgeneral_id VARCHAR(250)
);

-- 4. MCCs General Code table
CREATE TABLE general_mccs_code (
    mccgeneral_id VARCHAR(250) NOT NULL,
    general_category VARCHAR(MAX)
);

-- 5. Cards information table
CREATE TABLE card_information (
    user_id INTEGER NOT NULL,
    card_id INTEGER NOT NULL,
    card_brand_id VARCHAR(20) NOT NULL,
    card_type VARCHAR(25),
    card_number BIGINT,
    card_last_digit BIGINT,
    expires DATE,
    cvv INTEGER,
    has_chip VARCHAR(10),
    credit_limit BIGINT
);

-- 6. States information table
CREATE TABLE states_info (
    state_code VARCHAR(20) NOT NULL,
    state_name VARCHAR(MAX),
    geo_division_id VARCHAR(25)
);

-- 7. Geographic division information table
CREATE TABLE geo_division_info (
    geo_id VARCHAR(25) NOT NULL,
    geographic_division VARCHAR(MAX),
    region_id VARCHAR(20)
);

-- 8. Region information table
CREATE TABLE region_info (
    region_id VARCHAR(25) NOT NULL,
    region_name VARCHAR(MAX)
);

-- 9. Card brand information table
CREATE TABLE card_brand_info (
    brand_id VARCHAR(20) NOT NULL,
    brand_name VARCHAR(MAX),
    headquarter_state VARCHAR(20),
    establishment_year INTEGER
);

-- 10. Gender Information
CREATE TABLE gender_info (
    gender_id VARCHAR(10) NOT NULL,
    gender_name VARCHAR(MAX)
);
