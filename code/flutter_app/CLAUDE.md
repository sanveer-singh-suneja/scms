# Flutter Mobile Application

## Purpose

This directory contains the SCMS mobile application.

Target platforms:
- Android
- iOS

This is NOT the web dashboard.

## Technology

Flutter
Dart
Riverpod
GoRouter
Dio

## QR

qr_flutter
mobile_scanner

## Charts

fl_chart

## Calendar

table_calendar

## Responsibilities

The mobile app provides:

Student:
- login
- equipment browsing
- booking
- queue
- digital QR
- history
- notifications

Staff:
- QR scanning
- issue
- return
- damage logging
- inventory access where applicable

## Rules

- Follow /docs/REQUIREMENTS.md
- Follow /docs/API_CONTRACT.md
- Follow /docs/USER_ROLES.md
- Follow /docs/WORKFLOWS.md
- Follow /docs/FAIRNESS_ALGORITHM.md
- Do not invent API endpoints.
- Do not implement fairness allocation locally.
- Backend is the source of truth.
- Do not modify web_dashboard.
- Keep Android and iOS behavior consistent.