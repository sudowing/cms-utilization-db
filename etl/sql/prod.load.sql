
INSERT INTO cms.providers
  (
    npi,
    entity_type,
    provider_type,
    address_street_01,
    address_street_02,
    address_city,
    address_zip_code,
    address_state,
    address_country
  )
SELECT DISTINCT
  npi,
  entity_type,
  provider_type,
  address_street_01,
  address_street_02,
  address_city,
  address_zip_code,
  address_state,
  address_country
FROM
  temp.cms_temp
;


INSERT INTO cms.providers_individuals
  (
    npi,
    name_last,
    name_first,
    name_middle,
    credentials,
    gender
  )
SELECT DISTINCT
  npi,
  name_last,
  name_first,
  name_middle,
  credentials,
  gender
FROM
  temp.cms_temp
WHERE
  entity_type = 'I'
;


INSERT INTO cms.providers_organizations
  (
    npi,
    name
  )
SELECT DISTINCT
  npi,
  name_last AS name
FROM
  temp.cms_temp
WHERE
  entity_type = 'O'
;



INSERT INTO cms.services
  (
    hcpcs_code,
    hcpcs_description,
    hcpcs_drug_indicator
  )
SELECT DISTINCT
  hcpcs_code,
  hcpcs_description,
  hcpcs_drug_indicator
FROM
  temp.cms_temp
;




INSERT INTO cms.provider_performance
  (
    npi,
    mcare_participation_indicator,
    place_of_service,
    hcpcs_code,
    n_of_svcs,
    n_of_mcare_beneficiaries,
    n_of_distinct_mcare_beneficiary_per_day_svcs,
    avg_mcare_allowed_amt,
    avg_submitted_charge_amt,
    avg_mcare_pay_amt,
    avg_mcare_standardized_amt
  )
SELECT DISTINCT
  npi,
  mcare_participation_indicator,
  place_of_service,
  hcpcs_code,
  CAST(n_of_svcs as NUMERIC) AS n_of_svcs,
  n_of_mcare_beneficiaries,
  n_of_distinct_mcare_beneficiary_per_day_svcs,
  avg_mcare_allowed_amt,
  avg_submitted_charge_amt,
  avg_mcare_pay_amt,
  avg_mcare_standardized_amt
FROM
  temp.cms_temp
;

INSERT INTO cms.service_provider_performance
(
    hcpcs_code,
    npi,
    entity_type,
    mcare_participation_indicator,
    place_of_service,
    n_of_svcs,
    n_of_distinct_mcare_beneficiary_per_day_svcs,
    n_of_mcare_beneficiaries,
    avg_mcare_pay_amt,
    avg_submitted_charge_amt,
    var_avg_mcare_submitted_charge_pay_amt,
    avg_mcare_allowed_amt,
    avg_mcare_standardized_amt,
    est_ttl_mcare_pay_amt,
    est_ttl_submitted_charge_amt,
    rank_n_of_svcs,
    rank_n_of_distinct_mcare_beneficiary_per_day_svcs,
    rank_n_of_mcare_beneficiaries,
    rank_avg_mcare_standardized_amt,
    rank_avg_mcare_allowed_amt,
    rank_avg_submitted_charge_amt,
    rank_var_avg_mcare_submitted_charge_pay_amt,
    rank_avg_mcare_pay_amt,
    rank_est_ttl_mcare_pay_amt,
    rank_est_ttl_submitted_charge_amt
)
SELECT
    performance.hcpcs_code,
    performance.npi,
    performance.entity_type,
    performance.mcare_participation_indicator,
    performance.place_of_service,
    performance.n_of_svcs,
    performance.n_of_distinct_mcare_beneficiary_per_day_svcs,
    performance.n_of_mcare_beneficiaries,
    performance.avg_mcare_pay_amt,
    performance.avg_submitted_charge_amt,
    performance.var_avg_mcare_submitted_charge_pay_amt,
    performance.avg_mcare_allowed_amt,
    performance.avg_mcare_standardized_amt,
    performance.est_ttl_mcare_pay_amt,
    performance.est_ttl_submitted_charge_amt,
    performance.rank_n_of_svcs,
    performance.rank_n_of_distinct_mcare_beneficiary_per_day_svcs,
    performance.rank_n_of_mcare_beneficiaries,
    performance.rank_avg_mcare_standardized_amt,
    performance.rank_avg_mcare_allowed_amt,
    performance.rank_avg_submitted_charge_amt,
    performance.rank_var_avg_mcare_submitted_charge_pay_amt,
    performance.rank_avg_mcare_pay_amt,
    performance.rank_est_ttl_mcare_pay_amt,
    performance.rank_est_ttl_submitted_charge_amt
