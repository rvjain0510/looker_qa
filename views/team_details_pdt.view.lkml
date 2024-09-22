# The name of this view in Looker is "Team Details"

explore: team_details_pdt {}
view: team_details_pdt {

  derived_table: {
    datagroup_trigger: data_platform_load
    publish_as_db_view: yes
    sql:  select TEAM_ID,
    TEAM_NAME,
    (STRING_AGG(DISTINCT (REGIONAL_VICE_PRESIDENT_NAME),"*")) as REGIONAL_VICE_PRESIDENT_NAME,
    PRESTIGE_SUPPORT_NAME,
    PRESTIGE_CATEGORY,
     (STRING_AGG(DISTINCT (PHYSICAL_BRANCH_MANAGER_NAME),"*")) as PHYSICAL_BRANCH_MANAGER_NAME,
   (STRING_AGG(DISTINCT ( ADVISOR_FULL_NAME),"*")) as TEAM_MEMBER_NAME,
   (STRING_AGG(DISTINCT ( CITY_AND_PROVINCE),"*")) as CITY_AND_PROVINCE,
   (STRING_AGG(DISTINCT ( REP_CODE),"*")) as REP_CODE,
   (STRING_AGG(DISTINCT ( REP_CD_NAME),"*")) as REP_CD_NAME
   from
    (select distinct concat(ADVISOR_USER_ID,":",coalesce(case when ADVISOR_FIRST_NAME is null then ADVISOR_USER_FIRST_NAME else ADVISOR_FIRST_NAME end ,'')," ",coalesce(case when ADVISOR_LAST_NAME is null then ADVISOR_USER_LAST_NAME else ADVISOR_LAST_NAME end ,'')) as ADVISOR_FULL_NAME,TEAM_ID,TEAM_NAME,
    REGIONAL_VICE_PRESIDENT_NAME,PRESTIGE_SUPPORT_NAME, regexp_replace(PHYSICAL_BRANCH_MANAGER_NAME, r'\s+',' ') PHYSICAL_BRANCH_MANAGER_NAME, PRESTIGE_CATEGORY,REP_CODE,REP_CD_NAME,concat(PHYSICAL_BRANCH_CITY,",",PHYSICAL_BRANCH_PROVINCE) as
     CITY_AND_PROVINCE

       from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE != "RR" and MD_ACTIVE
     )
     group by
     TEAM_ID,TEAM_NAME,
    PRESTIGE_SUPPORT_NAME,
    PRESTIGE_CATEGORY;;
    }

  dimension: city_and_province {
    type: string
    sql: ${TABLE}.CITY_AND_PROVINCE ;;
  }

  dimension: physical_branch_manager_name {
    type: string
    sql: ${TABLE}.PHYSICAL_BRANCH_MANAGER_NAME ;;
  }

  dimension: prestige_category {
    type: string
    sql: ${TABLE}.PRESTIGE_CATEGORY ;;
  }

  dimension: prestige_support_name {
    type: string
    sql: ${TABLE}.PRESTIGE_SUPPORT_NAME ;;
  }

  dimension: regional_vice_president_name {
    type: string
    sql: ${TABLE}.REGIONAL_VICE_PRESIDENT_NAME ;;
  }

  dimension: rep_code {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: rep_cd_name {
    type: string
    sql: ${TABLE}.REP_CD_NAME ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.TEAM_ID ;;
  }

  dimension: team_member_name {
    type: string
    sql: ${TABLE}.TEAM_MEMBER_NAME ;;
  }

  dimension: team_name {
    type: string
    sql: ${TABLE}.TEAM_NAME ;;
  }
  measure: count {
    type: count
    drill_fields: [team_name, regional_vice_president_name, prestige_support_name, physical_branch_manager_name, team_member_name]
  }
}
