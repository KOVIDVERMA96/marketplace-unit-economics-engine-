# Marketplace Commercial Unit Economics & Operational Risk Engine

---

## Executive Summary

In high-growth, two-sided digital marketplaces, expanding **Gross Merchandise Value (GMV)** often creates a false sense of security for leadership[cite: 1]. Aggressive customer acquisition can mask severe underlying operational friction: rapid customer logo decay, supply-side revenue concentration, and third-party logistics (3PL) delivery failures that depress repeat purchasing[cite: 1, 3].

This project audits **100,000+ commercial transactions** from the Olist marketplace in **PostgreSQL** to establish four analytics data marts and connects them to a 3-page **Power BI executive dashboard**[cite: 1, 3].

```
┌───────────────────────────┐      ┌───────────────────────────┐      ┌───────────────────────────┐
│     PAGE 1: COMMERCIAL    │      │     PAGE 2: RETENTION     │      │     PAGE 3: LOGISTICS     │
│   Item vs. Freight GMV,   │ ───> │  12-Mo Customer Cohorts,  │ ───> │ Fulfillment Decomposition,│
│  Installment Debt Profile │      │ 80/20 Seller Pareto Risk  │      │ SLA Drift vs. Review Drag │
└───────────────────────────┘      └───────────────────────────┘      └───────────────────────────┘

```

---

## Key Commercial & Operational Findings

### 1. Supply-Side Concentration Risk (The 80/20 Rule)

* **The Finding:** **Decile 1 alone accounts for 67.1% of total marketplace GMV**, with the cumulative **Pareto benchmark (80%) crossed by Decile 2 (82.3%)**.
* **The Business Implication:** Over four-fifths of platform gross volume depends on the top 20% of merchants[cite: 1]. If key sellers churn or face inventory disruption, platform cash generation drops sharply[cite: 1].

### 2. Month-1 Customer Retention Cliff

* **The Finding:** Tracking real customer identities (`customer_unique_id`) reveals that **Month-1 logo retention drops below 1% across every cohort**[cite: 1, 3].
* **The Business Implication:** Top-line GMV expansion relies almost exclusively on continuous, expensive top-of-funnel customer acquisition rather than compounding customer lifetime value ($LTV$)[cite: 1].

### 3. Fulfillment SLA Drift vs. Customer Review Drag

* **The Finding:** On-time orders average **4.29 out of 5.0 stars**, holding steady for minor delays of 1–3 days (**3.76 stars**)[cite: 1]. However, delays beyond 3 days cross a satisfaction cliff, crashing scores to **1.73 stars** for orders delivered >7 days late[cite: 1].
* **The Diagnostic:** Lead-time decomposition shows this drag is driven by **3PL carrier transit duration** (surging from 7.9 days to 36.3+ days on late orders), while merchant warehouse dispatch latency remains flat at ~2.8 to 6.0 days across all delay tiers[cite: 1].

---

## Technical Architecture & Lineage

```
                                  DATA PIPELINE & MODELING
                                  
  RAW RELATIONAL STAGING                 ANALYTICAL TRANSFORMATION                 REPORTING LAYER
┌─────────────────────────┐               ┌─────────────────────────┐           ┌────────────────────────┐
│ olist_orders            │               │ CTEs, Window Functions  │           │   POWER BI DASHBOARD   │
│ olist_order_items       │ ────────────> │ (NTILE, LAG, SUM OVER)  │ ────────> │ Page 1: Commercial P&L │
│ olist_order_payments    │               │ Staging Views           │           │ Page 2: Cohorts/Pareto │
│ olist_customers         │               └────────────┬────────────┘           │ Page 3: Logistics SLAs │
│ olist_order_reviews     │                            │                        └────────────────────────┘
└─────────────────────────┘                            ▼
                                         PRODUCTION DATA MARTS
                              ┌───────────────────────────────────────────┐
                              │ 01. mart_monthly_commercial_actuals       │
                              │ 02. mart_cohort_retention_actuals         │
                              │ 03. mart_seller_concentration             │
                              │ 04. mart_logistics_sla_reviews            │
                              └───────────────────────────────────────────┘

```

---

## Data Mart Schema Reference

### 1. `mart_monthly_commercial_actuals`

* **Grain:** `order_month` $\times$ `product_category`[cite: 1]
* **Key Metrics:** Realized Item GMV, Gross Freight Value, Net Payment Realization, Average Order Value (AOV), and Installment Tier Volumes[cite: 1, 3].

