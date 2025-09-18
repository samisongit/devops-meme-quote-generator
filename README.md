# DevOps Meme & Quote Generator

This project demonstrates a complete CI/CD pipeline for a containerized Python Flask application. It uses Docker for containerization, Terraform for AWS infrastructure provisioning, and Ansible for configuration. The pipeline is implemented using GitHub Actions.

## Project Overview

The application is a simple API that serves:
*   Random DevOps-related memes (as image URLs) via the `/meme` endpoint.
*   Random inspiring tech/DevOps quotes via the `/quote` endpoint.

This project serves as a capstone to showcase essential DevOps skills: containerization, Infrastructure as Code (IaC), Continuous Integration/Continuous Deployment (CI/CD), and configuration management.

## Technology Stack

*   **Application:** Python 3, Flask
*   **Containerization:** Docker, Docker Compose (for local dev)
*   **Infrastructure as Code (IaC):** Terraform (AWS Provider)
*   **CI/CD:** GitHub Actions
*   **Cloud Platform:** Amazon Web Services (AWS)
    *   EC2 (for running the application)
    *   VPC, Subnets, Security Groups (networking)
    *   S3 (Terraform remote state storage)
    *   DynamoDB (Terraform state locking)
*   **Configuration Management:** Ansible (planned)

## Prerequisites

*   Git
*   Docker & Docker Compose (for local development)
*   AWS Account (with necessary permissions for EC2, VPC, S3, DynamoDB)
*   GitHub Account
*   Docker Hub Account (or AWS ECR configured)

## Getting Started (Local Development)

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/samisongit/devops-meme-quote-generator.git
    cd devops-meme-quote-generator
    ```
2.  **Build and Run with Docker Compose:**
    ```bash
    docker-compose up --build
    ```
3.  **Access the Application:**
    Open your web browser and navigate to:
    *   `http://localhost:5000/` (Welcome message and endpoints)
    *   `http://localhost:5000/meme` (Get a random meme)
    *   `http://localhost:5000/quote` (Get a random quote)
4.  **Stop the Application:**
    Press `Ctrl+C` in the terminal running `docker-compose up`. To remove the containers:
    ```bash
    docker-compose down
    ```

## CI/CD Pipeline (GitHub Actions)

This project uses GitHub Actions for its CI/CD pipeline, defined in `.github/workflows/ci-cd-pipeline.yml`.

**Workflow Stages:**

1.  **Build & Test (on Push/PR):**
    *   Checks out the code.
    *   Sets up Python and Docker.
    *   Builds the Docker image.
    *   Pushes the image to Docker Hub (using secrets).
2.  **Terraform Plan (on PR - Planned):**
    *   Runs `terraform plan` to show proposed infrastructure changes.
    *   Posts the plan output as a comment on the Pull Request.
3.  **Terraform Apply (on Merge/Manual - Planned):**
    *   Requires manual approval.
    *   Runs `terraform apply` to create/update AWS infrastructure.
4.  **Ansible Configuration (Post-Apply - Planned):**
    *   Requires manual approval.
    *   Runs an Ansible playbook to configure the EC2 instance (e.g., install Docker, run the container).
5.  **Validation (Post-Configuration - Planned):**
    *   Verifies the deployed application is accessible and functional.

*(Note: Full CI/CD integration including Terraform Apply and Ansible is part of the complete project workflow.)*

## Project Structure
devops-meme-quote-generator/
├── app.py # Main Flask application code
├── requirements.txt # Python dependencies
├── memes.json # Data file for memes
├── quotes.json # Data file for quotes
├── Dockerfile # Instructions to build the application Docker image
├── docker-compose.yml # Docker Compose configuration for local development
├── terraform/ # Terraform configuration files
│ ├── main.tf # Main Terraform resource definitions
│ ├── variables.tf # Input variables
│ ├── outputs.tf # Output values (e.g., EC2 IP)
│ ├── provider.tf # AWS provider configuration
│ └── backend.tf # Terraform remote backend (S3/DynamoDB)
├── ansible/ # Ansible playbooks (planned)
│ └── playbook.yml # Playbook to configure EC2 instance
├── .github/workflows/ # GitHub Actions workflow definitions
│ └── ci-cd-pipeline.yml # Main CI/CD workflow
└── README.md # This file

## Security Considerations

*   **Secrets Management:** Never commit sensitive information like passwords or API keys. Use GitHub Secrets for CI/CD credentials (AWS, Docker Hub).
*   **SSH Keys:** Securely manage the EC2 SSH key pair. Restrict Security Group rules for SSH (port 22) to known IP addresses in production.
*   **Terraform State:** The remote state file in S3 is secured and encrypted. State locking is implemented using DynamoDB.
*   **Dependencies:** Keep base Docker images and application dependencies updated.

## Next Steps / Lessons Learned

*(This section can be updated as you progress through the project and document specific challenges, solutions, and insights gained.)*

# Testing Terraform Plan Job
# Triggering Terraform Apply Test
# Testing Full CI/CD Pipeline (Terraform + Ansible)
