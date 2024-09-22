view: dim_internal_user {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_INTERNAL_USER_MV` ;;

  dimension: firstname {
    type: string
    description: "FIRSTNAME"
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: id {
    type: number
    description: "ID"
    sql: ${TABLE}.ID ;;
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

  dimension: nk_hk_dim_internal_user {
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
