
# CMS Utilization & Payment Database
### The purpose of the project is to aid in the pursuit of healthcare price transparency by providing a containerized database service populated with data published by CMS (along with derived analytic data).

For additional domain information see :
- [`CMS Utilization & Payment Data`](https://data.cms.gov/Medicare-Physician-Supplier/Medicare-Provider-Utilization-and-Payment-Data-Phy/utc4-f9xp/data)
- [`NPPES NPI: wikipedia`](https://en.wikipedia.org/wiki/National_Provider_Identifier)
- [`NPPES NPI: api`](https://npiregistry.cms.hhs.gov/)
- [`HCPCS: wikipedia`](https://en.wikipedia.org/wiki/Healthcare_Common_Procedure_Coding_System)
- [`HCPCS: CMS Datasets`](https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Alpha-Numeric-HCPCS.html)

---










## Getting Started

These instructions will help you get the project up and running.

## Deployment

```
make start
```

This process starts the database (port 5432) (configured to maintain persistent data) and bootstraps the database by restoring a db.dump that is baked into the docker image.

**NOTE 1:** Bootstraping Postgresql is done via a launch script that is run as part of the initiation process and restores the schema (structure & data) from a large `pg_dump` (1gb).

This process will take 10+ mins to complete on the first run. Subsequent starts rely on persistent data.

	:: real	11m5.184s
	:: user	0m15.680s
	:: sys	0m2.800s


---

## Schema

The data is organized into 9 tables (5 **source data** tables & 4 **analytic data** tables).

### Source Data Tables

![cms-schema source-data-tables](assets/img/readme/cms_schema_source_data.png "CMS Schema | Tables based on .CSV Source Data")

`services` contains all HCPCS Services represented in the source file.

`providers` (and related tables `providers_individuals` & `providers_organizations`) contains identity information & address for each provider (distinguished by the `providers.entity_type` value).

`provider_performance` contains performance statistics for each HCPCS service provided by each provider.

### Analytic Data Tables

![cms-schema analytic-data-tables](assets/img/readme/cms_schema_analytic_data.png "CMS Schema | Tables based on .CSV Source Data")

`service_performance` aggregates performance statistics for each HCPCS service across all providers.

`service_provider_performance` extends the data contained in `provider_performance`, estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`), and also compares each providers performance attributes against **all other providers** that also perform the service (rankings)

`service_provider_performance_summary` aggregates performance statistics by provider across all HCPCS services the provider supports. Also estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`), compares each providers performance attributes against **all other providers** (rankings).

`service_provider_performance_summary_type` contains definations of the different ways to group providers in order to generate the data & rankings within `service_provider_performance_summary`.
Currently, it only supports three groups (all providers + all services, all non-HSPCS services by all providers, and 
all HSPCS services by all providers.
Future plans are to group and rank by organizational membership (internal enterprise rankings).

---

## Prisma IDs

The original purpose of this DB was to serve as the datastore for a GraphQL service.

[`That project`](https://github.com/sudowing/cms-utilization-graphql) uses [`prisma`](https://github.com/prisma/prisma) to serve a GraphQL API to the data.

One thing I learned by building that project was that prisma currently doesn't support composite primary keys

To solve this problem, new primary keys were defined (as `prisma_id`), which are all auto incrementing.

The original keys still exist, but are no long the primary key for the respective tables.

---

## Additional Data Sets

Similar projects can be built using data from these **additional data stores**:
- [`CMS Data Catalog`](https://data.cms.gov/)
- [`Open Payments: Overview`](https://www.cms.gov/openpayments/)
- [`Open Payments: Data`](https://openpaymentsdata.cms.gov/)
- [`Medicare.gov: Data`](https://data.medicare.gov/)
- [`Medicaid & CHIP Open Data`](https://data.medicaid.gov/)
- [`DATA.GOV: Health Data Catalog`](https://catalog.data.gov/dataset?_organization_limit=0&organization=hhs-gov#topic=health_navigation)
- [`HealthData.gov`](https://healthdata.gov/)
- [`Chronic Conditions Data Warehouse`](https://www.ccwdata.org/web/guest/home)

---




## Development

```
make run
```

This command starts the DB service, and mounts several of the local directories (scripts, sql, tmp) in the container.



```
make db-dump-sql
```

This command connects to the container running the DB service and generates a sql export via `pg_dump`.


**NOTE 1:** This sql.dump file is large (1gb) and as such, is `.gitignore`d and not stored in the repo. To generate this file (for inspection or when publishing a new docker image), you must generate this file **before** baking the docker image.


```
make db-load-via-sql
```

This command connects to the container running the DB service and restores the db using the sql.dump file generated above.

```
make db-load-via-etl
```

This command builds the database through ETL process that downloads the original CSV, loads it into temp tables, then builds prod tables and populates them from the temp tables. 

Anyone interested in validating the integrity of the data provided by this project, should focus 

**NOTE 1:** This ETL process takes 2.5+ hours.

**NOTE 2:** This ETL process downloads the original CSV from the goverment's servers and stores it inside the container at `/tmp/cms-utilization.csv`
If you're running the project in development mode (`make run`), this file should be available to you at `/volumes/tmp/cms-utilization.csv` 


---

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/sudowing/cms-utilization-db/tags). 

---

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details