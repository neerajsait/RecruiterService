# RecruiterService

> The recruiter-facing module of a campus recruitment portal.

## Overview

A Spring Boot application for recruiter workflows such as managing openings, reviewing applications, and coordinating interviews. It belongs to the larger CareerStream project; this repository documents the recruiter service on its own.

## What’s in this repo

- Recruiter dashboard and job-posting workflows
- Application review, interview coordination, and recruiter task management
- Maven wrapper, Dockerfile, Compose configuration, and application source

## Stack

Java 17, Spring Boot 3.3, Maven, MySQL, JSP/HTML/CSS/JavaScript, Docker.

## Getting started

1. Install JDK 17 and Docker, and configure the database and mail settings expected by the application.
2. Run with the Maven wrapper: `./mvnw spring-boot:run` (Windows: `mvnw.cmd spring-boot:run`).
3. A Compose file is included for the containerized setup; review its environment settings before starting it.

## Notes

This is one module of a larger academic group project, not the complete CareerStream platform. Keep database and SMTP credentials out of committed files; deployment links in older documentation may no longer be current.
