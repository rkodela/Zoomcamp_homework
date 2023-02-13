--Creating external table reffering to gcs path

CREATE OR REPLACE EXTERNAL TABLE trips_data_all.external_fhv_tripdata_2019
OPTIONS (
  format = 'CSV',
  uris = ['gs://dtc_data_lake_de-course-01/raw/fhv_tripdata_2019-*.csv.gz']
  );


-- homework 1

SELECT count(dispatching_base_num)
from `trips_data_all.external_fhv_tripdata_2019`
where extract(year from pickup_datetime) = 2019;
--ANSWER: 43,244,696

-- homework 2
  --CREATED BQ TABLE
CREATE TABLE trips_data_all.fhv_tripdata_2019_all 
AS
SELECT * FROM trips_data_all.external_fhv_tripdata_2019;


SELECT COUNT(Affiliated_base_number) FROM `trips_data_all.external_fhv_tripdata_2019`;
SELECT COUNT(Affiliated_base_number) FROM `trips_data_all.fhv_tripdata_2019_all`;
--ANSWER: 0 MB for the External Table and 317.94MB for the BQ Table

--homework 3

SELECT COUNT(dispatching_base_num)
FROM `trips_data_all.external_fhv_tripdata_2019`
where PUlocationID is null and DOlocationID is null;

--ANSWER: 717,748


--homework 4
  --Partition by pickup_datetime Cluster on affiliated_base_number


--homework 5

SELECT DISTINCT Affiliated_base_number from `trips_data_all.fhv_tripdata_2019_all`
where date(pickup_datetime) between '2019-03-01' AND '2019-03-31';
--647.87MB for non partitioned table

--creating a partition table
Create or replace table trips_data_all.fhv_tripdata_2019_all_partitioned
partition BY Date(pickup_datetime)
cluster by Affiliated_base_number as
select * from `trips_data_all.fhv_tripdata_2019_all`;


SELECT DISTINCT Affiliated_base_number from `trips_data_all.fhv_tripdata_2019_all_partitioned`
where date(pickup_datetime) between '2019-03-01' AND '2019-03-31';
--23.06MB for paritioned table


--Homework 6
  --Big Table

--Homework 7
  --TRUE






