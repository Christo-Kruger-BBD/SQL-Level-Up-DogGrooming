# Dog Parlour Management System
 
## Description
 
The Dog Parlour Management System is a software application designed to streamline the management of a dog grooming business. It provides functionality for managing customers, pets, appointments, employees, services, and payments.
 
## Features
 
- **Customer Management**: Keep track of customer information including name, title, phone number, and email.
- **Pet Management**: Record details about pets including their breed, size, and age, and associate them with their respective owners.
- **Appointment Scheduling**: Schedule grooming appointments for customers' pets, specifying the date, time, and services required.
- **Employee Management**: Maintain employee records such as name, ID number, phone number, and email.
- **Service Management**: Define various grooming services offered by the parlour, including their price and duration.
- **Payment Tracking**: Record payments made by customers for their appointments.
 
## Installation
 
1. Clone the repository from GitHub:
 
```
git clone git@github.com:Tshego-MM/SQL-Level-Up-DogGrooming.git
```
 
2. Changing infrastructure
    Modify the Terraform files to make infrastructure changes. After making changes, run the pipeline. The changes will be automatically applied.
 
3. Changing Database
    Update the migration SQL files to reflect changes in the database schema. Flyway will automatically handle the migration process.
 
4. Changing pipelines
    Modify the workflow YAML files to make changes to the pipelines. This will update the pipeline configuration accordingly.
 
5.  To manually connect to the database, follow these steps:
 
    Log in to the AWS console.
    Navigate to AWS Secrets Manager.
    Locate the secrets containing the hostname, username, and password details for the database.
    Use these details to connect to the database manually from your preferred database management tool or command line interface.

## Functionality
This database was created to track appointments for customers of Dog Grooming. It stores customer data, pet data, and appointment details such as time of appointment and the type of service.
More details about the functionality of the database can be found [here](https://dogparlour.atlassian.net/wiki/x/AgBq).
 
## Team Members
- Sasha-Lee Kingwill
- Derryk Fivaz
- Yashil Luckan
- Tshegofatso Mohlala
- Christo Kruger
