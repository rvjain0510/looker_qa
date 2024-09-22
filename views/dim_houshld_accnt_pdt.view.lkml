view: dim_houshld_accnt_pdt {
  derived_table:
  {
    sql: Select
    accnt.MD_HASH_NAT_KEYS as nk_hk_dim_accnt,
    rep.NK_HK_DIM_REGSTR_REPRSNTTV,
    STRING_AGG(DISTINCT(CASE
    WHEN party.party_type = '1' THEN ARRAY_TO_STRING([PARTY_FIRST_PREFERRED_NAME ,PARTY_MIDDLE_PREFERRED_NAME,
      PARTY_LAST_PREFERRED_NAME],' ')
    WHEN party.party_type  = '2' THEN PARTY_ORGANIZATION_NAME
    ELSE
    'Unknown'
    END), ", ") AS party_name,
    STRING_AGG(DISTINCT(CASE
    WHEN party.party_type = '1' THEN ARRAY_TO_STRING([PARTY_LAST_PREFERRED_NAME ,PARTY_MIDDLE_PREFERRED_NAME,
      PARTY_FIRST_PREFERRED_NAME],' ')
    WHEN party.party_type  = '2' THEN PARTY_ORGANIZATION_NAME
    ELSE
    'Unknown'
    END), ", ") AS party_name_first_name_last,
    STRING_AGG(DISTINCT(CASE
    WHEN party.party_type = '1' THEN CONCAT("1 - ", ARRAY_TO_STRING([PARTY_FIRST_PREFERRED_NAME ,PARTY_MIDDLE_PREFERRED_NAME,
      PARTY_LAST_PREFERRED_NAME],' '))
    WHEN party.party_type  = '2' THEN CONCAT("2 - ", PARTY_ORGANIZATION_NAME)
    ELSE
    'Unknown'
    END), ", ") AS party_type_party_name,
    STRING_AGG(DISTINCT(CASE
    WHEN party.party_type = '1' THEN CONCAT("1 - ", ARRAY_TO_STRING([PARTY_LAST_PREFERRED_NAME ,PARTY_MIDDLE_PREFERRED_NAME,
      PARTY_FIRST_PREFERRED_NAME],' '))
    WHEN party.party_type  = '2' THEN CONCAT("2 - ", PARTY_ORGANIZATION_NAME)
    ELSE
    'Unknown'
    END), ", ") AS party_type_party_name_first_name_last,
    accnt.accnt_holdr_name
    from
    `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV` accnt
    JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_REGSTR_REPRSNTTV_ACCNT_MV` rep on accnt.MD_HASH_NAT_KEYS = rep.NK_HK_DIM_ACCNT AND rep.MD_ACTIVE and accnt.MD_ACTIVE
    JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY_MV` ap on ap.NK_HK_DIM_ACCNT = accnt.MD_HASH_NAT_KEYS and ap.MD_ACTIVE
    JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY_MV` party on party.MD_HASH_NAT_KEYS = ap.NK_HK_DIM_PARTY and party.MD_ACTIVE
    GROUP BY 1,2,7;;

    datagroup_trigger: data_platform_load
  }


  dimension: nk_hk_dim_accnt {
    type: number
    description: "NK HK DIM ACCNT"
    sql:  ${TABLE}.nk_hk_dim_accnt  ;;
  }

  dimension: nk_hk_dim_accnt_str {
    type: string
    description: "NK HK DIM ACCNT STRING"
    sql:  CAST(${TABLE}.nk_hk_dim_accnt AS STRING)  ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    description: "NK HK DIM REGSTR REPRSNTTV"
    sql:  ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV  ;;
  }

  dimension: client_list_name {
    type: string
    description: "Client List Name"
    sql:  case when ${first_name_first.is_first_name_first}='Yes' then ${TABLE}.party_name
    else ${TABLE}.party_name_first_name_last end;;
  }

  dimension: client_list_type_name {
    type: string
    description: "Client List Type Name"
    sql: case when ${first_name_first.is_first_name_first}='Yes' then ${TABLE}.party_type_party_name
    else ${TABLE}.party_type_party_name_first_name_last end;;
  }

  dimension: accnt_holdr_name {
    type: string
    description: "Account Holder Name"
    sql:  ${TABLE}.accnt_holdr_name  ;;
  }
}
