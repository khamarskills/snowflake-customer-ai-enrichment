CREATE OR REPLACE TASK generate_customer_ai_insights
WAREHOUSE = compute_wh
SCHEDULE = 'USING CRON 0 3 * * * UTC'  -- daily at 3 AM
AS
INSERT OVERWRITE INTO customer_ai_insights_table
SELECT
    cs.customer_id,

    CONCAT(
        'Municipality: ', cs.account_name, '. ',
        'Type: ', cs.account_type, '. ',
        'Location: ', cs.city, ', ', cs.state, '. ',
        'Modules: ', ARRAY_TO_STRING(cs.modules_list, ', '), '. ',
        'Total contract value: $', cs.total_contract_value, '. ',
        'Segment: ', cs.segment_label
    ) AS profile_text,

    SNOWFLAKE.CORTEX.COMPLETE(
        'snowflake-arctic',
        CONCAT(
            'Summarize this municipality customer account for a business user. ',
            'Focus on health, risks, and opportunities. ',
            'Profile: ',
            cs.account_name, ', ',
            'Modules: ', ARRAY_TO_STRING(cs.modules_list, ', '), ', ',
            'Segment: ', cs.segment_label
        )
    ) AS account_summary,

    SNOWFLAKE.CORTEX.COMPLETE(
        'snowflake-arctic',
        CONCAT(
            'Based on the customer profile, suggest next best action ',
            '(renewal focus, upsell, or maintain). ',
            'Profile: ',
            cs.account_name, ', ',
            'Segment: ', cs.segment_label
        )
    ) AS recommended_action,

    CURRENT_TIMESTAMP()

FROM customer_segmentation cs;
