
# Universal 2nd Factor Microservice

#### Project Summary
	The purpose of the project is to aid in the pursuit of healthcare price transparency by providing a containerized database service populated with original data published by CMS, along with derived analytic data that 
	



	If other payers would

	Group providers by organization so you could

	
with information on services and procedures provided to Medicare beneficiaries by physicians and other healthcare professionals.

The Physician and Other Supplier PUF contains information on utilization, payment (allowed amount and Medicare payment), and submitted charges organized by National Provider Identifier (NPI), Healthcare Common Procedure Coding System (HCPCS) code, and place of service.


The goal here is for a first down -- not a touchdown.

This project  hopes 

 investigate these differences.

The data presented here can is 

 and provide leverage 

There is a difference bet

Problems

This dataset is limited to services billed to CMS and does not include all payers.

Charge Submitted vs Payment Accepted.
The magic behind this Δ

Providers are assigned Unique identifiers (NPIs)
Services listed rely on HCPCS Codes

The Healthcare Common Procedure Coding System (HCPCS, often pronounced by its acronym as "hick picks") is a set of health care procedure codes based on the American Medical Association's Current Procedural Terminology (CPT).



NPI API
https://npiregistry.cms.hhs.gov/api/?number=1003000126
https://npiregistry.cms.hhs.gov/api/demo




complete changelog
complete readme
cut releases
push to github
bake images and push to dockerhub


db bootstrapping...
--------------------
:: real	11m5.184s
:: user	0m15.680s
:: sys	0m2.800s
--------------------



## Getting Started

These instructions will help you get the project up and running.


For more information about **Universal 2nd Factor** & **One-Time Password** see :
- [`data csv: CMS Utilization & Payment Data`](https://data.cms.gov/Medicare-Physician-Supplier/Medicare-Provider-Utilization-and-Payment-Data-Phy/utc4-f9xp/data)
- [`data api: NPPES NPI Registry`](https://npiregistry.cms.hhs.gov/)


Additional opporturnities for similar projects exist based on the **additional data stores** see :
- [`HHS: ddddd`](https://data.cms.gov/)
- [`data store: ddddd`](https://openpaymentsdata.cms.gov/)
- [`HHS: ddddd`](https://data.medicare.gov/)
- [`HHS: ddddd`](https://data.medicaid.gov/)
- [`data store: ddddd`](https://catalog.data.gov/dataset?_organization_limit=0&organization=hhs-gov#topic=health_navigation)
- [`HHS: ddddd`](https://healthdata.gov/)
- [`Chronic Condition Data Warehouse`](https://www.ccwdata.org/web/guest/home)



## Deployment

To run **production image**:

```
make start
```

This process starts the database (with persistent data), cache server and the api microservice (and none of the development dependencies)

* Database | no port exposed
* Cache Server | no port exposed
* [API Microservice](http://0.0.0.0:8443) | port 8443

##### NOTE: In **Production**, you'll want to make sure you're managing the db service correctly (backups, dumps, snapshots, redundancy, etc). 

To build and tag a **production image** (`u2f-server:latest`) with your local changes use:

```
make release
```

**NOTE:** Production images hosted on [Docker Hub](https://hub.docker.com/r/sudowing/u2f-server/)


---



## Schema

Data migrations for the app are managed via `knex migrate:latest` which is run in the container at runtime.

Below is a diagram of the schema for your reference.

![cms-schema source-data-tables](assets/img/readme/cms_schema_source_data.png "CMS Schema | Tables based on .CSV Source Data")

`u2f_key`, `otp_device`, and `backup_code` all hold records for configured MFA methods. The nickname field is only provided so the users can differentiate between their multiple devices (if they have them), as they're able to remove devices.

A `backup_code` is single use and is deleted upon successful authentication.

`auth_log` records all attempts to authenticate -- successful or failure. This could be useful in the future for rate-throttling or flagging activity.


![cms-schema analytic-data-tables](assets/img/readme/cms_schema_analytic_data.png "CMS Schema | Tables based on .CSV Source Data")

`u2f_key`, `otp_device`, and `backup_code` all hold records for configured MFA methods. The nickname field is only provided so the users can differentiate between their multiple devices (if they have them), as they're able to remove devices.

A `backup_code` is single use and is deleted upon successful authentication.

`auth_log` records all attempts to authenticate -- successful or failure. This could be useful in the future for rate-throttling or flagging activity.

---

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/sudowing/u2f-server/tags). 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details












## Development

Development doesn't require local installion of node or any of the project's dependencies. Instead, those dependencies are bundled within the docker container and [`nodemon`](https://nodemon.io/) monitors changes to the app's source (which is mounted from your local system to the docker container) and reload the microservice.

This command starts the app, it's dependencies (database & cache), and additional development services (https proxy & more).
```
make run
```


---
