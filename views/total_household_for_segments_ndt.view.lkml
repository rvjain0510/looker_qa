# this view is created to get overall total of AUA and Client. and use it in the denominator of %AUA and %Client calculation

view: total_household_for_segments_ndt {

  derived_table: {
    explore_source: ax360_dashboards_hh {
      # 1168403-changes-for-j-and-closed-accounts: changed the count column to refer from household.total_household_count instead of household.count
      column: total_households { field: houshlds.total_household_count }
      column: total_aua_current_month {field: fact_holdng_rr.aua_converted_to_cad_current_month}

      # 1168403-changes-for-j-and-closed-accounts: Commented the filter as the filter is not to be applied on AUA
      # filters: [dim_accnt.account_status_level_1_without_locale: "Open"]

      bind_filters: {
        to_field: dim_user_rep_cds.rep_cd_with_rep_cd_name
        from_field: dashboard.rep_cd_with_rep_cd_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
        from_field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.team_name
        from_field: filtered_rep_cd_by_rvp_branch_team.team_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
        from_field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      }
    }
  }
  dimension: total_households {
    type: number
    primary_key: yes
    sql: ${TABLE}.total_households ;;
  }
  measure: total_no_households {
    type: sum
    sql: ${TABLE}.total_households ;;
  }

  measure: total_aua {
    type: sum
    sql: ${TABLE}.total_aua_current_month ;;
  }
}
