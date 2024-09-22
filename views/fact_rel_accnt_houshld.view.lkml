view: fact_rel_accnt_houshld {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_HOUSHLD_MV` ;;

  dimension: id {
    type: number
    description: "ID"
    primary_key: yes
    sql: ${TABLE}.ID ;;
  }

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
    description: "NK_DIM_ACCNT"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_advisor_created {
    type: number
    value_format: "0"
    description: "NK_DIM_ADVISOR_CREATED"
    sql: ${TABLE}.NK_HK_DIM_ADVISOR_CREATED ;;
  }

  dimension: nk_hk_dim_houshld {
    type: number
    value_format: "0"
    description: "NK_DIM_HOUSHLD"
    sql: ${TABLE}.NK_HK_DIM_HOUSHLD ;;
  }

  dimension: nk_hk_dim_internal_user_created {
    type: number
    value_format: "0"
    description: "NK_DIM_INTERNAL_USER_CREATED"
    sql: ${TABLE}.NK_HK_DIM_INTERNAL_USER_CREATED ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    value_format: "0"
    description: "NK_DIM_REGSTR_REPRSNTTV"
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: user_type_created {
    type: string
    description: "USER_TYPE_CREATED"
    sql: ${TABLE}.USER_TYPE_CREATED ;;
  }
  measure: count {
    type: count
  }
}