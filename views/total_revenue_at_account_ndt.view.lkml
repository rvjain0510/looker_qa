# If necessary, uncomment the line below to include explore_source.

# include: "ax360_portal_qphi.model.lkml"

view: total_revenue_at_account_ndt {
  derived_table: {
    explore_source: ax360_dashboards_revenue {
      column: total_12_month_revenue { field: fact_revn_rr.total_12_month_revenue }

      # filters: [dim_accnt.account_status_level_1_without_locale: "Open" ]
      bind_filters: {
        #to_field: dim_regstr_reprsnttv.rep_cd
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

  dimension: total_12_month_revenue {
    primary_key: yes
    description: ""
    type: number
  }



  measure: total_12_months_revenue {
    type: sum
    sql: ${total_12_month_revenue} ;;
  }
}
