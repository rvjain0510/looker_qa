view: advisor_info_pdt {
  derived_table: {
    datagroup_trigger: data_platform_load
    publish_as_db_view: yes
    sql:
      WITH rep_cd_role as (
    select
   dim_user.USERID,REP_CODE,dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,dim_regstr_reprsnttv.REP_CD_NAME,COMPLIANCE_BRANCH_FIXED_FEE_IND,COMPLIANCE_BRANCH_MANAGED_IND,COMPLIANCE_BRANCH_SEG_FUND_IND,COMPLIANCE_BRANCH_REF_IND,
     STRING_AGG( distinct fact_rel_user_rr_access_perm.FUNCTION) AS FUNCTION,
        STRING_AGG(distinct fact_rel_user_rr_access_perm.ROLE) AS ROLE
    from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
    join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` fact_rel_user_rr_access_perm
    on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE
    and fact_rel_user_rr_access_perm.MD_ACTIVE and dim_user.MD_ACTIVE
    join  `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
    on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE and
    dim_regstr_reprsnttv.RR_ROLE_TYPE = "RR"
      group by 1,2,3,4,5,6,7,8

      ),

      dim_regstr_reprsnttv_advisor_info as (
      select * from (
      Select distinct ADVISOR_USER_ID,
      ADVISOR_REP_NAME,ADVISOR_USER_FIRST_NAME,ADVISOR_USER_LAST_NAME,ADVISOR_USER_FULL_NAME,ADVISOR_USER_EMAIL,
      ADVISOR_USER_PHONE,ADVISOR_USER_DISPLAY_NAME,ADVISOR_USER_ACTIVE,ADVISOR_ACTIVE,ADVISOR_USER_PROVINCE,ADVISOR_USER_TYPE,

      TEAM_ID,TEAM_TYPE,TEAM_NAME,TEAM_CONTACT_EMAIL,TEAM_NUMBER_OF_USER,REGIONAL_VICE_PRESIDENT_ID,
      REGIONAL_VICE_PRESIDENT_NAME, REGIONAL_VICE_PRESIDENT_EMAIL, REGIONAL_VICE_PRESIDENT_WORK_PHONE,PRESTIGE_CATEGORY,PRESTIGE_SUPPORT_NAME,PRESTIGE_SUPPORT_PHONE_NUMBER,PRESTIGE_SUPPORT_EMAIL,

      ADVISOR_FIRST_NAME,ADVISOR_LAST_NAME,ADVISOR_FULL_NAME,ADVISOR_MIDDLE_NAME,ADVISOR_EMAIL,ADVISOR_WORK_PHONE,ADVISOR_CELL_PHONE,ADVISOR_ALIAS,ADVISOR_DATE_OF_BIRTH,
      ADVISOR_IS_EMPLOYEE,ADVISOR_ADDRESS,ADVISOR_PRIMARY_ADDRESS,ADVISOR_CITY,ADVISOR_POSTAL_CODE,ADVISOR_FAX_NUMBER,ADVISOR_LANGUAGE,ADVISOR_TITLE_EN,ADVISOR_TITLE_FR,
      ADVISOR_ROLE_EN,ADVISOR_ROLE_FR,ADVISOR_WEB_SITE,ADVISOR_TRADE_NAME,ADVISOR_PROVINCE,

      PHYSICAL_BRANCH_CODE,PHYSICAL_BRANCH_ADDRESS,PHYSICAL_BRANCH_MANAGER_NAME,PHYSICAL_BRANCH_MANAGER_EMAIL,PHYSICAL_BRANCH_MANAGER_WORK_PHONE,
      PHYSICAL_BRANCH_CITY,PHYSICAL_BRANCH_PROVINCE,
      row_number() over(partition by ADVISOR_USER_ID order by ADVISOR_USER_FIRST_NAME desc)row_no
      from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!="RR" and MD_ACTIVE)
      where row_no =1
      ),

      advisor_rep_cd_teams as (
      select ADVISOR_USER_ID, REP_CODE,RR_ROLE_TYPE,TEAM_ID, (case when RR_ROLE_TYPE='Advisor' then TEAM_NAME else NULL end) advisor_team_name from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` where RR_ROLE_TYPE!='RR'
      )


      select
      dim_regstr_reprsnttv_advisor_info.ADVISOR_USER_ID,advisor_rep_cd_teams.RR_ROLE_TYPE,rep_cd_role.REP_CODE,advisor_team_name
      ,REP_CD_NAME,ADVISOR_REP_NAME,COMPLIANCE_BRANCH_FIXED_FEE_IND,COMPLIANCE_BRANCH_MANAGED_IND,
      COMPLIANCE_BRANCH_SEG_FUND_IND,COMPLIANCE_BRANCH_REF_IND,ADVISOR_USER_FIRST_NAME,ADVISOR_USER_LAST_NAME,ADVISOR_USER_FULL_NAME,ADVISOR_USER_EMAIL,
      ADVISOR_USER_PHONE,ADVISOR_USER_DISPLAY_NAME,ADVISOR_USER_ACTIVE,ADVISOR_ACTIVE,ADVISOR_USER_PROVINCE,ADVISOR_USER_TYPE,
      dim_regstr_reprsnttv_advisor_info.TEAM_ID,TEAM_TYPE,TEAM_NAME,TEAM_CONTACT_EMAIL,TEAM_NUMBER_OF_USER,REGIONAL_VICE_PRESIDENT_ID,
      REGIONAL_VICE_PRESIDENT_NAME,REGIONAL_VICE_PRESIDENT_EMAIL, REGIONAL_VICE_PRESIDENT_WORK_PHONE,PRESTIGE_CATEGORY,PRESTIGE_SUPPORT_NAME,PRESTIGE_SUPPORT_PHONE_NUMBER,PRESTIGE_SUPPORT_EMAIL,
      ADVISOR_FIRST_NAME,ADVISOR_LAST_NAME,ADVISOR_FULL_NAME,ADVISOR_MIDDLE_NAME,ADVISOR_EMAIL,ADVISOR_WORK_PHONE,ADVISOR_CELL_PHONE,ADVISOR_ALIAS,ADVISOR_DATE_OF_BIRTH,
      ADVISOR_IS_EMPLOYEE,ADVISOR_ADDRESS,ADVISOR_PRIMARY_ADDRESS,ADVISOR_CITY,ADVISOR_POSTAL_CODE,ADVISOR_FAX_NUMBER,ADVISOR_LANGUAGE,ADVISOR_TITLE_EN,ADVISOR_TITLE_FR,
      ADVISOR_ROLE_EN,ADVISOR_ROLE_FR,ADVISOR_WEB_SITE,ADVISOR_TRADE_NAME,ADVISOR_PROVINCE,
      PHYSICAL_BRANCH_CODE,PHYSICAL_BRANCH_ADDRESS,PHYSICAL_BRANCH_MANAGER_NAME,PHYSICAL_BRANCH_MANAGER_EMAIL,PHYSICAL_BRANCH_MANAGER_WORK_PHONE,
      PHYSICAL_BRANCH_CITY,PHYSICAL_BRANCH_PROVINCE,FUNCTION,ROLE
      from  dim_regstr_reprsnttv_advisor_info
      LEFT JOIN rep_cd_role ON
      rep_cd_role.userid=dim_regstr_reprsnttv_advisor_info.ADVISOR_USER_ID
      inner JOIN advisor_rep_cd_teams ON
      advisor_rep_cd_teams.ADVISOR_USER_ID=dim_regstr_reprsnttv_advisor_info.ADVISOR_USER_ID
      AND rep_cd_role.rep_code = advisor_rep_cd_teams.REP_CODE
      and  advisor_rep_cd_teams.team_id=dim_regstr_reprsnttv_advisor_info.team_id;;

  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: advisor_user_id {
    type: string
    sql: ${TABLE}.ADVISOR_USER_ID ;;
  }

  dimension: rep_cd {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: rr_role_type {
    type: string
    sql: ${TABLE}.RR_ROLE_TYPE ;;
  }

  dimension: advisor_team_name {
    type: string
    sql: ${TABLE}.advisor_team_name ;;
  }


  dimension: rep_cd_name {
    type: string
    sql: ${TABLE}.REP_CD_NAME ;;
  }

  dimension: compliance_branch_fixed_fee_ind {
    type: yesno
    sql: ${TABLE}.COMPLIANCE_BRANCH_FIXED_FEE_IND ;;
  }

  dimension: compliance_branch_managed_ind {
    type: yesno
    sql: ${TABLE}.COMPLIANCE_BRANCH_MANAGED_IND ;;
  }

  dimension: compliance_branch_ref_ind {
    type: yesno
    sql: ${TABLE}.COMPLIANCE_BRANCH_REF_IND ;;
  }

  dimension: compliance_branch_seg_fund_ind {
    type: yesno
    sql: ${TABLE}.COMPLIANCE_BRANCH_SEG_FUND_IND ;;
  }

  dimension: advisor_rep_name {
    type: string
    sql: ${TABLE}.ADVISOR_REP_NAME ;;
  }

  dimension: advisor_user_first_name {
    type: string
    sql: ${TABLE}.ADVISOR_USER_FIRST_NAME ;;
  }

  dimension: advisor_user_last_name {
    type: string
    sql: ${TABLE}.ADVISOR_USER_LAST_NAME ;;
  }

  dimension: advisor_user_full_name {
    type: string
    sql: ${TABLE}.ADVISOR_USER_FULL_NAME ;;
  }

  dimension: advisor_user_email {
    type: string
    sql: ${TABLE}.ADVISOR_USER_EMAIL ;;
  }

  dimension: advisor_user_phone {
    type: string
    sql: ${TABLE}.ADVISOR_USER_PHONE ;;
  }

  dimension: advisor_user_display_name {
    type: string
    sql: ${TABLE}.ADVISOR_USER_DISPLAY_NAME ;;
  }

  dimension: advisor_user_active {
    type: yesno
    sql: ${TABLE}.ADVISOR_USER_ACTIVE ;;
  }

  dimension: advisor_active {
    type: yesno
    sql: ${TABLE}.ADVISOR_ACTIVE ;;
  }

  dimension: advisor_user_province {
    type: string
    sql: ${TABLE}.ADVISOR_USER_PROVINCE ;;
  }

  dimension: advisor_user_type {
    type: string
    sql: ${TABLE}.ADVISOR_USER_TYPE ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.TEAM_ID ;;
  }

  dimension: team_type {
    type: string
    sql: ${TABLE}.TEAM_TYPE ;;
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.TEAM_NAME ;;
  }

  dimension: team_contact_email {
    type: string
    sql: ${TABLE}.TEAM_CONTACT_EMAIL ;;
  }

  dimension: team_number_of_user {
    type: number
    sql: ${TABLE}.TEAM_NUMBER_OF_USER ;;
  }

  dimension: regional_vice_president_id {
    type: number
    sql: ${TABLE}.REGIONAL_VICE_PRESIDENT_ID ;;
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

  dimension: prestige_category {
    type: string
    sql: ${TABLE}.PRESTIGE_CATEGORY ;;
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

  dimension: advisor_first_name {
    type: string
    sql: case when ${TABLE}.ADVISOR_FIRST_NAME is null then ${advisor_user_first_name} else ${TABLE}.ADVISOR_FIRST_NAME  end ;;
  }

  dimension: advisor_last_name {
    type: string
    sql:  case when ${TABLE}.ADVISOR_LAST_NAME is null then ${advisor_user_last_name} else ${TABLE}.ADVISOR_LAST_NAME  end ;;
  }

  dimension: advisor_full_name {
    type: string
    sql: case when ${TABLE}.ADVISOR_FULL_NAME is null then ${advisor_user_full_name} else ${TABLE}.ADVISOR_FULL_NAME  end ;;
  }

  dimension: advisor_middle_name {
    type: string
    sql: ${TABLE}.ADVISOR_MIDDLE_NAME ;;
  }

  dimension: advisor_email {
    type: string
    sql: ${TABLE}.ADVISOR_EMAIL ;;
  }

  dimension: advisor_work_phone {
    type: string
    sql: ${TABLE}.ADVISOR_WORK_PHONE ;;
  }

  dimension: advisor_cell_phone {
    type: string
    sql: ${TABLE}.ADVISOR_CELL_PHONE ;;
  }

  dimension: advisor_alias {
    type: string
    sql: ${TABLE}.ADVISOR_ALIAS ;;
  }

  dimension: advisor_date_of_birth {
    type: date
    datatype: date
    sql: ${TABLE}.ADVISOR_DATE_OF_BIRTH ;;
  }

  dimension: advisor_is_employee {
    type: yesno
    sql: ${TABLE}.ADVISOR_IS_EMPLOYEE ;;
  }

  dimension: advisor_address {
    type: string
    sql: ${TABLE}.ADVISOR_ADDRESS ;;
  }

  dimension: advisor_primary_address {
    type: string
    sql: ${TABLE}.ADVISOR_PRIMARY_ADDRESS ;;
  }

  dimension: advisor_city {
    type: string
    sql: ${TABLE}.ADVISOR_CITY ;;
  }

  dimension: advisor_postal_code {
    type: string
    sql: ${TABLE}.ADVISOR_POSTAL_CODE ;;
  }

  dimension: advisor_fax_number {
    type: string
    sql: ${TABLE}.ADVISOR_FAX_NUMBER ;;
  }

  dimension: advisor_language {
    type: string
    sql: ${TABLE}.ADVISOR_LANGUAGE ;;
  }

  dimension: advisor_title_en {
    type: string
    sql: ${TABLE}.ADVISOR_TITLE_EN ;;
  }

  dimension: advisor_title_fr {
    type: string
    sql: ${TABLE}.ADVISOR_TITLE_FR ;;
  }

  dimension: advisor_title {
    type: string
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${advisor_title_fr}
          {% else %}
          ${advisor_title_en}
          {% endif %};;
  }

  dimension: advisor_role_en {
    type: string
    sql: ${TABLE}.ADVISOR_ROLE_EN ;;
  }

  dimension: advisor_role_fr {
    type: string
    sql: ${TABLE}.ADVISOR_ROLE_FR ;;
  }

  dimension: advisor_role {
    type: string
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${advisor_role_fr}
          {% else %}
          ${advisor_role_en}
          {% endif %};;
  }

  dimension: advisor_web_site {
    type: string
    sql: ${TABLE}.ADVISOR_WEB_SITE ;;
  }

  dimension: advisor_trade_name {
    type: string
    sql: ${TABLE}.ADVISOR_TRADE_NAME ;;
  }

  dimension: advisor_province {
    type: string
    sql: ${TABLE}.ADVISOR_PROVINCE ;;
  }

  dimension: physical_branch_code {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_CODE ;;
  }

  dimension: physical_branch_address {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_ADDRESS ;;
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

  dimension: physical_branch_city {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_CITY ;;
  }

  dimension: physical_branch_province {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_PROVINCE ;;
  }

  # dimension: team_members_details {
  #   # type: string
  #   sql: ${TABLE}.TEAM_MEMBERS_DETAILS ;;
  # }

  dimension: function {
    # type: string
    sql: ${TABLE}.FUNCTION ;;
  }

  dimension: role {
    # type: string
    sql: ${TABLE}.ROLE ;;
  }

  set: detail {
    fields: [
      advisor_user_id,
      rep_cd,
      rep_cd_name,
      advisor_rep_name,
      advisor_user_first_name,
      advisor_user_last_name,
      advisor_user_full_name,
      advisor_user_email,
      advisor_user_phone,
      advisor_user_display_name,
      advisor_user_active,
      advisor_active,
      advisor_user_province,
      advisor_user_type,
      team_id,
      team_type,
      team_name,
      team_contact_email,
      team_number_of_user,
      regional_vice_president_id,
      regional_vice_president_name,
      regional_vice_president_email,
      regional_vice_president_work_phone,
      prestige_category,
      prestige_support_name,
      prestige_support_phone_number,
      prestige_support_email,
      advisor_first_name,
      advisor_last_name,
      advisor_full_name,
      advisor_middle_name,
      advisor_email,
      advisor_work_phone,
      advisor_cell_phone,
      advisor_alias,
      advisor_date_of_birth,
      advisor_is_employee,
      advisor_address,
      advisor_primary_address,
      advisor_city,
      advisor_postal_code,
      advisor_fax_number,
      advisor_language,
      advisor_title_en,
      advisor_title_fr,
      advisor_role_en,
      advisor_role_fr,
      advisor_web_site,
      advisor_trade_name,
      advisor_province,
      physical_branch_code,
      physical_branch_address,
      physical_branch_manager_name,
      physical_branch_manager_email,
      physical_branch_manager_work_phone
    ]
  }
}



# view: advisor_function {
#   dimension: function {
#     type: string
#     sql: ${TABLE}.FUNCTION ;;
#   }
#   }

#   view: advisor_role {
#     dimension: role {
#       type: string
#       sql: ${TABLE}.ROLE ;;
#     }
#     }