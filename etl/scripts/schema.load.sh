time pg_restore -j 8 -d $POSTGRES_DB -U $POSTGRES_USER /etl/sql/cms.dump