CareerStream — Recruiter Module
[!Java 17](https://openjdk.org/projects/jdk/17/)
[!Spring Boot](https://spring.io/projects/spring-boot)
[!MySQL 8](https://www.mysql.com/)
[!Docker](https://www.docker.com/)
[!CI](https://github.com/neerajsait/RecruiterService/actions)
Live demo: neerajsait.github.io/RecruiterService — always points at the current deployment, with a recorded walkthrough if the server is down.
The recruiter module of CareerStream, a 3-module campus recruitment portal (recruiter, student, admin) built as a team academic project. This repository contains the recruiter-facing application: registration with admin approval, job posting management, applicant tracking, interview scheduling, and dashboard analytics — backed by a Spring Boot / MySQL backend and server-rendered JSP views.
The full 3-module system lives at JFSDSDPProject. This repo is the independently deployable recruiter module.

Features
Recruiter onboarding — registration, admin approval workflow, login/logout with session management
Job posting management — create, edit, delete postings; configure max applications per posting
Applicant tracking — view applicants per job, download resumes and marksheets, update application status
Interview scheduling — schedule interviews, track status (scheduled / selected / rejected)
Dashboard analytics — live stats on open jobs, applications received, and interviews scheduled
Task board — personal to-do list for recruitment tasks
Secure password recovery — 6-digit email OTP flow for forgotten passwords
Security hardening — BCrypt password hashing, CSRF tokens, Content Security Policy with dynamic nonces
Observability — Spring Boot Actuator (/actuator/health, /actuator/metrics)
Recruiter chatbot — in-app assistant endpoint (/recruiter/chat)

Tech stack
Layer
Technology
Language
Java 17
Backend
Spring Boot 3.x, Spring MVC, Spring Data JPA
Frontend
JSP, custom CSS, JavaScript
Database
MySQL 8.0
Security
Spring Security Crypto (BCrypt), CSRF protection, CSP headers
Testing
JUnit 5, Mockito, MockMvc (13+ tests)
CI/CD
GitHub Actions (Maven build + test on every push/PR)
Deployment
Docker Compose on Oracle Cloud (OCI), public via Cloudflare Tunnel

Getting started
Option A — Docker (recommended, closest to production)
git clone https://github.com/neerajsait/RecruiterService.git
cd RecruiterService

# Create .env with your secrets (see below), then:
docker-compose up -d
This starts three containers: the Spring Boot app, MySQL 8.0 (data persisted in a volume), and a Cloudflare Quick Tunnel exposing the app publicly.
Option B — Local
Prerequisites: JDK 17, Maven, MySQL 8 running locally.
git clone https://github.com/neerajsait/RecruiterService.git
cd RecruiterService
./mvnw clean install
./mvnw spring-boot:run
Open http://localhost:2007/recruiter/rlogin.
Configuration (.env / environment variables)
Variable
Purpose
MYSQL_DATABASE
Database name (auto-created on first run)
MYSQL_ROOT_PASSWORD
MySQL root password
SPRING_MAIL_*
SMTP settings for OTP and notification emails
CLOUDFLARED_TOKEN
Cloudflare tunnel token (Docker tunnel service only)

Key routes
All recruiter routes live under /recruiter:
Route
Description
GET /recruiter/rlogin
Recruiter login page
POST /recruiter/checkreclogin
Authenticate recruiter
GET /recruiter/rreg
Recruiter registration
GET /recruiter/rhome
Dashboard with live stats
GET /recruiter/radd_job_posting
New job posting form
GET /recruiter/rview_job_postings
Manage posted jobs
GET /recruiter/redit_job_posting
Edit a posting
GET /recruiter/rdelete_job_posting
Delete a posting
GET /recruiter/getapplicants
Applicants for a job
GET /recruiter/getResume/{studentId}
Download applicant resume
GET /recruiter/getMarksheets/{studentId}
Download applicant marksheets
GET /recruiter/setstatus/{id}/{status}
Update application status
GET /recruiter/getinterviewlist
Scheduled interviews
GET /recruiter/setinterviewstatus/{id}/{status}
Update interview outcome
GET /recruiter/forgot_password
OTP-based password recovery
GET /recruiter/rtask
Personal task board
GET /recruiter/rlogout
Logout

Testing
./mvnw test
Unit and integration tests (JUnit 5 + Mockito + MockMvc) cover the controller, service, and email layers. The full suite runs automatically in GitHub Actions on every push and pull request.

Deployment
Production runs on an Oracle Cloud free-tier VM via Docker Compose:
docker-compose up -d starts the app, MySQL, and Cloudflare tunnel
A startup script extracts the tunnel's public URL from the container logs
The URL is published to tunnel-url.json, which the demo landing page reads — so the public link never goes stale when the tunnel URL rotates

Screenshots
Dashboard
!Dashboard
Job posting
!Job posting
Applicants view
!Applicants
Login
!Login
Profile
!Profile

Roadmap
[ ] Break down the monolithic controller into feature-focused controllers
[ ] Migrate custom session/filter auth to full Spring Security
[ ] Add pagination and search to applicant and job listings
[ ] Email notifications for interview scheduling

Author
Tiruveedhi Neeraj Venkata Sai — B.Tech CSE '26, KL University
GitHub: @neerajsait
LinkedIn: neerajsait
Portfolio: neerajsait.netlify.app
