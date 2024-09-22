view: dim_regstr_reprsnttv {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` ;;


  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }



  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: rep_cd {
    type: string
    description: "Rep. Code"
    sql: ${TABLE}.REP_CD ;;

  }
  measure: count {
    type: count
  }

  ##################### ACCENTURE CODE ENDS HERE #############################################

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  filter: rep_cds {
    label: "ia_code" #this is localized
    type: string
    # suggest_dimension: dim_regstr_reprsnttv.rep_cd
  }

}
