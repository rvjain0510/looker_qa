view: total_household_revenue_for_segments_ndt {# this view is created to get overall total of AUA and Client. and use it in the denominator of %AUA and %Client calculation

  derived_table: {
    explore_source: ax360_dashboards_revenue {
      column: total_households { field: houshlds.total_household_count }
      column: total_12_month_revenue {field: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}

      # filters: [dim_accnt.account_status_level_1_without_locale: "Open"]

      bind_filters: {
        # to_field: dim_regstr_reprsnttv.rep_cd
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

  measure: total_12_month_revenue {
    type: sum
    sql: ${TABLE}.total_12_month_revenue ;;
  }
}
