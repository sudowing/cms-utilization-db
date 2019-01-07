
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

Below is a diagram of the schema for your reference.

![cms-schema source-data-tables](assets/img/readme/cms_schema_source_data.png "CMS Schema | Tables based on .CSV Source Data")

A `backup_code` is single use and is deleted upon successful authentication.

`auth_log` records all attempts to authenticate -- successful or failure. This could be useful in the future for rate-throttling or flagging activity.

The data provided in this project provides detailed information on all HCPCS services provided by all providers, including case count & costs (avg charged vs avg paid).

![cms-schema analytic-data-tables](assets/img/readme/cms_schema_analytic_data.png "CMS Schema | Tables based on .CSV Source Data")

A `backup_code` is single use and is deleted upon successful authentication.

`auth_log` records all attempts to authenticate -- successful or failure. This could be useful in the future for rate-throttling or flagging activity.

The data provided in this project provides detailed information on all HCPCS services provided by all providers, including case count & costs (avg charged vs avg paid).

---
















## Prisma IDs

Several of the tables originally had composite primary keys, but when developing the `cms-utilization-graphql` project, it was discovered that prisma lacks support for these keys.

To solve this problem, new primary keys were defined (as `prisma_id`, which are all auto incrementing).

The original keys still exist, but are no long the primary key for the respective tables.

 that were originally 




















#### Source data


Medicare Provider Utilization and Payment Data: Physician and Other Supplier PUF CY2016




The Centers for Medicare & Medicaid Services (CMS) has prepared a public data set that provides information on services and procedures provided to Medicare beneficiaries by physicians and other healthcare professionals.

The dataset contains information on utilization, payment (allowed amount and Medicare payment), and submitted charges organized by National Provider Identifier (NPI), Healthcare Common Procedure Coding System (HCPCS) code, and place of service.



		based on information from CMS administrative claims data for Medicare beneficiaries enrolled in the fee-for-service program available from the CMS Chronic Condition Data Warehouse (www.ccwdata.org).

		calendar year 2016 and contains 100% final-action physician/supplier Part B non-institutional line items for the Medicare fee-for-service population.




---



## Future Development // Additional Data Sets

Additional opporturnities for similar projects exist based on the **additional data stores** see :
- [`HHS: ddddd`](https://data.cms.gov/)
- [`data store: ddddd`](https://openpaymentsdata.cms.gov/)
- [`HHS: ddddd`](https://data.medicare.gov/)
- [`HHS: ddddd`](https://data.medicaid.gov/)
- [`data store: ddddd`](https://catalog.data.gov/dataset?_organization_limit=0&organization=hhs-gov#topic=health_navigation)
- [`HHS: ddddd`](https://healthdata.gov/)
- [`Chronic Condition Data Warehouse`](https://www.ccwdata.org/web/guest/home)





---

##### sadfdf

The goal here is for a first down -- not a touchdown.

This project  hopes 

 investigate these differences.

The data presented here can is 

 and provide leverage 

There is a difference bet

#### Problems

This dataset is limited to services billed to CMS and does not include all payers.

Charge Submitted vs Payment Accepted.
The magic behind this Δ

Providers are assigned Unique identifiers (NPIs)
Services listed rely on HCPCS Codes

The Healthcare Common Procedure Coding System (HCPCS, often pronounced by its acronym as "hick picks") is a set of health care procedure codes based on the American Medical Association's Current Procedural Terminology (CPT).



---

















































## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/sudowing/cms-utilization-db/tags). 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details