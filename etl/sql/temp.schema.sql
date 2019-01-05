DROP SCHEMA IF EXISTS temp CASCADE;

create schema temp;

CREATE TABLE temp.cms_temp
(
    "npi" INT,
    "name_last" TEXT,
    "name_first" TEXT,
    "name_middle" TEXT,
    "credentials" TEXT,
    "gender" TEXT,
    "entity_type" TEXT,
    "address_street_01" TEXT,
    "address_street_02" TEXT,
    "address_city" TEXT,
    "address_zip_code" TEXT,
    "address_state" TEXT,
    "address_country" TEXT,
    "provider_type" TEXT,
    "mcare_participation_indicator" TEXT,
    "place_of_service" TEXT,
    "hcpcs_code" TEXT,
    "hcpcs_description" TEXT,
    "hcpcs_drug_indicator" TEXT,
    "n_of_svcs" TEXT,
    "n_of_mcare_beneficiaries" INT,
    "n_of_distinct_mcare_beneficiary_per_day_svcs" INT,
    "avg_mcare_allowed_amt" NUMERIC,
    "avg_submitted_charge_amt" NUMERIC,
    "avg_mcare_pay_amt" NUMERIC,
    "avg_mcare_standardized_amt" NUMERIC
);
