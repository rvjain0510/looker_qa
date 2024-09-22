view: ref_data_desc_locale {

  derived_table: {
    datagroup_trigger: data_platform_load
    sql: select * from `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC_LOCALE` ;;
  }
  drill_fields: [id]


  fields_hidden_by_default: yes

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

  dimension: attrbt_val_destntn__long_desc {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.LONG_DESC ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Long Desc"
  }

  dimension: attrbt_val_destntn__name {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.NAME ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Name"
  }

  dimension: attrbt_val_destntn__shrt_desc {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_DESC ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Desc"
  }

  dimension: attrbt_val_destntn__shrt_name {
    type: string
    sql: ${TABLE}.ATTRBT_VAL_DESTNTN.SHRT_NAME ;;
    group_label: "Attrbt Val Destntn"
    group_item_label: "Shrt Name"
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

  dimension: lang_cd {
    type: string
    sql: ${TABLE}.LANG_CD ;;
  }
  measure: count {
    type: count
    drill_fields: [id, attrbt_val_destntn__name, attrbt_val_destntn__shrt_name]
  }
}