FROM
  cms.live_service_provider_performance performance
;


INSERT INTO cms.service_performance
  (
    hcpcs_code,
    entity_type,
    providers,
    n_of_svcs,
    n_of_distinct_mcare_beneficiary_per_day_svcs,
    n_of_mcare_beneficiaries,
    avg_avg_mcare_pay_amt,
    avg_avg_submitted_charge_amt,
    avg_avg_mcare_allowed_amt,
    avg_avg_mcare_standardized_amt,
    min_avg_mcare_pay_amt,
    max_avg_mcare_pay_amt,
    var_avg_mcare_pay_amt,
    min_avg_mcare_allowed_amt,
    max_avg_mcare_allowed_amt,
    var_avg_mcare_allowed_amt,
    min_avg_submitted_charge_amt,
    max_avg_submitted_charge_amt,
    var_avg_submitted_charge_amt,
    min_avg_mcare_standardized_amt,
    max_avg_mcare_standardized_amt,
    var_avg_mcare_standardized_amt,
    est_ttl_mcare_pay_amt,
    est_ttl_submitted_charge_amt,
    est_ttl_mcare_allowed_amt,
    est_ttl_mcare_standardized_amt,
    rank_providers,
    rank_n_of_svcs,
    rank_n_of_distinct_mcare_beneficiary_per_day_svcs,
    rank_n_of_mcare_beneficiaries,
    rank_avg_avg_mcare_pay_amt,
    rank_avg_avg_submitted_charge_amt,
    rank_avg_avg_mcare_allowed_amt,
    rank_avg_avg_mcare_standardized_amt,
    rank_min_avg_mcare_pay_amt,
    rank_max_avg_mcare_pay_amt,
    rank_var_avg_mcare_pay_amt,
    rank_min_avg_mcare_allowed_amt,
    rank_max_avg_mcare_allowed_amt,
    rank_var_avg_mcare_allowed_amt,
    rank_min_avg_submitted_charge_amt,
    rank_max_avg_submitted_charge_amt,
    rank_var_avg_submitted_charge_amt,
    rank_min_avg_mcare_standardized_amt,
    rank_max_avg_mcare_standardized_amt,
    rank_var_avg_mcare_standardized_amt,
    rank_est_ttl_mcare_pay_amt,
    rank_est_ttl_submitted_charge_amt,
    rank_est_ttl_mcare_allowed_amt,
    rank_est_ttl_mcare_standardized_amt
  )
SELECT
    performance.hcpcs_code,
    performance.entity_type,
    performance.providers,
    performance.n_of_svcs,
    performance.n_of_distinct_mcare_beneficiary_per_day_svcs,
    performance.n_of_mcare_beneficiaries,
    performance.avg_avg_mcare_pay_amt,
    performance.avg_avg_submitted_charge_amt,
    performance.avg_avg_mcare_allowed_amt,
    performance.avg_avg_mcare_standardized_amt,
    performance.min_avg_mcare_pay_amt,
    performance.max_avg_mcare_pay_amt,
    performance.var_avg_mcare_pay_amt,
    performance.min_avg_mcare_allowed_amt,
    performance.max_avg_mcare_allowed_amt,
    performance.var_avg_mcare_allowed_amt,
    performance.min_avg_submitted_charge_amt,
    performance.max_avg_submitted_charge_amt,
    performance.var_avg_submitted_charge_amt,
    performance.min_avg_mcare_standardized_amt,
    performance.max_avg_mcare_standardized_amt,
    performance.var_avg_mcare_standardized_amt,
    performance.est_ttl_mcare_pay_amt,
    performance.est_ttl_submitted_charge_amt,
    performance.est_ttl_mcare_allowed_amt,
    performance.est_ttl_mcare_standardized_amt,
    performance.rank_providers,
    performance.rank_n_of_svcs,
    performance.rank_n_of_distinct_mcare_beneficiary_per_day_svcs,
    performance.rank_n_of_mcare_beneficiaries,
    performance.rank_avg_avg_mcare_pay_amt,
    performance.rank_avg_avg_submitted_charge_amt,
    performance.rank_avg_avg_mcare_allowed_amt,
    performance.rank_avg_avg_mcare_standardized_amt,
    performance.rank_min_avg_mcare_pay_amt,
    performance.rank_max_avg_mcare_pay_amt,
    performance.rank_var_avg_mcare_pay_amt,
    performance.rank_min_avg_mcare_allowed_amt,
    performance.rank_max_avg_mcare_allowed_amt,
    performance.rank_var_avg_mcare_allowed_amt,
    performance.rank_min_avg_submitted_charge_amt,
    performance.rank_max_avg_submitted_charge_amt,
    performance.rank_var_avg_submitted_charge_amt,
    performance.rank_min_avg_mcare_standardized_amt,
    performance.rank_max_avg_mcare_standardized_amt,
    performance.rank_var_avg_mcare_standardized_amt,
    performance.rank_est_ttl_mcare_pay_amt,
    performance.rank_est_ttl_submitted_charge_amt,
    performance.rank_est_ttl_mcare_allowed_amt,
    performance.rank_est_ttl_mcare_standardized_amt
