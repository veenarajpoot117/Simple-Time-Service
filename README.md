Below is the complete `README.md` file for both **Task 1** and **Task 2**, updated to use **Google Cloud Platform (GCP)**. This README provides clear instructions for building, running, and deploying the application and infrastructure.

---

# **SimpleTimeService - DevOps Challenge**

Welcome to the **SimpleTimeService** repository! This project is part of the Particle41 DevOps Team Challenge. It demonstrates the creation of a minimal web service, containerization using Docker, and deployment to Google Cloud Platform (GCP) using Terraform.

---

## **Task 1 - Minimalist Application Development / Docker**

### **Overview**
The **SimpleTimeService** is a simple web service that returns the current timestamp and the visitor's IP address in JSON format.

### **Prerequisites**
- Docker installed ([Install Docker](https://docs.docker.com/get-docker/))
- Git installed ([Install Git](https://git-scm.com/downloads))

---

### **Repository Structure**
```
simple-time-service/
├── app/
│   ├── app.py              # Flask application code
│   ├── requirements.txt    # Python dependencies
│   └── Dockerfile          # Dockerfile for containerization
├── terraform/
│   ├── main.tf             # Terraform configuration for GCP
│   ├── variables.tf        # Terraform variables
│   ├── outputs.tf          # Terraform outputs
│   └── terraform.tfvars    # Terraform variable values
└── README.md               # This file
```

---

### **Build and Run the Docker Container**

#### 1. Clone the Repository
```bash
git clone https://github.com/veenarajpoot117/Simple-Time-Service.git
cd simple-time-service
```

#### 2. Build the Docker Image
```bash
docker build -t simple-time-service ./app
```

#### 3. Run the Docker Container
```bash
docker run -p 8080:8080 simple-time-service
```

#### 4. Access the Service
Open your browser or use `curl` to visit:
```
http://localhost:8080
```

#### Example Response
```json
{
  "timestamp": "2023-10-05 12:34:56",
  "ip": "192.168.1.1"
}
```

---


## **Task 2 - Terraform and GCP: Create Infrastructure**

### **Overview**
This task involves using Terraform to deploy the **SimpleTimeService** to Google Cloud Platform (GCP). The infrastructure includes:
- A VPC with public and private subnets
- A Google Kubernetes Engine (GKE) cluster
- A Kubernetes deployment and service to run the container

---

### **Prerequisites**
- Terraform installed ([Install Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli))
- Google Cloud SDK installed ([Install Google Cloud SDK](https://cloud.google.com/sdk/docs/install))
- GCP project with billing enabled
- Authenticate with GCP:
  ```bash
  gcloud auth application-default login
  ```

---

### **Deploy Infrastructure with Terraform**

#### 1. Navigate to the Terraform Directory
```bash
cd terraform
```

#### 2. Initialize Terraform
```bash
terraform init
```

#### 3. Review the Plan
```bash
terraform plan
```

#### 4. Apply the Configuration
```bash
terraform apply
```

---

### **Terraform Configuration Details**

#### `main.tf`

### **Access the Service**
Once the infrastructure is deployed, Terraform will output the external IP address of the LoadBalancer service. Use this IP to access the **SimpleTimeService**:
```
http://<load-balancer-ip>
```

---

### **Destroy Infrastructure**
To tear down the infrastructure:
```bash
terraform destroy
```
---

## **Conclusion**
This repository demonstrates the creation of a simple web service, containerization, and deployment to GCP using Terraform. Follow the instructions in this README to build, run, and deploy the **SimpleTimeService**.
