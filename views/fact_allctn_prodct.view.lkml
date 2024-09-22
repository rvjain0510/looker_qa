view: fact_allctn_prodct {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_ALLCTN_PRODCT` ;;

  measure: allocation_prodct_pct {
    type: sum
    description: "ALLOCATION_PRODCT_PCT"
    sql: ${TABLE}.ALLOCATION_PRODCT_PCT ;;
  }

  dimension_group: as_of_dt {
    type: time
    description: "As Of Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AS_OF_DT ;;
  }

dimension: id {
  type: number
  primary_key: yes
}

  dimension: nk_hk_dim_allctn {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ALLCTN ;;
  }

  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_PRODCT ;;
  }


  measure: count {
    type: count
  }
}
