# Enterprise DevSecOps IaC Pipeline

This repository contains the core source code, CI/CD configurations, and infrastructure-as-code automation templates for an automated, "Shift-Left" cloud security pipeline.

## Full Project Explanation & Live UI
For a comprehensive architectural breakdown, visual execution flows, and deep-dive case study of this project, please visit the interactive showcase website:

👉 **[View the Live Project Showcase & Explanation](https://pleontis.github.io/devsecops-dashboard/)**

---

## Core Tech Stack Covered Here
* **Infrastructure as Code:** Terraform (Azure Provider)
* **CI/CD Automation:** GitHub Actions
* **Security Scanning:** Checkov Static Analysis Engine (AST Parsing)
* **Custom Governance:** Python Validation Scripts

## Repository Structure At A Glance
* `.github/workflows/` — Continuous Integration pipelines mapping rules against branch updates.
* `terraform/` — Reusable cloud infrastructure modules with secure remote backend state-locking.
* `scripts/` — Custom Python scripts enforcing corporate compliance and asset tagging standards.

For details on how the pipeline blocks misconfigurations before deployment to Azure, check out the live site linked above!