FROM
  cms.live_service_performance performance
;

INSERT INTO cms.service_provider_performance_summary
(
  summary_type,
	npi,
	entity_type,
	ttl_hcpcs_code,
	ttl_n_of_svcs,
	est_ttl_submitted_charge_amt,
	est_ttl_mcare_pay_amt,
	var_est_ttl_mcare_submitted_charge_pay_amt,
	est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	rank_ttl_hcpcs_code,
	rank_ttl_n_of_svcs,
	rank_est_ttl_submitted_charge_amt,
	rank_est_ttl_mcare_pay_amt,
	rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
)
SELECT
  summary.summary_type,
	summary.npi,
	summary.entity_type,
	summary.ttl_hcpcs_code,
	summary.ttl_n_of_svcs,
	summary.est_ttl_submitted_charge_amt,
	summary.est_ttl_mcare_pay_amt,
	summary.var_est_ttl_mcare_submitted_charge_pay_amt,
	summary.est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	summary.rank_ttl_hcpcs_code,
	summary.rank_ttl_n_of_svcs,
	summary.rank_est_ttl_submitted_charge_amt,
	summary.rank_est_ttl_mcare_pay_amt,
	summary.rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
FROM
  cms.live_service_provider_performance_summary_overall summary
;





INSERT INTO cms.service_provider_performance_summary
(
  summary_type,
	npi,
	entity_type,
	ttl_hcpcs_code,
	ttl_n_of_svcs,
	est_ttl_submitted_charge_amt,
	est_ttl_mcare_pay_amt,
	var_est_ttl_mcare_submitted_charge_pay_amt,
	est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	rank_ttl_hcpcs_code,
	rank_ttl_n_of_svcs,
	rank_est_ttl_submitted_charge_amt,
	rank_est_ttl_mcare_pay_amt,
	rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
)
SELECT
  summary.summary_type,
	summary.npi,
	summary.entity_type,
	summary.ttl_hcpcs_code,
	summary.ttl_n_of_svcs,
	summary.est_ttl_submitted_charge_amt,
	summary.est_ttl_mcare_pay_amt,
	summary.var_est_ttl_mcare_submitted_charge_pay_amt,
	summary.est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	summary.rank_ttl_hcpcs_code,
	summary.rank_ttl_n_of_svcs,
	summary.rank_est_ttl_submitted_charge_amt,
	summary.rank_est_ttl_mcare_pay_amt,
	summary.rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
FROM
  cms.live_service_provider_performance_summary_drug_yes summary
;




INSERT INTO cms.service_provider_performance_summary
(
  summary_type,
	npi,
	entity_type,
	ttl_hcpcs_code,
	ttl_n_of_svcs,
	est_ttl_submitted_charge_amt,
	est_ttl_mcare_pay_amt,
	var_est_ttl_mcare_submitted_charge_pay_amt,
	est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	rank_ttl_hcpcs_code,
	rank_ttl_n_of_svcs,
	rank_est_ttl_submitted_charge_amt,
	rank_est_ttl_mcare_pay_amt,
	rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
)
SELECT
  summary.summary_type,
	summary.npi,
	summary.entity_type,
	summary.ttl_hcpcs_code,
	summary.ttl_n_of_svcs,
	summary.est_ttl_submitted_charge_amt,
	summary.est_ttl_mcare_pay_amt,
	summary.var_est_ttl_mcare_submitted_charge_pay_amt,
	summary.est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.est_ttl_mcare_pay_amt_by_ttl_n_of_svcs,
	summary.rank_ttl_hcpcs_code,
	summary.rank_ttl_n_of_svcs,
	summary.rank_est_ttl_submitted_charge_amt,
	summary.rank_est_ttl_mcare_pay_amt,
	summary.rank_var_est_ttl_mcare_submitted_charge_pay_amoun,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_hcpcs_code,
	summary.rank_est_ttl_mcare_pay_amt_by_ttl_n_of_servi
FROM
  cms.live_service_provider_performance_summary_drug_no summary
;