### 2. `mart_cohort_retention_actuals`

* **Grain:** `cohort_month` $\times$ `period_index` ($M_0$ through $M_{12}$)[cite: 1, 3]
* **SQL Mechanism:** Uses `MIN(order_purchase_timestamp) OVER (PARTITION BY customer_unique_id)` to resolve human buyers and calculate cohort return rates[cite: 1, 3].

### 3. `mart_seller_concentration`

* **Grain:** `seller_decile` (1 through 10)
* **SQL Mechanism:** Applies `NTILE(10) OVER (ORDER BY total_seller_gmv DESC)` to establish deciles, computes running cumulative volume share, and appends a static `0.80` Pareto benchmark line.

### 4. `mart_logistics_sla_reviews`

* **Grain:** `order_id`[cite: 3]
* **Key Metrics:** Internal dispatch lead time (`order_delivered_carrier_date - order_approved_at`), courier transit duration (`order_delivered_customer_date - order_delivered_carrier_date`), promised delivery variance (`sla_variance_days`), delay buckets, and customer rating (`avg_order_review_score`)[cite: 3].

---

## Repository Structure

```text
marketplace-unit-economics-engine/
│
├── README.md                              <-- Project technical brief & executive takeaways
│
├── sql/
│   ├── 00_staging_schema_ddl.sql          <-- DDL ingestion schemas for raw Olist tables
│   ├── 01_mart_monthly_actuals.sql        <-- GMV realization, freight ratio, installments
│   ├── 02_mart_cohort_retention.sql       <-- Unique customer logo retention matrix
│   ├── 03_mart_seller_concentration.sql   <-- NTILE(10) Pareto GMV distribution & benchmark
│   └── 04_mart_logistics_sla_reviews.sql  <-- SLA variance, delay buckets & review score drag
│
├── data/
│   ├── sample_marts_export/               <-- Aggregated CSV mart exports for PBIX ingestion
│   │   ├── mart_monthly_actuals.csv
│   │   ├── mart_cohort_retention.csv
│   │   ├── mart_seller_concentration.csv
│   │   └── mart_logistics_sla_reviews.csv
│   └── data_dictionary.md                 <-- Definitions, primary keys, and column data types
│
├── powerbi/
│   └── olist_executive_reporting.pbix     <-- Complete 3-page executive dashboard
│
└── docs/
    └── images/
        ├── page1_commercial_pnl.png       <-- Dashboard preview images
        ├── page2_cohort_pareto.png
        └── page3_logistics_sla.png

```

---

## How to Reproduce

### Prerequisites

* **PostgreSQL 14+** (with access via pgAdmin, DBeaver, or `psql`)[cite: 2, 3]
* **Power BI Desktop**[cite: 1]
* Raw Olist Brazilian E-Commerce Dataset CSV files[cite: 1, 3]

### Step 1: Database Setup & Ingestion

1. Open your PostgreSQL console and create the database[cite: 3]:
```sql
CREATE DATABASE olist_ecommerce;

```


2. Connect to `olist_ecommerce` and execute `sql/00_staging_schema_ddl.sql` to generate staging tables with appropriate data types[cite: 3].
3. Import the raw CSVs using `\copy` (or the pgAdmin Import tool), ensuring header detection is active[cite: 3]:
```sql
\copy raw_order_reviews FROM 'path/to/olist_order_reviews_dataset.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ESCAPE '\', ENCODING 'UTF8');

```



### Step 2: Build the Analytics Marts

Execute the SQL scripts sequentially from `sql/01_...` to `sql/04_...`. These generate the analytical reporting tables required by the BI layer.

### Step 3: Connect to Power BI

1. Open `powerbi/olist_executive_reporting.pbix`[cite: 1].
2. If connecting directly to PostgreSQL: Go to **Transform Data** $\rightarrow$ **Data source settings** and update your server and database connection credentials.
3. *Alternative:* If reviewing without a live database, point the Data Source to the sample exports inside `data/sample_marts_export/` and click **Refresh**.

---

## Author & Contact

* **Analyst:** KOVID VERMA
* **LinkedIn:** https://www.linkedin.com/in/kovidv/
* **Focus Areas:** Commercial FP&A, Marketplace Analytics, SQL Data Modeling, BI Architecture[cite: 1, 2]
