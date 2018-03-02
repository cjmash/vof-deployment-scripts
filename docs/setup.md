## Setting Up VOF on a new GCP Environment.

Note: It's assumed that git is cloned on ~ in this setup wiki doc, if not change the commands below to your path. It also assumes that Compute Engine has enabled billing on your Google Cloud Project.

#### Step 1
Clone the git repository for vof-deployment-scripts by running the command below.

`git clone https://github.com/andela/vof-deployment-scripts.git`
#### Step 2
* Go to GCP and create a service account under IAM & Admin.

![create_service_account](screenshots/service_account.png?raw=true "IAM & Admin Service Account")



* Give the following roles below to the service account:
    * Editor
    * Cloud SQLAdmin
    * Cloud Scheduler Admin
    * Compute instance Admin (v1) 
    * Compute Image User
    * Logs Viewer 
    * Logs Writer 
    * Monitoring Editor 
    * Monitoring Viewer
    * Storage Admin
    * Storage Object Creator
    * Storage Object Viewer


![create_roles](screenshots/service_account_roles.png?raw=true "Service Account Roles")

* Click on furnish a new key and choose json.

![create_key](screenshots/service_account_key.png?raw=true "Service Account Key")


* Download the json file.
* Copy the json file to the shared folder on vof-deployment-scripts and rename it to account.json


    * `cd ~/vof-deployment-scripts/shared`
    * `cp ~/downloads/[name of json key file downloaded] .`

    * (The copy commands above and in subsequent commands assume that the file was downloaded to downloads on your terminal. If not change the path)
* **Remember to rename the file to account.json**

#### Step 3

* Get the andela certificate and the andela key
add it on the same path.
  * `cd ~/vof-deployment-scripts/shared`
  * `cp ~/downloads/[name of the andela certificate] .`
  * `cp ~/downloads/[name of the andela key] .`


* Rename the copied certificate to **andela_certificate.crt**
* Rename the copied key to **andela_key.key**

#### Step 4
Follow the directives on [Image Creation](https://github.com/andela/vof-deployment-scripts/blob/develop/docs/automated_machine_image.md)

#### Step 5
Create a static-ip address that has a GLOBAL type.

#### Step 6
Go to API & Services Click on Enable API & Services and approve SQL Cloud API for database instance management

#### Step 7
* Create a storage bucket manually on gcp with the name vof(any other name can do).
* Create a folder called database-backups.
* In the folder add the vof_production.sql, vof_staging.sql,
vof_design-v2.sql and vof_sandbox.sql dump files.

#### Step 7
Now you can follow the steps on [Environment Creation](https://github.com/andela/vof-deployment-scripts/blob/develop/docs/environment.md) or set up the environment to deploy on Circle CI
