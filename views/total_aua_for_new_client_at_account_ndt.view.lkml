# If necessary, uncomment the line below to include explore_source.

# include: "ax360_portal_qphi.model.lkml"

view: total_aua_for_new_client_at_account_ndt {
  derived_table: {
    explore_source: ax360_dashboards {
      column: aua_converted_to_cad_current_month { field: fact_holdng_rr.aua_converted_to_cad_current_month }
      column: aua_converted_to_cad_current_month_new_clients { field: fact_holdng_rr.aua_converted_to_cad_current_month_new_clients }
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

  dimension: aua_converted_to_cad_current_month_new_clients {
    description: ""
    type: number
  }

  measure: total_aua {
    type: sum
    sql: ${aua_converted_to_cad_current_month} ;;
  }

  measure: total_aua_new_clients {
    type: sum
    sql: ${aua_converted_to_cad_current_month_new_clients} ;;
  }
}
