# If necessary, uncomment the line below to include explore_source.

# include: "ax360_portal_qphi.model.lkml"

view: total_aua_at_account_ndt {
  derived_table: {
    explore_source: ax360_dashboards {
      column: aua_converted_to_cad_current_month { field: fact_holdng_rr.aua_converted_to_cad_current_month }

      #1168403-changes-for-j-and-closed-accounts: Commented the fillter as it is not to be applied on AUA
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
  dimension: aua_converted_to_cad_current_month {
    primary_key: yes
    description: ""
    type: number
  }

  measure: total_aua {
    type: sum
    sql: ${aua_converted_to_cad_current_month} ;;
  }
}
