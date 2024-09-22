view: fact_rel_accnt_benfcr {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_BENFCR_MV` ;;


  fields_hidden_by_default: yes


  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: md_hash_nat_keys {
    type: number
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_benfcr {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_BENFCR ;;
  }


  measure: count {
    type: count
  }
}
