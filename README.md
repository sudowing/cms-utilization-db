
# CMS Utilization & Payment Data [2016]

	The purpose of the project is to aid in the pursuit of healthcare price transparency by providing a containerized database service populated with data published by CMS (along with derived analytic data).

For more information about see :
- [`CMS Utilization & Payment Data`](https://data.cms.gov/Medicare-Physician-Supplier/Medicare-Provider-Utilization-and-Payment-Data-Phy/utc4-f9xp/data)
- [`NPPES NPI: wikipedia`](https://en.wikipedia.org/wiki/National_Provider_Identifier)
- [`NPPES NPI: api`](https://npiregistry.cms.hhs.gov/)
- [`HCPCS: wikipedia`](https://en.wikipedia.org/wiki/Healthcare_Common_Procedure_Coding_System)
- [`HCPCS: CMS Datasets`](https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Alpha-Numeric-HCPCS.html)













## Getting Started

These instructions will help you get the project up and running.

## Deployment

To run **production image**:

```
make start
```
* Database | port 5434

This process starts the database (with persistent data), and bootstraps the database by restoring a db.dump that is baked into the docker image.


**NOTE 1:** Bootstraping Postgresql is done via a launch script that is run as part of the initiation process.
This scripts restores the schema (structure & data) from a large `pg_dump` (1gb).
The first time this is run, it, it will take 10+ mins to 

(subsequent starts of the db service rely on persistent data)

	:: real	11m5.184s
	:: user	0m15.680s
	:: sys	0m2.800s






## Development


enter:

db-load-via-etl:
/etl/scripts/etl.process.sh
	/volumes/tmp/cms-utilization.csv

db-load-via-sql:
db-dump-sql:
/etl/sql/cms.dump

**NOTE 1:** This sql.dump file is large (1gb) and as such, is gitignored and not stored in the repo. To generate this file (for inspection or when publishing a new docker image), simply run:

```
make db-dump-sql
```


To build and tag a **production image** (`cms-utilization-db:latest`) with your local changes use:

```
make release
```

**NOTE:** Production images hosted on [Docker Hub](https://hub.docker.com/r/sudowing/cms-utilization-db/)


---


## Development

Development doesn't require local installion of node or any of the project's dependencies. Instead, those dependencies are bundled within the docker container and [`nodemon`](https://nodemon.io/) monitors changes to the app's source (which is mounted from your local system to the docker container) and reload the microservice.

This command starts the app, it's dependencies (database & cache), and additional development services (https proxy & more).
```
make run
```


---


























## Schema

Below are diagrams of the tables withing the `cms` schema.





![cms-schema source-data-tables](assets/img/readme/cms_schema_source_data.png "CMS Schema | Tables based on .CSV Source Data")

`services` contains all HCPCS Services represented in the source file.

`providers` (and related tables `providers_individuals` & `providers_organizations`) contains identity information & address for each provider (distinguished by the `providers.entity_type` value).

`provider_performance` contains performance statistics for each HCPCS service provided by each provider.

![cms-schema analytic-data-tables](assets/img/readme/cms_schema_analytic_data.png "CMS Schema | Tables based on .CSV Source Data")

`service_performance` aggregates performance statistics for each HCPCS service across all providers.

`service_provider_performance` extends the data contained in `provider_performance`, estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`), and also compares each providers performance attributes against **all other providers** that also perform the service

`service_provider_performance_summary` aggregates performance statistics by provider across all HCPCS services the provider supports. Also estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`), compares each providers performance attributes against **all other providers**.

`service_provider_performance_summary_type` contains definations of the different ways to group providers in order to generate the data & rankings within `service_provider_performance_summary`.
Currently, it only supports three groups (all providers + all services, all non-HSPCS services by all providers, and 
all HSPCS services by all providers.
Future plans are to group and rank by organizational membership (internal enterprise rankings).

---

## Additional Data Sets

Similar projects can certainly be produced using data from these **additional data stores**:
- [`CMS Data Catalog`](https://data.cms.gov/)
- [`Open Payments: Overview`](https://www.cms.gov/openpayments/)
- [`Open Payments: Data`](https://openpaymentsdata.cms.gov/)
- [`Medicare.gov: Data`](https://data.medicare.gov/)
- [`Medicaid & CHIP Open Data`](https://data.medicaid.gov/)
- [`DATA.GOV: Health Data Catalog`](https://catalog.data.gov/dataset?_organization_limit=0&organization=hhs-gov#topic=health_navigation)
- [`HealthData.gov`](https://healthdata.gov/)
- [`Chronic Conditions Data Warehouse`](https://www.ccwdata.org/web/guest/home)

---

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/sudowing/cms-utilization-db/tags). 

---

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details