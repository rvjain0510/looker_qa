view: dim_user_unnested {
  derived_table: {
    datagroup_trigger: data_platform_load
    publish_as_db_view: yes
    sql:
    with internal_user_id as (select distinct u.USERID,count(distinct  rr.RR_ROLE_TYPE) as total_rr from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` rr
      join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` f on
      f.NK_HK_DIM_REGSTR_REPRSNTTV=rr.MD_HASH_NAT_KEYS
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` u
      on f.NK_HK_DIM_USER= u.MD_HASH_NAT_KEYS and u.MD_ACTIVE
      group by 1
      having count(distinct rr.RR_ROLE_TYPE)=1
      )
          select distinct
          dim_user.USERID,dim_user.FIRSTNAME,dim_user.LASTNAME,dim_user.USER_NAME,dim_user.EMAIL,dim_user.PHONE,
          REP_CODE,dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,dim_regstr_reprsnttv.REP_CD_NAME,
          (case when internal_user_id.USERID is NOT NULL then 'Head Office' Else 'Front Office' END) as USER_TYPE
          from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
          join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` fact_rel_user_rr_access_perm
          on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE
          and fact_rel_user_rr_access_perm.MD_ACTIVE and dim_user.MD_ACTIVE
          join  `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
          on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE and
          dim_regstr_reprsnttv.RR_ROLE_TYPE = "RR"
          left join internal_user_id
          on internal_user_id.USERID=dim_user.USERID;;

  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}.USER_NAME ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.EMAIL ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.PHONE ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    # hidden: yes
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.USERID ;;
  }

  dimension: user_type {
    type: string
    sql: case when ${TABLE}.USER_TYPE = "Head Office" then "EMPLOYEE" else "ADVISOR" end ;;
  }

  dimension: rep_cds {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: rep_cd_name {
    type: string
    sql: ${TABLE}.REP_CD_NAME ;;
  }

  dimension: rep_cd_with_rep_cd_name {
    type: string
    sql: concat(${rep_cds},case when ${rep_cd_name} is not null then concat(" - ",${rep_cd_name}) else "" end) ;;
  }

  measure: count {
    type: count
    drill_fields: [lastname, firstname]
  }
}
