view: holding_param_values {
  derived_table: {
    sql:
      WITH
      hds AS (
      SELECT
        partition_id
      FROM
        `@{bq_project_id}.@{bq_dataset_name}.INFORMATION_SCHEMA.PARTITIONS`
      WHERE
        table_name = 'FACT_HOLDNG_RR'
        AND partition_id <> "__NULL__"),
      lhd AS (
      SELECT
        MAX(partition_id) AS LATEST_HOLDING_DATE
      FROM
        hds),
      phd AS (
      SELECT
        MAX(partition_id) AS PREV_HOLDING_DATE
      FROM
        hds
      WHERE
        partition_id <> (
        SELECT
          LATEST_HOLDING_DATE
        FROM
          lhd) ),
      ylhd AS (
      SELECT
        LEFT(partition_id,4) AS HOLDING_YEAR,
        PARSE_DATE('%Y%m%d',MAX(partition_id)) AS LAST_HOLDING_DATE
      FROM
        hds
      GROUP BY
        1 ),
      ylhd_list AS(
      SELECT
        STRING_AGG(CAST(LAST_HOLDING_DATE AS STRING),",") AS YEARLY_LHD_LIST
      FROM
        ylhd
        WHERE HOLDING_YEAR <> CAST(EXTRACT(YEAR FROM CURRENT_DATE()) AS STRING)
      ORDER BY
        1 ),
    last_12m_dates AS(
      SELECT
    EXTRACT(YEAR FROM PARSE_DATE('%Y%m%d',partition_id)) AS year,
    EXTRACT(MONTH FROM PARSE_DATE('%Y%m%d',partition_id)) AS month,
    Max(PARSE_DATE('%Y%m%d',partition_id)) as eom_business_day
    FROM hds
    WHERE PARSE_DATE('%Y%m%d',partition_id) < DATE_TRUNC(CURRENT_DATE(), MONTH)
    group by 1,2
    order by 3 desc
    limit 12),
    last_12m_date_list AS(
    select STRING_AGG(cast(eom_business_day as STRING),',') as L12M_LHD_LIST from last_12m_dates
    )
    SELECT
      PARSE_DATE('%Y%m%d',lhd.LATEST_HOLDING_DATE) AS LATEST_HOLDING_DATE,
      PARSE_DATE('%Y%m%d',phd.PREV_HOLDING_DATE) AS PREV_HOLDING_DATE,
      YEARLY_LHD_LIST,
      L12M_LHD_LIST
    FROM
      lhd
    JOIN
      phd ON TRUE
    JOIN
      ylhd_list ON TRUE
    JOIN last_12m_date_list ON TRUE;;
  }

  dimension: latest_holding_date {
    type: string
    description: "Latest Holding Date"
    sql: ${TABLE}.LATEST_HOLDING_DATE ;;
  }
  dimension: prev_holding_date {
    type: string
    description: "Previous Holding Date"
    sql: ${TABLE}.PREV_HOLDING_DATE ;;
  }
  dimension: yearly_lhd_list {
    type: string
    description: "Yearly Last Holding Date List"
    sql: ${TABLE}.YEARLY_LHD_LIST ;;
  }
  dimension: last_business_date_12_months {
    type: string
    description: "Last 12 months Holding Date List"
    sql: ${TABLE}.L12M_LHD_LIST ;;
  }
  # parameter: param_year {
  #   type: number
  #   default_value: "0"
  # }

  # dimension: year_filter {
  #   type: string
  #   hidden: yes
  #   description: "Year Filter"
  #   sql: CAST (CASE
  #         WHEN {% parameter fact_holdng_rr.param_year %} = 0
  #         THEN  EXTRACT(YEAR FROM CURRENT_DATE()) -1
  #         ELSE ({% parameter fact_holdng_rr.param_year %} - 1)
  #       END
  #         AS STRING)
  #   ;;
  # }

  # dimension: year_lhd {
  #   type: string
  #   description: "Yearly Last Holding Date Filter"
  #   sql: CASE
  #         WHEN INSTR("{{ _user_attributes['yearly_lhd_list'] }}",${year_filter}) = 0 THEN  NULL
  #         ELSE
  #         SUBSTRING("{{ _user_attributes['yearly_lhd_list'] }}",INSTR("{{ _user_attributes['yearly_lhd_list'] }}",${year_filter}),10)
  #         END

  #     ;;
  # }

}
