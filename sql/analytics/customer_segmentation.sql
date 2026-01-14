CREATE OR REPLACE VIEW customer_segmentation AS
SELECT
    cg.customer_id,
    cg.account_name,
    cg.account_type,
    cg.city,
    cg.state,

    cm.modules_count,
    cm.modules_list,
    cm.total_contract_value,
    cm.module_adoption_level,
    cm.contract_end_date_max,

    -- Primary business segment
    CASE
        WHEN cm.contract_end_date_max <= DATEADD(day, 180, CURRENT_DATE)
            THEN 'RENEWAL_WATCH'

        WHEN cm.total_contract_value >= 100000
             AND cm.module_adoption_level IN ('LOW','MEDIUM')
            THEN 'EXPANSION_OPPORTUNITY'

        WHEN cm.total_contract_value >= 100000
             AND cm.module_adoption_level = 'HIGH'
            THEN 'CORE_STRATEGIC'

        ELSE 'STABLE_SMALL'
    END AS segment_label,

    -- Helpful flag for dashboards
    CASE
        WHEN cm.contract_end_date_max <= DATEADD(day, 180, CURRENT_DATE)
        THEN TRUE ELSE FALSE
    END AS renewal_risk_flag

FROM customer_gold cg
JOIN customer_metrics cm
  ON cg.customer_id = cm.customer_id;
