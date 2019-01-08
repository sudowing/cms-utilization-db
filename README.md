# CMS Utilization & Payment Database

#### The purpose of the project is to provide a containerized database service loaded with CMS data in order to increase the utility of that data.


...
and ease access 
by 
reducing the technical overhead associated with 



for others who are also pursuing healthcare price transparency 

#### sdf

stakeholders to compare costs and understand finer details related to healthcare costs like:
...


Examples of fine details:
- variance between charges & payments
- variance in payments between providers for the same service
- average costs nationally for individual healthcare services

Examples of analytic data:

- Ranking of providers by Total Services Provided
- Ranking of providers by HCPCS Services provider
- Estimated sums each provider `charged` & `recieved` for each individual HCPCS Service
- Ranking of providers by Total $ Charged to CMS
- Ranking of providers by Total $ Paid from CMS

For additional domain information see :
- [`Source Data: CMS Utilization & Payment Data`](https://data.cms.gov/Medicare-Physician-Supplier/Medicare-Provider-Utilization-and-Payment-Data-Phy/utc4-f9xp/data)
- [`NPPES NPI: wikipedia`](https://en.wikipedia.org/wiki/National_Provider_Identifier)
- [`NPPES NPI: api`](https://npiregistry.cms.hhs.gov/)
- [`HCPCS: wikipedia`](https://en.wikipedia.org/wiki/Healthcare_Common_Procedure_Coding_System)
- [`HCPCS: CMS Datasets`](https://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets/Alpha-Numeric-HCPCS.html)

---

## Quick Start

```
make start
```
- postgres database | port 5432
- credentials
	- **database:** govdata
	- **user:** dbuser
	- **password:** dbpassword

This command starts the database and restores the schema (structure & data) from a db.dump that is baked into the docker image.

This initiation process will take 10+ mins (sample `time` report provided below) to complete on the first run. Subsequent starts rely on persistent data.

	:: real	11m5.184s
	:: user	0m15.680s
	:: sys	0m2.800s

---

## Source data

The foundation of this project is a `.csv` dataset titled, _Medicare Provider Utilization and Payment Data: Physician and Other Supplier PUF CY2016_. You can find the original data.

You can find a full description of the dataset on [`their site`](https://data.cms.gov/Medicare-Physician-Supplier/Medicare-Provider-Utilization-and-Payment-Data-Phy/utc4-f9xp/data), but for convience, a summarized description is below: 

```
The Centers for Medicare & Medicaid Services (CMS) has prepared a public data set that provides information on services and procedures provided to Medicare beneficiaries by physicians and other healthcare professionals.

The dataset contains information on utilization, payment (allowed amount and Medicare payment), and submitted charges organized by National Provider Identifier (NPI), Healthcare Common Procedure Coding System (HCPCS) code, and place of service.

This data represents calendar year 2016 and contains 100% final-action physician/supplier Part B non-institutional line items for the Medicare fee-for-service population.
```

---

## Schema

Within the database, the data is organized into 9 tables (5 **source data** tables & 4 **analytic data** tables).

### Source Data Tables

![cms-schema source-data-tables](assets/img/readme/cms_schema_source_data.png "CMS Schema | Tables based on .CSV Source Data")

- `services` contains all HCPCS Services represented in the source file.

- `providers` (and related tables `providers_individuals` & `providers_organizations`) contains identity information & address for each provider (distinguished by `providers.entity_type`).

- `provider_performance` contains performance statistics for each HCPCS service provided by each provider.

### Analytic Data Tables

![cms-schema analytic-data-tables](assets/img/readme/cms_schema_analytic_data.png "CMS Schema | Tables based on .CSV Source Data")

- `service_performance` aggregates performance statistics for each HCPCS service across all providers.

- `service_provider_performance` extends the data contained in `provider_performance`, estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`), and also generates performance rankings by compares each provider's performance attributes against **all other providers** that also perform the service.

- `service_provider_performance_summary` aggregates provider performance statistics across all HCPCS services the provider supports. Also estimates cumulative amounts charged & paid (`n_of_svcs` * `amt`) and generates performance rankings by comparing each provider's performance attributes against **all other providers**.

- `service_provider_performance_summary_type` is used to define different ways of generating summaries (provider groupings and/or service subsets) within `service_provider_performance_summary`.
  
	Currently summaries supported:
    - all providers + all services
    - all providers + non-drug HSPCS services
    - all providers + drug HSPCS services
    - [**`future`**](https://github.com/sudowing/cms-utilization-db/issues/1): enterprise providers + all services

---

## Prisma IDs

The first planned consumer of this DB was a GraphQL service.

[`That project`](https://github.com/sudowing/cms-utilization-graphql) uses [`prisma`](https://github.com/prisma/prisma) to provide a GraphQL API to the data. Unfortunately, when developing that project, I noticed that prisma currently doesn't support composite keys (although the feature is proposed for [`Datamodel v2`](https://github.com/prisma/prisma/issues/3405)).

To resolve this in the meantime, new **auto incrementing** primary keys were defined (as `prisma_id`). The original keys still exist, but are no long the primary key for their respective tables.

---































#### Shortcomings of this Dataset

This dataset is limited to services billed to CMS and does not include all payers.

Charge Submitted vs Payment Accepted.
The magic behind this Δ

Providers are assigned Unique identifiers (NPIs)
Services listed rely on HCPCS Codes

The Healthcare Common Procedure Coding System (HCPCS, often pronounced by its acronym as "hick picks") is a set of health care procedure codes based on the American Medical Association's Current Procedural Terminology (CPT).

##### sadfdf

The goal here is for a first down -- not a touchdown.

This project  hopes 

 investigate these differences.

The data presented here can is 

 and provide leverage 

There is a difference bet



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