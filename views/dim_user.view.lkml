view: dim_user {
  derived_table: {
    datagroup_trigger: data_platform_load
    publish_as_db_view: yes

    sql: WITH rep_cd_role as (
          select distinct
          dim_user.USERID,REP_CODE,dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,dim_regstr_reprsnttv.REP_CD_NAME
          from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
          join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` fact_rel_user_rr_access_perm
          on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE
          and fact_rel_user_rr_access_perm.MD_ACTIVE and dim_user.MD_ACTIVE
          join  `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
          on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE
          and dim_regstr_reprsnttv.RR_ROLE_TYPE='RR'
          ),

      user_rr as(select
      dim_user.USERID,
      dim_user.FIRSTNAME,
      dim_user.LASTNAME,
      dim_user.USER_NAME,
      dim_user.EMAIL,
      dim_user.PHONE,
      ARRAY_AGG(STRUCT(rep_cd_role.NK_HK_DIM_REGSTR_REPRSNTTV,rep_cd_role.REP_CODE,rep_cd_role.REP_CD_NAME)) AS REP_CDS,

      from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
      join
      (select distinct NK_HK_DIM_USER,NK_HK_DIM_REGSTR_REPRSNTTV from `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN`where MD_ACTIVE) as fact_rel_user_rr_access_perm
      on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
      on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE
      join rep_cd_role ON
      rep_cd_role.USERID=dim_user.USERID AND rep_cd_role.NK_HK_DIM_REGSTR_REPRSNTTV=dim_regstr_reprsnttv.MD_HASH_NAT_KEYS
      group by 1,2,3,4,5,5,6),

      revenue_userid_with_repcodes as(
      select Distinct dim_user.USERID,REP_CODE,REP_CD_NAME
      from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
      join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` fact_rel_user_rr_access_perm
      on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE and fact_rel_user_rr_access_perm.FUNCTION = "isAdvisor"
      and fact_rel_user_rr_access_perm.MD_ACTIVE and dim_user.MD_ACTIVE
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
      on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE
      ),

      revenue_repcodes_hash_nat_keys as (
      Select revenue_userid_with_repcodes.USERID,
      ARRAY_AGG(STRUCT(dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,revenue_userid_with_repcodes.REP_CODE,revenue_userid_with_repcodes.REP_CD_NAME)) AS REVENUE_REP_CDS
      from revenue_userid_with_repcodes
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
      on  dim_regstr_reprsnttv.REP_CODE= revenue_userid_with_repcodes.REP_CODE and dim_regstr_reprsnttv.RR_ROLE_TYPE='RR'
      group by 1),

      dim_regstr_reprsnttv_advisor_info as (
      Select ADVISOR_USER_ID,ARRAY_AGG(STRUCT(TEAM_ID)) as TEAM_ID_ARRAY
      from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!= "RR" and MD_ACTIVE
      group by ADVISOR_USER_ID
      ),

      advisor_team_ids as (
      Select ADVISOR_USER_ID,TEAM_ID
      from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!= "RR" and MD_ACTIVE
      group by ADVISOR_USER_ID,TEAM_ID
      ),

      internal_user_id as (select distinct u.USERID,count(distinct  rr.RR_ROLE_TYPE) as total_rr from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` rr
      join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` f on
      f.NK_HK_DIM_REGSTR_REPRSNTTV=rr.MD_HASH_NAT_KEYS
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` u
      on f.NK_HK_DIM_USER= u.MD_HASH_NAT_KEYS and u.MD_ACTIVE
      group by 1
      having count(distinct rr.RR_ROLE_TYPE)=1
      ),

      team_rep_cd as  (select distinct TEAM_ID, REP_CODE from  `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!='RR'),


      internal_user_with_team_info as ( Select internal_user_id.USERID,ARRAY_AGG(STRUCT(team_rep_cd.TEAM_ID)) as TEAM_ID_ARRAY
      from internal_user_id
      join rep_cd_role
      on internal_user_id.USERID=rep_cd_role.USERID
      join team_rep_cd
      on rep_cd_role.REP_CODE=team_rep_cd.REP_CODE
      group by 1 ),

      revenue_internal_userid_with_repcodes as(
      select Distinct dim_user.USERID,REP_CODE,REP_CD_NAME
      from internal_user_id
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user on internal_user_id.USERID=dim_user.USERID
      join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` fact_rel_user_rr_access_perm
      on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE and fact_rel_user_rr_access_perm.FUNCTION = "revenue"
      and fact_rel_user_rr_access_perm.MD_ACTIVE and dim_user.MD_ACTIVE
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
      on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE
      ),

      revenue_internal_userid_repcodes_hash_nat_keys as (
      Select revenue_internal_userid_with_repcodes.USERID,
      ARRAY_AGG(STRUCT(dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,revenue_internal_userid_with_repcodes.REP_CODE,revenue_internal_userid_with_repcodes.REP_CD_NAME)) AS INTERNAL_USER_REVENUE_REP_CDS
      from revenue_internal_userid_with_repcodes
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
      on  dim_regstr_reprsnttv.REP_CODE= revenue_internal_userid_with_repcodes.REP_CODE and dim_regstr_reprsnttv.RR_ROLE_TYPE='RR'
      group by 1
      ),


      team_members_info as (
      select TEAM_ID,ARRAY_AGG(STRUCT(ADVISOR_USER_ID,ADVISOR_FIRST_NAME,ADVISOR_LAST_NAME,PHYSICAL_BRANCH_ADDRESS,PHYSICAL_BRANCH_MANAGER_NAME,PHYSICAL_BRANCH_MANAGER_EMAIL,PHYSICAL_BRANCH_MANAGER_WORK_PHONE,ADVISOR_EMAIL,ADVISOR_WORK_PHONE,ADVISOR_FAX_NUMBER,ADVISOR_LANGUAGE,ADVISOR_TITLE_EN,ADVISOR_TITLE_FR,
      ADVISOR_ROLE_EN,ADVISOR_ROLE_FR,RR_ROLE_TYPE,PHYSICAL_BRANCH_CITY,PHYSICAL_BRANCH_PROVINCE,REGIONAL_VICE_PRESIDENT_NAME,REGIONAL_VICE_PRESIDENT_EMAIL, REGIONAL_VICE_PRESIDENT_WORK_PHONE,PRESTIGE_SUPPORT_NAME,PRESTIGE_SUPPORT_PHONE_NUMBER,PRESTIGE_SUPPORT_EMAIL )) as TEAM_MEMBERS_DETAILS from
      (select distinct TEAM_ID,ADVISOR_USER_ID, case when ADVISOR_FIRST_NAME is null then ADVISOR_USER_FIRST_NAME else ADVISOR_FIRST_NAME end as ADVISOR_FIRST_NAME,case when ADVISOR_LAST_NAME is null then ADVISOR_USER_LAST_NAME else ADVISOR_LAST_NAME end as ADVISOR_LAST_NAME,PHYSICAL_BRANCH_ADDRESS,ADVISOR_EMAIL,ADVISOR_WORK_PHONE,ADVISOR_FAX_NUMBER,ADVISOR_LANGUAGE,
      ADVISOR_TITLE_EN,ADVISOR_TITLE_FR,ADVISOR_ROLE_EN,ADVISOR_ROLE_FR,RR_ROLE_TYPE, PHYSICAL_BRANCH_CITY,PHYSICAL_BRANCH_PROVINCE,PHYSICAL_BRANCH_MANAGER_NAME,
      PHYSICAL_BRANCH_MANAGER_EMAIL,PHYSICAL_BRANCH_MANAGER_WORK_PHONE,REGIONAL_VICE_PRESIDENT_NAME,REGIONAL_VICE_PRESIDENT_EMAIL, REGIONAL_VICE_PRESIDENT_WORK_PHONE,
      PRESTIGE_SUPPORT_NAME,PRESTIGE_SUPPORT_PHONE_NUMBER,PRESTIGE_SUPPORT_EMAIL
      from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!= "RR" and MD_ACTIVE
      ) group by 1
      )

      select user_rr.USERID, (case when internal_user_with_team_info.USERID IS NOT NULL then 'Head Office' Else 'Front Office' END) as USER_TYPE,user_rr.FIRSTNAME,user_rr.LASTNAME,user_rr.USER_NAME, user_rr.EMAIL, user_rr.PHONE,
      REP_CDS,  (case when internal_user_with_team_info.USERID IS NOT NULL then revenue_internal_userid_repcodes_hash_nat_keys.INTERNAL_USER_REVENUE_REP_CDS Else revenue_repcodes_hash_nat_keys.REVENUE_REP_CDS END) as REVENUE_REP_CDS,
      (CASE WHEN dim_regstr_reprsnttv_advisor_info.ADVISOR_USER_ID is not null then dim_regstr_reprsnttv_advisor_info.TEAM_ID_ARRAY else internal_user_with_team_info.TEAM_ID_ARRAY end) as TEAM_ID_ARRAY,
      TEAM_MEMBERS_DETAILS
      from user_rr
      LEFT JOIN dim_regstr_reprsnttv_advisor_info
      on user_rr.USERID = dim_regstr_reprsnttv_advisor_info.ADVISOR_USER_ID
      LEFT JOIN internal_user_with_team_info
      on user_rr.USERID = internal_user_with_team_info.USERID
      LEFT JOIN revenue_repcodes_hash_nat_keys
      on user_rr.USERID = revenue_repcodes_hash_nat_keys.USERID
      LEFT JOIN revenue_internal_userid_repcodes_hash_nat_keys
      on user_rr.USERID = revenue_internal_userid_repcodes_hash_nat_keys.USERID
      left join advisor_team_ids
      on user_rr.USERID = advisor_team_ids.ADVISOR_USER_ID
      left join team_members_info
      on team_members_info.team_id =advisor_team_ids.team_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.USERID ;;
  }

  dimension: user_type {
    type: string
    sql: ${TABLE}.USER_TYPE ;;
  }

  dimension: user_role {
    type: string
    sql: case when ${user_type} = "Head Office" then "BRANCHMANAGER" else "ADVISOR" end ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: username {
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

  dimension: rep_cds {
    # type: string
    sql: ${TABLE}.REP_CDS ;;
  }

  dimension: team_id_array {
    # type: string
    sql: ${TABLE}.TEAM_ID_ARRAY ;;
  }

  dimension: revenue_rep_cds {
    hidden: yes
    sql: ${TABLE}.REVENUE_REP_CDS ;;
  }

  measure: dim_user_rep_cds {
    type: string
    label: "rep_cd"
    sql: (STRING_AGG(DISTINCT ${dim_user_rep_cds.rep_cd}, ", " order by ${dim_user_rep_cds.rep_cd}))  ;;
  }

  dimension: team_members_details {
    # type: string
    sql: ${TABLE}.TEAM_MEMBERS_DETAILS ;;
  }

  set: detail {
    fields: [
      user_id,
      firstname,
      lastname,
      username,
      email,
      phone,
      rep_cds,
      team_id_array
    ]
  }
}

view: dim_user_rep_cds {

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: rep_cd {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: rep_cd_name {
    type: string
    sql: ${TABLE}.REP_CD_NAME ;;
  }

  dimension: rep_cd_with_rep_cd_name {
    type: string
    sql: concat(${rep_cd},case when ${rep_cd_name} is not null then concat(" - ",${rep_cd_name}) else "" end) ;;
  }
}

view: dim_user_rep_cds_revenue {
  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: rep_cd {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: rep_cd_name {
    type: string
    sql: ${TABLE}.REP_CD_NAME ;;
  }

  dimension: rep_cd_with_rep_cd_name {
    type: string
    sql: concat(${rep_cd}," - ",${rep_cd_name}) ;;
  }
}

view: advisor_team_members_details {

  dimension: team_member_user_id {
    type: string
    sql: ${TABLE}.ADVISOR_USER_ID ;;
  }

  dimension: team_member_last_name {
    type: string
    sql: ${TABLE}.ADVISOR_LAST_NAME ;;
  }

  dimension: team_member_first_name {
    type: string
    sql: ${TABLE}.ADVISOR_FIRST_NAME ;;
  }

  dimension: team_member_email {
    type: string
    sql: ${TABLE}.ADVISOR_EMAIL ;;
  }

  dimension: team_member_fax_number {
    type: string
    sql: ${TABLE}.ADVISOR_FAX_NUMBER ;;
  }

  dimension: team_member_role_en {
    type: string
    sql: ${TABLE}.ADVISOR_ROLE_EN ;;
  }

  dimension: team_member_role_fr {
    type: string
    sql: ${TABLE}.ADVISOR_ROLE_FR ;;
  }

  dimension: team_member_role {
    type: string
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${team_member_role_fr}
          {% else %}
          ${team_member_role_en}
          {% endif %};;
  }

  dimension: team_member_title_en {
    type: string
    sql: ${TABLE}.ADVISOR_TITLE_EN ;;
  }

  dimension: team_member_title_fr {
    type: string
    sql: ${TABLE}.ADVISOR_TITLE_FR ;;
  }

  dimension: team_member_rr_role_type {
    type: string
    sql: ${TABLE}.RR_ROLE_TYPE ;;
  }

  dimension: team_member_title {
    type: string
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${team_member_title_fr}
          {% else %}
          ${team_member_title_en}
          {% endif %};;
  }


  dimension: team_physical_branch_address {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_ADDRESS ;;
  }


  dimension: team_physical_branch_manager_name {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_MANAGER_NAME ;;
  }

  dimension: physical_branch_manager_name {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_MANAGER_NAME ;;
  }

  dimension: physical_branch_manager_email {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_MANAGER_EMAIL ;;
  }

  dimension: physical_branch_manager_work_phone {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_MANAGER_WORK_PHONE ;;
  }

  dimension: regional_vice_president_name {
    type: string
    sql: ${TABLE}.REGIONAL_VICE_PRESIDENT_NAME ;;
  }

  dimension: regional_vice_president_email {
    type: string
    sql: ${TABLE}.REGIONAL_VICE_PRESIDENT_EMAIL ;;
  }

  dimension: regional_vice_president_work_phone {
    type: string
    sql: ${TABLE}.REGIONAL_VICE_PRESIDENT_WORK_PHONE ;;
  }

  dimension: prestige_support_name {
    type: string
    sql: ${TABLE}.PRESTIGE_SUPPORT_NAME ;;
  }

  dimension: prestige_support_phone_number {
    type: string
    sql: ${TABLE}.PRESTIGE_SUPPORT_PHONE_NUMBER ;;
  }

  dimension: prestige_support_email {
    type: string
    sql: ${TABLE}.PRESTIGE_SUPPORT_EMAIL ;;
  }

  dimension: team_member_work_phone {
    type: string
    sql: ${TABLE}.ADVISOR_WORK_PHONE ;;
  }

  dimension: team_member_langauge {
    type: string
    sql: ${TABLE}.ADVISOR_LANGUAGE ;;
  }

  dimension: team_physical_branch_city {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_CITY ;;
  }

  dimension: team_physical_branch_province {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_PROVINCE ;;
  }

}

view: user_team_id {

  dimension: team_id {
    type: number
    sql: ${TABLE}.TEAM_ID ;;
  }
}
