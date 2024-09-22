view: last_holding_date_by_year {

  derived_table: {
    datagroup_trigger: data_platform_load
    sql:

    WITH balance_dates AS (
    SELECT   PARSE_DATE('%Y%m%d',partition_id) AS BALANCE_DT
    FROM `@{bq_project_id}.@{bq_dataset_name}.INFORMATION_SCHEMA.PARTITIONS`
    WHERE table_name = 'FACT_HOLDNG_RR'
    and partition_id <> "__NULL__"
    )
    SELECT EXTRACT(YEAR FROM BALANCE_DT) AS HOLDNG_YEAR, MAX(BALANCE_DT) LAST_UPDATE_DATE
    FROM balance_dates
    GROUP BY  1

    ;;
  }


  dimension_group: last_update {
    type: time
    description: "Last update Holding Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LAST_UPDATE_DATE ;;
  }

  dimension: holdng_year {
    type: number
    description: "Holding Year"
    sql: ${TABLE}.HOLDNG_YEAR ;;
  }


  parameter: param_year {
    type: number
    default_value: "0"
  }



}
