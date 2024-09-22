
view: filtered_rep_cd_by_rvp_branch_team {
  derived_table: {
    sql: select distinct rep_code from `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV`
    where
          {% condition physical_branch_manager_name %} physical_branch_manager_name {% endcondition %} AND
           {% condition regional_vice_president_name %} regional_vice_president_name {% endcondition %} AND
           {% condition team_name %} team_name {% endcondition %}
      --PHYSICAL_BRANCH_MANAGER_NAME='' and REGIONAL_VICE_PRESIDENT_NAME='' and TEAM_NAME=''
    ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: rep_cd {
    type: string
    sql: ${TABLE}.rep_code ;;
  }

  filter: regional_vice_president_name {
    label: "RVP Name"
    type: string
    suggest_dimension: advisor_info_for_ax360_dashboards.regional_vice_president_name

  }

  filter: team_name {
    label: "Team Name"
    type: string
    suggest_dimension: advisor_info_for_ax360_dashboards.advisor_team_name

  }

  filter: physical_branch_manager_name {
    label: "Branch Name"
    type: string
    suggest_dimension: advisor_info_for_ax360_dashboards.physical_branch_manager_name

  }

  set: detail {
    fields: [
        rep_cd
    ]
  }
}