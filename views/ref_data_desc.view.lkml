view: ref_data_desc {

  sql_table_name: `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }


  dimension: attrbt_name_destntn {
    type: string
    sql: ${TABLE}.ATTRBT_NAME_DESTNTN ;;
  }

  dimension: attrbt_name_destntn_systm {
    type: string
    sql: ${TABLE}.ATTRBT_NAME_DESTNTN_SYSTM ;;
  }

  dimension: attrbt_name_src {
    type: string
    sql: ${TABLE}.ATTRBT_NAME_SRC ;;
  }

  dimension: attrbt_name_src_systm {
    type: string
    sql: ${TABLE}.ATTRBT_NAME_SRC_SYSTM ;;
  }

  dimension: attrbt_val_destntn__descrptn {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.DESCRPTN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Descrptn"
  }

  dimension: attrbt_val_destntn__descrptn_en {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.DESCRPTN_EN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Descrptn En"
  }

  dimension: attrbt_val_destntn__descrptn_fr {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.DESCRPTN_FR ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Descrptn Fr"
  }

  dimension: attrbt_val_destntn__long_desc {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.LONG_DESC ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Long Desc"
  }

  dimension: attrbt_val_destntn__long_desc_en {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.LONG_DESC_EN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Long Desc En"
  }

  dimension: attrbt_val_destntn__long_desc_fr {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.LONG_DESC_FR ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Long Desc Fr"
  }

  dimension: attrbt_val_destntn__name {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.NAME ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Name"
  }

  dimension: attrbt_val_destntn__name_en {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.NAME_EN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Name En"
  }

  dimension: attrbt_val_destntn__name_fr {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.NAME_FR ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Name Fr"
  }

  dimension: attrbt_val_destntn__shrt_desc {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_DESC ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Desc"
  }

  dimension: attrbt_val_destntn__shrt_desc_en {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_DESC_EN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Desc En"
  }

  dimension: attrbt_val_destntn__shrt_desc_fr {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_DESC_FR ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Desc Fr"
  }

  dimension: attrbt_val_destntn__shrt_name {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_NAME ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Name"
  }

  dimension: attrbt_val_destntn__shrt_name_en {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_NAME_EN ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Name En"
  }

  dimension: attrbt_val_destntn__shrt_name_fr {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_NAME_FR ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Name Fr"
  }

  dimension: attrbt_val_destntn__value {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.VALUE ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Value"
  }

  dimension: attrbt_val_src {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_SRC ;;
  }

  dimension: comment {
    type: string
    sql: ${TABLE}.COMMENT ;;
  }

  measure: count {
    type: count
    drill_fields: [id, attrbt_val_destntn__name, attrbt_val_destntn__shrt_name]
  }
}