view: dim_advisor {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_ADVISOR_MV` ;;

  dimension: advisor_id {
    type: string
    description: "ADVISOR_ID"
    sql: ${TABLE}.ADVISOR_ID ;;
  }

  dimension: firstname {
    type: string
    description: "FIRSTNAME"
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    description: "LASTNAME"
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: nk_hk_dim_advisor {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

  dimension: user_id {
    type: string
    description: "USER_ID"
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: user_type {
    type: string
    description: "USER_TYPE"
    sql: ${TABLE}.USER_TYPE ;;
  }
  measure: count {
    type: count
    drill_fields: [firstname, lastname]
  }
}
