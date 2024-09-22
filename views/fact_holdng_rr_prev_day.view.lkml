view: fact_holdng_rr_prev_day {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR` ;;


  parameter: year_filter {
    type: number
    description: "Year Filter"
    default_value: "2022"

  }

  dimension: balance_dt {
    type: date
    datatype: date
    description: "BALANCE_DT"
    sql: ${TABLE}.BALANCE_DT ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    description: "ID"
    sql: ${TABLE}.ID ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_PRODCT ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: seq_num {
    type: string
    description: "Sequence Number"
    sql: ${TABLE}.SEQ_NUM ;;
  }


  dimension: markt_pric {
    type: number
    value_format: "#,##0.00"
    description: "Market Price"
    sql: ${TABLE}.MARKT_PRIC ;;
  }

  dimension: markt_pric_holdng_currnc {
    type: number
    value_format: "#,##0.00"
    description: "Market Price in Holding Currency"
    sql: ${TABLE}.MARKT_PRIC_HOLDNG_CURRNC ;;
  }

  dimension: holdng_currnc {
    type: string
    description: "Holding Currency"
    sql: ${TABLE}.HOLDNG_CURRNC ;;
  }


  measure: aua_converted_to_cad{
    type: sum
    value_format: "#,##0.00"
    description: "AUA Converted to CAD"
    sql: ${TABLE}.AUA_CONVERTED_TO_CAD ;;
  }

}
