# Affiliate System MVP (Rails 8)

This repository is the starting point for a series where I document the evolution of an affiliate tracking system — from a simple Rails monolith to a fully distributed architecture with edge ingestion, event pipelines, attribution engines, and anti-fraud layers.

## What’s included

- Rails 8 API-only skeleton
- Core domain models:
  - Affiliates
  - Offers
  - Clicks
  - Conversions
  - Payouts
  - Domain validation
- Initial services:
  - AttributionService
  - FraudCheckService
- Background jobs (empty for now)

## What’s next

Each post in the series will expand this codebase:
1. Add attribution logic
2. Add fraud detection
3. Introduce real-time counters
4. Decouple tracking into a lightweight ingestion service
5. Move events into a distributed pipeline
6. Scale attribution and analytics

Follow the series for updates.
