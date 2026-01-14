CREATE OR REPLACE VIEW customer_metrics AS
WITH base AS (
    SELECT
        cp.customer_id,
        COUNT(DISTINCT cp.module) AS modules_count,
        ARRAY_AGG(DISTINCT cp.module) AS modules_list,
        COUNT_IF(cp.is_active) AS active_modules_count,

        SUM(cp.module_fee) AS total_contract_value,
        AVG(cp.module_fee) AS avg_module_fee,

        MIN(cp.ship_date) AS first_ship_date,
        MAX(cp.invoice_date) AS last_invoice_date,
        MAX(cp.contract_end_date) AS contract_end_date_max

    FROM customer_products cp
    GROUP BY cp.customer_id
)
SELECT
    b.customer_id,
    b.modules_count,
    b.modules_list,
    b.active_modules_count,
    
    b.total_contract_value,
    b.avg_module_fee,
    c
    b.first_ship_date,
    b.last_invoice_date,
    b.contract_end_date_max,

    -- Module adoption level: simple rule-based
    CASE 
        WHEN b.modules_count = 1 THEN 'LOW'
        WHEN b.modules_count = 2 THEN 'MEDIUM'
        WHEN b.modules_count >= 3 THEN 'HIGH'
        ELSE 'UNKNOWN'
    END AS module_adoption_level,

    -- Health score example (can refine later)
    CASE 
        WHEN b.active_modules_count = b.modules_count THEN 1.0
        ELSE 0.7
    END AS module_health_score

FROM base b;
