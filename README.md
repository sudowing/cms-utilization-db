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


# RUN DB LOCALLY OR IN STAGING
`make start`

Use Barman for archiving DBs
https://www.pgbarman.org/

CMS DATA
https://data.cms.gov/api/views/utc4-f9xp/rows.csv?accessType=DOWNLOAD

automated download
curl -o volumes/exports/cms/cms-utilization.csv https://data.cms.gov/api/views/utc4-f9xp/rows.csv?accessType=DOWNLOAD

NPI API
https://npiregistry.cms.hhs.gov/api/?number=1003000126
https://npiregistry.cms.hhs.gov/api/demo


PGHOST
PGOPTIONS
PGPORT
PGUSER

