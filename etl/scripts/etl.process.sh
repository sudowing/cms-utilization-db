echo " " \
&& echo "CMS UTILIZATION DATA ETL [START]" \
&& echo " ............................" \
&& echo " :: Downloading CMS Data CSV(https://tinyurl.com/y7wmsecx)" \
&& curl -o /tmp/cms-utilization.csv https://data.cms.gov/api/views/utc4-f9xp/rows.csv?accessType=DOWNLOAD \
&& echo " ............................" \
&& echo " :: Creating Temp Tables" \
&& psql -d $POSTGRES_DB -U $POSTGRES_USER -f /etl/sql/temp.schema.sql \
&& echo " :: Loading Temp Tables" \
&& echo "\copy temp.cms_temp (npi, name_last, name_first, name_middle, credentials, gender, entity_type, address_street_01, address_street_02, address_city, address_zip_code, address_state, address_country, provider_type, mcare_participation_indicator, place_of_service, hcpcs_code, hcpcs_description, hcpcs_drug_indicator, n_of_svcs, n_of_mcare_beneficiaries, n_of_distinct_mcare_beneficiary_per_day_svcs, avg_mcare_allowed_amt, avg_submitted_charge_amt, avg_mcare_pay_amt, avg_mcare_standardized_amt) FROM '/tmp/cms-utilization.csv' DELIMITER ',' CSV HEADER;" | psql -d $POSTGRES_DB -U $POSTGRES_USER \
&& echo " ............................" \
&& echo " :: Creating Prod Tables" \
&& psql -d $POSTGRES_DB -U $POSTGRES_USER -f /etl/sql/prod.schema.sql \
&& echo " :: Loading Prod Tables" \
&& psql -d $POSTGRES_DB -U $POSTGRES_USER -f /etl/sql/prod.load.sql \
&& echo " ............................" \
&& echo " :: Destroying Temp Tables" \
&& psql -d $POSTGRES_DB -U $POSTGRES_USER -f /etl/sql/temp.destroy.sql \
&& echo " ............................" \
&& echo " :: Deleting CMS Data CSV" \
&& rm /tmp/cms-utilization.csv \
&& echo " ............................" \
&& echo "CMS UTILIZATION DATA ETL [COMPLETE]"
