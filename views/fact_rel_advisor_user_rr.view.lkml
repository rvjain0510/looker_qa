view: fact_rel_advisor_user_rr {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ADVISOR_USER_RR_MV` ;;


  fields_hidden_by_default: yes


  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: md_hash_nat_keys {
    type: number
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS;;
  }

  dimension: nk_hk_dim_advisor {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ADVISOR;;
  }

  dimension: nk_hk_dim_internal_user {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_INTERNAL_USER;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV;;
  }

  dimension: user_role {
    type: string
    hidden: no
    description: "USER_ROLE"
    sql: ${TABLE}.USER_ROLE ;;
  }

  dimension: user_type {
    type: string
    hidden: no
    description: "USER_TYPE"
    sql: ${TABLE}.USER_TYPE ;;
  }

}
