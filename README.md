````markdown
# 🚀 Calculator Web App – CI/CD Pipeline using Jenkins & Docker

## 📌 Project Overview
The goal of this project was simple yet powerful:

**Automate the process of building a web application, containerizing it, and pushing the Docker image to Docker Hub using Jenkins.**

This project demonstrates a complete **CI/CD workflow** from source code to a running containerized application.

---

## 🛠️ Tools & Technologies Used
- **Frontend:** HTML, Tailwind CSS, JavaScript  
- **Source Control:** GitHub  
- **Containerization:** Docker & Docker Hub  
- **CI/CD:** Jenkins (Pipeline Job)  
- **Web Server:** Nginx  
- **OS:** Windows  

---

## 🧩 1. Project Development
I built a **Calculator Web Application** using:
- **HTML** for structure  
- **Tailwind CSS** for responsive and clean UI  
- **JavaScript** for calculator functionality  

Once the application was completed, the source code was pushed to **GitHub**, which acts as the **SCM (Source Code Management)** system. Jenkins pulls the code automatically from GitHub during pipeline execution.

---

## 🐳 2. Dockerization of the Application
To ensure consistency across environments, the application was containerized using **Docker**.

### Key Steps:
- Created a `Dockerfile`
- Used **Nginx** as a lightweight web server
- Copied static HTML files into Nginx’s default web directory

This guarantees that the application runs identically on any machine with Docker installed.

---

## ⚙️ 3. Jenkins Pipeline Setup
Instead of a freestyle job, a **Jenkins Pipeline job** was used for better scalability and maintainability.

### What was done:
- Installed and configured Jenkins on **Windows**
- Created a `Jenkinsfile` inside the GitHub repository
- Used **Pipeline script from SCM**, allowing Jenkins to read the pipeline directly from GitHub

This follows **industry best practices**, where pipeline code is version-controlled.

### 📄 Jenkinsfile
```groovy
pipeline {
    agent any

    environment {
        IMAGE_NAME = "anumitha/calculator-app"
        IMAGE_TAG  = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %IMAGE_NAME%:%IMAGE_TAG% .'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat '''
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                bat 'docker push %IMAGE_NAME%:%IMAGE_TAG%'
            }
        }
    }

    post {
        success {
            echo 'Docker image built and pushed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
````

---

## 🔐 4. Secure Credential Management

Security is critical in CI/CD pipelines.

To avoid hardcoding secrets:

* Generated a **Docker Hub access token**
* Stored it securely in **Jenkins Credentials Manager**
* Referenced it in the pipeline using:

  ```
  credentialsId: 'dockerhub-creds'
  ```

This ensures secure authentication without exposing sensitive data.

---

## 🔄 5. CI/CD Pipeline Execution Flow

When the pipeline runs, Jenkins automatically performs:

1. Clones the source code from GitHub
2. Builds a Docker image using the Dockerfile
3. Authenticates to Docker Hub securely
4. Pushes the Docker image to Docker Hub

📦 **Published Image:**

```
anumitha/calculator-app:latest
```

This automation eliminates all manual build and push steps.

---

## 🧠 6. Platform-Specific Challenge (Key Learning)

### Issue Faced:

* Jenkins was running on **Windows**
* Linux shell commands were initially used:

  ```
  sh 'docker build ...'
  ```

### Fix Applied:

* Replaced Linux commands with Windows-compatible ones:

  ```
  sh  →  bat
  $VAR → %VAR%
  ```

### Key Learning:

This debugging experience provided deep insight into **OS-specific Jenkins agents** and pipeline behavior.

---

## ▶️ 7. Running the Application via Docker

After pushing the image to Docker Hub, the container was run using:

```bash
docker run -d -p 9090:80 --name calculator-app anumitha/calculator-app:latest
```

🌐 Application URL:

```
http://localhost:9090
```

This confirmed that the containerized application was running successfully.

---

## ✅ Final Outcome

By completing this project, I achieved:

* A fully automated **CI/CD pipeline**
* Secure Docker image build and push
* Hands-on debugging of real pipeline issues
* Strong understanding of Docker image tagging and port mapping

---

## 🔁 Final Workflow

```
VS Code → GitHub → Jenkins → Docker Hub → Docker Container → Browser
```

---

## 📌 Key Takeaways

* CI/CD pipelines should always be **version-controlled**
* Credentials must be handled **securely**
* OS-specific behavior matters in Jenkins pipelines
* Docker image tagging and port mapping are critical concepts
* Real learning happens when debugging real failures

---

## 🏁 Conclusion

This project provided **real-world DevOps exposure**, beyond just theory.
Building, breaking, fixing, and automating the pipeline helped solidify my understanding of **Jenkins, Docker, and CI/CD best practices**.

💡 *If you’re starting your DevOps journey, building a similar pipeline is one of the best ways to learn.*

`#Jenkins` `#Docker` `#CICD` `#DevOps`
`#LearningByDoing` `#GitHub` `#Automation`

```

