view: dim_allctn {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_ALLCTN_MV` ;;

  dimension: allocation_code {
    type: string
    sql: ${TABLE}.ALLOCATION_CODE ;;
  }

  dimension: allocation_type {
    type: string
    sql: ${TABLE}.ALLOCATION_TYPE ;;
  }

  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: nk_hk_dim_allctn {
    type: number
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

  measure: count {
    type: count
  }
}
