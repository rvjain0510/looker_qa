view: fact_rel_accnt_party {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY_MV` ;;

  fields_hidden_by_default: yes


  dimension: businessentitycode {
    type: string
    hidden: no
    description: "BUSINESSENTITYCODE"
    sql: ${TABLE}.BUSINESSENTITYCODE ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    description: "ID"
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
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_party {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_PARTY ;;
  }

  dimension: rolenumber {
    type: number
    hidden: no
    description: "ROLENUMBER"
    sql: ${TABLE}.ROLENUMBER ;;
  }

  dimension: roletype {
    type: string
    hidden: no
    description: "ROLETYPE"
    sql: ${TABLE}.ROLETYPE ;;
  }

  dimension: systemcode {
    type: string
    hidden: no
    description: "SYSTEMCODE"
    sql: ${TABLE}.SYSTEMCODE ;;
  }
  measure: count {
    type: count
  }
}
