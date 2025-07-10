# Student Portal: Django and MariaDB Dockerized Application

## Project Overview

This project is a simple, full-stack web application designed for basic management of student records. The application is built with the Django web framework for the backend and uses MariaDB as its database.

The entire application stack (Django web server and MariaDB database) is containerized using Docker and orchestrated with Docker Compose. This allows for easy setup, consistent development environments, and simplified deployment.

### Features

- **Add Students:** Add new student records with a unique ID, first name, last name, and email.
- **List Students:** View a list of all students currently in the database.
- **Delete Students:** Remove student records from the database.

### Technology Stack

- **Backend:** Python / Django
- **Database:** MariaDB
- **Containerization:** Docker / Docker Compose

---

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- **Docker:** [Download & Install Docker Desktop](https://www.docker.com/products/docker-desktop/)
- **Docker Compose:** (This is included with Docker Desktop)

---

## Project Setup and Configuration

1.  **Clone the Repository**

    ```bash
    git clone https://github.com/rustybladez/django-student-portal
    cd django-student-portal
    ```

    (If not using Git, simply ensure you have the project files in a directory).

2.  **Configure Environment Variables**
    This project uses an `.env` file to manage sensitive information and environment-specific settings.

    - Create a file named `.env` in the root of the project directory.
    - Copy the contents of `.env.example` (or the content below) into the new file:

    ```ini
    # .env - Environment Variables

    # -- Database Credentials --
    # These are used by both the MariaDB and Django services.
    DB_NAME=student_portal_db
    DB_USER=student_user
    DB_PASSWORD=supersecretpassword
    DB_HOST=db
    DB_PORT=3306
    ```

    **Note:** The `DB_HOST` must be set to `db`, which is the service name of the MariaDB container in the `docker-compose.yml` file.

---

## How to Build and Run the Containers

With Docker running and the `.env` file created, you can build and start the application with a single command:

```bash
docker-compose up --build -d
```
