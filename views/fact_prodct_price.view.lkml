view: fact_prodct_price {

  derived_table: {
    sql:
    WITH
  MAX_PRD_DATE AS (
  SELECT
    NK_HK_DIM_PRODCT,
    MAX(EFFECTIVE_DATE) AS MAX_EFF_DATE
  FROM
    `@{bq_project_id}.@{bq_dataset_name}.FACT_PRODCT_PRICE`
  GROUP BY
    1 )
SELECT
  pp.ID,
  pp.NK_HK_DIM_PRODCT,
  pp.EFFECTIVE_DATE,
  pp.MARKET_PRICE_BID,
  pp.MARKET_PRICE_ASK,
  pp.MARKET_PRICE_CLOSE,
  pp.MARKET_PRICE_LOW,
  pp.MARKET_PRICE_HIGH
FROM
  `@{bq_project_id}.@{bq_dataset_name}.FACT_PRODCT_PRICE` pp
INNER JOIN
  MAX_PRD_DATE
ON
  MAX_PRD_DATE.MAX_EFF_DATE = pp.EFFECTIVE_DATE
  AND MAX_PRD_DATE.NK_HK_DIM_PRODCT = pp.NK_HK_DIM_PRODCT
    ;;
  }

  dimension_group: effective {
    type: time
    description: "SK_DIM_PRODCT"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EFFECTIVE_DATE ;;
  }

  dimension: id {
    type: number
    description: "ID"
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

  dimension: market_price_ask {
    type: number
    value_format: "#,##0.00"
    description: "Market Price Ask"
    sql: ${TABLE}.MARKET_PRICE_ASK ;;
  }


  dimension: market_price_bid {
    type: number
    value_format: "#,##0.00"
    description: "Market Price Bid"
    #value_format_name: id
    sql: ${TABLE}.MARKET_PRICE_BID ;;
  }

  dimension: market_price_close {
    type: number
    value_format: "#,##0.00"
    description: "Market Price Close"
    sql: ${TABLE}.MARKET_PRICE_CLOSE ;;
  }

  dimension: market_price_high {
    type: number
    value_format: "#,##0.00"
    description: "Market Price High"
    sql: ${TABLE}.MARKET_PRICE_HIGH ;;
  }

  dimension: market_price_low {
    type: number
    value_format: "#,##0.00"
    description: "Market Price Low"
    sql: ${TABLE}.MARKET_PRICE_LOW ;;
  }


  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    description: "SK_DIM_REGSTR_REPRSNTTV"
    sql: ${TABLE}.NK_HK_DIM_PRODCT ;;
  }


  measure: count {
    type: count
  }
}
