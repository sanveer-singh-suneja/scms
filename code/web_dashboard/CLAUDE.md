# SCMS Web Dashboard

This directory contains the SCMS browser-based dashboard.

IMPORTANT:
This is NOT Flutter.

The mobile application is located in:
../flutter_app

The web dashboard is intended primarily for:
- Staff
- Admin

## Admin features

- Dashboard
- Inventory management
- Analytics
- Defaulter list
- Fairness configuration
- Staff account management

## Staff features

- Dashboard
- Inventory
- Issue/return operations
- QR scanning if supported by browser/device

## Rules

- Follow ../docs/REQUIREMENTS.md
- Follow ../docs/API_CONTRACT.md
- Follow ../docs/USER_ROLES.md
- Follow ../docs/WORKFLOWS.md
- Follow ../docs/FAIRNESS_ALGORITHM.md

Never invent backend APIs.

Never independently calculate fairness allocation.

Backend remains source of truth.

Do not modify flutter_app unless explicitly requested.