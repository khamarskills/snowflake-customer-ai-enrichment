CREATE OR REPLACE TABLE customer_gold (
    customer_id STRING,                  -- Surrogate key

    account_name STRING,                  -- Orange County
    account_type STRING,                  -- COUNTY / CITY / TOWN / SPECIAL_DISTRICT
    city STRING,
    state STRING,
    country STRING DEFAULT 'USA',

    primary_contact_name STRING,
    primary_contact_email STRING,

    is_active BOOLEAN,

    created_ts TIMESTAMP,
    updated_ts TIMESTAMP
);

INSERT INTO customer_gold VALUES
('CUST001','Orange County','COUNTY','Santa Ana','CA','USA',
 'John Smith','john.smith@orangecounty.gov',TRUE,
 CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP()),

('CUST002','Canton Township','TOWN','Canton','MI','USA',
 'Mary Johnson','mary.johnson@cantontownship.gov',TRUE,
 CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP()),

('CUST003','City of Austin','CITY','Austin','TX','USA',
 'Robert Lee','robert.lee@austintexas.gov',TRUE,
 CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP()),

('CUST004','Lake Water District','SPECIAL_DISTRICT','Lakewood','CO','USA',
 'Susan Clark','susan.clark@lakewater.gov',TRUE,
 CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP());
