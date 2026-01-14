# Customer Intelligence & AI Enrichment with Snowflake

## Overview
This project demonstrates how curated customer data in **Snowflake** can be enhanced with **AI-driven insights** using **Snowflake Cortex**.  
The focus is on **downstream analytics and GenAI enrichment**, assuming upstream ingestion and deduplication pipelines already exist.

---

## Business Problem
Municipality customers purchase multiple financial software modules (GL, AP, AR, CR), but the business lacks:
- A unified view of customer value
- Visibility into module adoption
- Actionable insights for renewals and upsell opportunities

---

## Solution
- Customer-level metrics built from module-grain product data
- Rule-based customer segmentation
- AI-generated account summaries and recommendations using Snowflake Cortex
- Cost-controlled AI execution via Snowflake Tasks

---

## Data Model
- **Customer (Gold):** Deduplicated customer attributes  
- **Products:** One row per customer per module (module-level grain)

---

## AI Enrichment
Uses `SNOWFLAKE.CORTEX.COMPLETE` with the **snowflake-arctic** model to generate:
- Business-friendly account summaries
- Recommended next actions

AI outputs are **materialized into tables** and refreshed via **scheduled Tasks** to control cost.

---

## Repository Structure

- sql/            # Setup, analytics, and AI scripts
  - setup/        # Warehouse, database, schema scripts
  - analytics/    # Customer metrics and segmentation
  - ai/           # Cortex model tests and AI Tasks
- data/           # Sample input CSVs
  - sample_inputs/
- docs/           # Scope and interview notes

------
## Scope & Assumptions
- Customer data is already curated and deduplicated
- Product data is modeled at module grain
- Upstream ingestion (Bronze/Silver) is out of scope
- Focus is on analytics and AI enrichment

---

## Why This Project Matters
This project demonstrates:
- Correct grain-aware data modeling
- Practical customer analytics
- Responsible GenAI usage in Snowflake
- Cost and governance awareness
- Production-style task orchestration

---

## Tech Stack
- Snowflake SQL
- Snowflake Cortex
- Snowflake Tasks
- GitHub

---

## How to Run (High Level)
1. Create database, schema, and warehouse
2. Load sample customer and product data
3. Create customer metrics and segmentation views
4. Enable AI enrichment task
5. Query AI insights table for business summaries

---

## Future Enhancements
- Incremental AI refresh based on data changes
- Vector embeddings for semantic customer search
- Integration with BI tools (Tableau / Power BI)
- Sentiment analysis from support or survey data

---

## Author
Your Name  
Snowflake Data Engineer | Analytics & GenAI Integration
