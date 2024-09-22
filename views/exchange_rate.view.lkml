view: exchange_rate {

  derived_table: {
    #datagroup_trigger: data_platform_load
    sql:
    WITH USD_RT AS (
          SELECT DISTINCT
            ftr.PROCESS_DATE AS EFFCTV_DT,
            ftr.TRANSCTN_CURRNC AS CURRNC,
            ftr.EXCHNG_RATE_TO_CAD AS FX_RT,
     FROM `@{bq_project_id}.@{bq_dataset_name}.FACT_TRANSCTN_RR` ftr
          WHERE
              ftr.TRANSCTN_CURRNC = 'USD' and ftr.EXCHNG_RATE_TO_CAD != 1
        ),
FX as (
      SELECT
        DD.DATE_ID AS EFFCTV_DT,
        CURRNC,
        COALESCE(usd_rt.FX_RT, LAG(usd_rt.FX_RT) OVER (PARTITION BY CURRNC ORDER BY DD.DATE_ID), 0)    AS FX_RT
      FROM `@{bq_project_id}.@{bq_dataset_name}.DIM_DATE` DD
      LEFT JOIN usd_rt ON usd_rt.EFFCTV_DT = DD.DATE_ID and usd_rt.CURRNC = CURRNC
      WHERE   DD.WEEKDAY_IND
)
SELECT EFFCTV_DT AS EXRT_DATE,CURRNC AS EXRT_FROM_CURRENCY, FX_RT AS EXRT_VALUE_TO_CAD
 FROM FX
WHERE  EFFCTV_DT ="{{ _user_attributes['latest_holding_date_dev'] }}"
    ;;
    }


  dimension_group: exrt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.EXRT_DATE ;;
  }


  dimension: exrt_from_currency {
    type: string
    sql: ${TABLE}.EXRT_FROM_CURRENCY ;;
  }

  dimension: exrt_value_to_cad {
    type: number
    sql: ${TABLE}.EXRT_VALUE_TO_CAD ;;
  }


  measure: count {
    type: count
  }
}