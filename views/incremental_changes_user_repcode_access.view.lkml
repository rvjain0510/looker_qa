
# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
# The name of this view in Looker is "Dim User Repcds"
view: incremental_changes_user_repcode_access {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  # sql_table_name: `iapw-dm-d-dev1-datahub-1000.temp.DIM_USER_REPCDS` ;;
  derived_table: {
    sql:
    WITH rep_cd_role as (select distinct
    dim_user.USERID,dim_user.FIRSTNAME,dim_user.LASTNAME,dim_user.USER_NAME,dim_user.EMAIL,dim_user.PHONE,
    REP_CODE,dim_regstr_reprsnttv.MD_HASH_NAT_KEYS as NK_HK_DIM_REGSTR_REPRSNTTV,dim_regstr_reprsnttv.REP_CD_NAME,
    case when dim_user.MD_START_DT = CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) then "Added"
    when dim_user.MD_END_DT = CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) then "Removed" else "Unknown" end delta_flag
    from `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` as dim_user
    join (select distinct NK_HK_DIM_USER,NK_HK_DIM_REGSTR_REPRSNTTV from `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN`where MD_ACTIVE) fact_rel_user_rr_access_perm
    on fact_rel_user_rr_access_perm.NK_HK_DIM_USER = dim_user.MD_HASH_NAT_KEYS and dim_user.MD_ACTIVE
    and dim_user.MD_ACTIVE
    join  `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` dim_regstr_reprsnttv
    on fact_rel_user_rr_access_perm.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS and dim_regstr_reprsnttv.MD_ACTIVE and
    dim_regstr_reprsnttv.RR_ROLE_TYPE = "RR"),

      internal_user_id as (select distinct u.USERID,count(distinct  rr.RR_ROLE_TYPE) as total_rr from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` rr
      join `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_USER_RR_ACCSS_PERMSSN` f on
      f.NK_HK_DIM_REGSTR_REPRSNTTV=rr.MD_HASH_NAT_KEYS
      join `@{bq_project_id}.@{bq_dataset_name}.DIM_USER_MV` u
      on f.NK_HK_DIM_USER= u.MD_HASH_NAT_KEYS and u.MD_ACTIVE
      group by 1
      having count(distinct rr.RR_ROLE_TYPE)=1),

      team_rep_cd as  (select distinct TEAM_ID, REP_CODE from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
      where RR_ROLE_TYPE!='RR'),

      internal_user_with_team_info as ( Select internal_user_id.USERID
      from internal_user_id
      join rep_cd_role
      on internal_user_id.USERID=rep_cd_role.USERID
      join team_rep_cd
      on rep_cd_role.REP_CODE=team_rep_cd.REP_CODE
      group by 1 )

      select user_rr.USERID, (case when internal_user_with_team_info.USERID IS NOT NULL then 'Head Office' Else 'Front Office' END) as USER_TYPE,user_rr.FIRSTNAME,user_rr.LASTNAME,user_rr.USER_NAME, user_rr.EMAIL, user_rr.PHONE,
      REP_CODE,delta_flag,
      ROW_NUMBER() OVER() AS Row_num
      from rep_cd_role user_rr
      LEFT JOIN internal_user_with_team_info
      on user_rr.USERID = internal_user_with_team_info.USERID;;
    datagroup_trigger: data_platform_load
  }

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Firstname" in Explore.

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: nk_hk_user_id {
    type: number
    sql: ${TABLE}.NK_HK_USER_ID ;;
  }
  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: nk_hk_dim_regstr_reprsnttv {
    # hidden: yes
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: user_id {
    type: string
    sql: ${TABLE}.USERID ;;
  }

  dimension: user_role {
    type: string
    sql: ${TABLE}.USER_ROLE ;;
  }

  #user type set here as employee and advisor because that was the values that used by ax360 team

  dimension: user_type {
    type: string
    sql: case when ${TABLE}.USER_TYPE = "Head Office" then "EMPLOYEE" else "ADVISOR" end ;;
  }

  dimension: rep_cds {
    type: string
    sql: ${TABLE}.REP_CODE ;;
  }

  dimension: incremental_data_flag {
    type: string
    sql: ${TABLE}.delta_flag ;;
  }

  dimension: row_num {
    type: number
    sql: ${TABLE}.row_num ;;
  }

  measure: count {
    type: count
    drill_fields: [lastname, firstname]
  }
}
