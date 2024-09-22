view: dim_prodct_locale {

  derived_table: {
    datagroup_trigger: data_platform_load
    sql: select * from `@{bq_project_id}.@{bq_dataset_name}.DIM_PRODCT_LOCALE` ;;
  }
  drill_fields: [id]

  fields_hidden_by_default: yes


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }


  dimension: lang_cd {
    type: string
    sql: ${TABLE}.LANG_CD ;;
  }

  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: prodct_tp__descrptn {
    type: string
    sql: ${TABLE}.PRODCT_TP.DESCRPTN ;;
    group_label: "Prodct Tp"
    group_item_label: "Descrptn"
  }

  dimension: prodct_tp__long_desc {
    type: string
    sql: ${TABLE}.PRODCT_TP.LONG_DESC ;;
    group_label: "Prodct Tp"
    group_item_label: "Long Desc"
  }

  dimension: prodct_tp__name {
    type: string
    sql: ${TABLE}.PRODCT_TP.NAME ;;
    group_label: "Prodct Tp"
    group_item_label: "Name"
  }

  dimension: prodct_tp__shrt_desc {
    type: string
    sql: ${TABLE}.PRODCT_TP.SHRT_DESC ;;
    group_label: "Prodct Tp"
    group_item_label: "Shrt Desc"
  }

  dimension: prodct_tp__shrt_name {
    type: string
    sql: ${TABLE}.PRODCT_TP.SHRT_NAME ;;
    group_label: "Prodct Tp"
    group_item_label: "Shrt Name"
  }

  dimension: prodct_tp__value {
    type: string
    sql: ${TABLE}.PRODCT_TP.VALUE ;;
    group_label: "Prodct Tp"
    group_item_label: "Value"
  }
  measure: count {
    type: count
    drill_fields: [id, prodct_tp__name, prodct_tp__shrt_name]
  }
}
