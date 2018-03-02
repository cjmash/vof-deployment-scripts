# Image Creation

## Tech Stack
- Packer - version 1.1.3 was used for this project
- Docker - version 17.12.0-ce was used for this project.
## Building a base image for VOF

> **Note:**
The instructions below already assume that 
> - This repository has been cloned to your local machine.
> - You have an account on google cloud platform, with the project on which VOF is being deployed to.
> - You have a service account with at least admin capabilities of Compute Image User, Compute Instance Admin and Service Account Actor.

### Step 1
Create a key for the service account, and place it in the shared folder. Rename the file to account.json.

### Step 2
Change directory to the vof_base_image folder.
`cd vof_base_image`

### Step 3
Provide the value for the Project ID on GCP to the environment key `PROJECT_ID`. Ensure that the service account file copied on step 1 is generated from this project and that the project 'ID' not the 'Name' is used.

`export PROJECT_ID=<your-project-id>`

### Step 4
Run the command below to ensure that the packer.json file is valid. The command should give back a message response indicating successful validation.

`packer validate packer.json`

### Step 5
Build the packer image with the following command

`packer build packer.json`

## Building a Container Image for VOF

> **Note:**
The instructions below already assume that 
> - This repository has been cloned to your local machine.
> - You have an account on google cloud platform, with the project on which VOF is being deployed to.

### Step 1
Change directory into the folder vof_ci_image


`cd ~/vof-deployment-scripts/vof_ci_image`
### Step 2
Build a docker image with the command


`docker build .`

### Step 3
After the image has been built run the command below to view the Image Ids of the docker images generated.


`docker images`

### Step 4
Tag the docker command, by running the command below with the tag latest. The **[IMAGE_ID]** is the ID generated on Step 3, while the  **[PROJECT_ID]** is the google project id for google cloud platform.

`docker tag [IMAGE_ID] gcr.io/[PROJECT-ID]/vof-ci-ruby-node-image`

### Step 5

Push the docker image to gcp with the command below. Note that the gcloud you are using should have the same email as the project account on gcp.


`gcloud docker -- push gcr.io/[PROJECT-ID]/vof-ci-ruby-node-image`