# AWS Elastic Beanstalk Node.js Sample App

This repository contains a sample Node.js web application built using [Express](https://expressjs.com/), meant to be used as part of the AWS DevOps Learning Path.

## Project Overview

This project demonstrates the deployment of a Node.js web application in a secure CI/CD pipeline using Jenkins and Docker. The Jenkins pipeline automates the build, testing, and deployment of the application.

### Project Structure

- `app.js`: The main application file, refactored to use environment variables and export the app for reuse in testing.
- `tests/`: Contains the test cases for the application using Supertest and Jest.
- `Dockerfile`: Used to build the Node.js application as a Docker image for deployment.
- `Jenkinsfile`: Defines the CI/CD pipeline in Jenkins, automating the building, testing, and deployment of the application.

## Prerequisites

- Node.js 16.x
- Docker and Docker Compose
- Jenkins with the required plugins (Blue Ocean, Docker Pipeline, and Snyk)
- GitHub account

## Setup Instructions

1. **Fork this repository**: [AWS Elastic Beanstalk Node.js Sample](https://github.com/aws-samples/aws-elastic-beanstalk-express-js-sample).
   
2. **Clone the repository** to your local machine:
    ```bash
    git clone https://github.com/YourUsername/aws-elastic-beanstalk-express-js-sample.git
    ```

3. **Install dependencies**:
    ```bash
    npm install
    ```

4. **Run the application locally**:
    ```bash
    npm start
    ```

## Running Tests

This application uses Jest and Supertest for testing.

To run the tests, execute:
```bash
npm test
```

## CI/CD Pipeline with Jenkins

The CI/CD pipeline automates the build, testing, and deployment process for the Node.js application.

- **Jenkinsfile**: The pipeline uses a Node 16.x Docker image as the build agent.
- Dependencies are installed using `npm install`.
- Security scanning is integrated using Snyk.
- If vulnerabilities are found during the build or test stages, the pipeline halts.

### Security Integration

- Snyk is used for vulnerability scanning in the project dependencies.
- The pipeline will stop if any critical vulnerabilities are detected.

### Logging and Monitoring with Splunk

Splunk is integrated into the Jenkins pipeline to capture logs and provide real-time monitoring of the CI/CD process.

#### Docker Compose Splunk Setup:

- The `docker-compose.yml` is modified to include a Splunk instance to collect and analyze logs from Jenkins.

#### Configure Splunk:

1. Install the Splunk plugin for Jenkins.
2. Login to the Splunk instance (`http://localhost:8000`) with the default credentials (admin/changeme).
3. Set up a new HTTP Event Collector (HEC) token in Splunk to receive logs from Jenkins.
4. Paste the token in Jenkins under the Splunk plugin settings and enable log forwarding.

#### Viewing Logs:

- Access the Jenkins logs and pipeline execution data directly in the Splunk dashboard.
- Splunk will track key events like build failures, test results, and security scan outcomes, providing real-time insights into the pipeline's health.

## Security

For information about how to report security issues, see [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications).

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

