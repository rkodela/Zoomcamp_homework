# Code for Question #1

docker build --help

<!-- ######################################################################################################### -->

# Code for Question #2

:docker_postgres $ docker run -it --entrypoint=bash python:3.9
Unable to find image 'python:3.9' locally
3.9: Pulling from library/python
c345c9e441f5: Already exists
7b716680367d: Already exists
0855378f8903: Already exists
4bfb8dc93d41: Already exists
fb726ea60d28: Already exists
5155138a0238: Already exists
12cba0d88708: Pull complete
9b1c665f6032: Pull complete
c2fd9632d3e2: Pull complete
Digest: sha256:7af616b934168e213d469bff23bd8e4f07d09ccbe87e82c464cacd8e2fb244bf
Status: Downloaded newer image for python:3.9
root@77024cae9699:/# pip list
Package Version

---

pip 22.0.4
setuptools 58.1.0
wheel 0.38.4


<!-- ######################################################################################################### -->

# Code for Question 3

-- Question 3. Count records --

select count(index)
from ny_taxi.public.green_taxi_trips
where cast(lpep_pickup_datetime as date) = '2019-01-15'
  and cast(lpep_dropoff_datetime as date) = '2019-01-15';

<!-- ######################################################################################################### -->

# Code for Question 4

-- Question 4. Largest trip for each day --

select index, lpep_pickup_datetime, lpep_dropoff_datetime, trip_distance
from ny_taxi.public.green_taxi_trips
where trip_distance = (select max(trip_distance) from ny_taxi.public.green_taxi_trips);

<!-- ######################################################################################################### -->

# Code for Question 5

-- Question 5. The number of passengers --

select distinct count(index), passenger_count
from ny_taxi.public.green_taxi_trips
where cast(lpep_pickup_datetime as date) = '2019-01-01'
group by passenger_count
having passenger_count = 3

union

select distinct count(index), passenger_count
from ny_taxi.public.green_taxi_trips
where cast(lpep_pickup_datetime as date) = '2019-01-01'
group by passenger_count
having passenger_count = 2;

<!-- ######################################################################################################### -->

# Code for Question 6

-- Question 6. The number of passengers --

with tble1 as (select b."PULocationID", b."DOLocationID", max(b.tip_amount) as max_amt
             from ny_taxi.public.taxi_zone_lookup a
                      left join ny_taxi.public.green_taxi_trips b
                                on a."LocationID" = b."PULocationID"
             where a."Zone" = 'Astoria'
             group by 1, 2
             order by max(b.tip_amount) desc
             limit 1)
select  y."Zone" , x."max_amt" from tble1 x
left join ny_taxi.public.taxi_zone_lookup y
on x."DOLocationID" = y."LocationID"


<!-- ######################################################################################################### -->


# Code for Terraform

terraform apply
var.project
  Your GCP Project ID

  Enter a value: de-course-01


Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + labels                     = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "us-west1"
      + project                    = "de-course-01"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + dataset {
              + target_types = (known after apply)

              + dataset {
                  + dataset_id = (known after apply)
                  + project_id = (known after apply)
                }
            }

          + routine {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + routine_id = (known after apply)
            }

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "US-WEST1"
      + name                        = "dtc_data_lake_de-course-01"
      + project                     = (known after apply)
      + public_access_prevention    = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_prefix        = []
              + matches_storage_class = []
              + matches_suffix        = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }

      + website {
          + main_page_suffix = (known after apply)
          + not_found_page   = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_bigquery_dataset.dataset: Creation complete after 1s [id=projects/de-course-01/datasets/trips_data_all]
google_storage_bucket.data-lake-bucket: Creation complete after 1s [id=dtc_data_lake_de-course-01]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.