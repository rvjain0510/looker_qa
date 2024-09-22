view: total_aua_last_12_months_at_party_ndt {
  derived_table: {
    explore_source: ax360_dashboards_revenue {
      column: party_id { field: dim_party.party_id }
      column: total_aua_last_12_month_including_current { field: fact_holdng_rr.total_aua_last_12_month_including_current }

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
  dimension: party_id {
    primary_key: yes
    description: "Party ID"
  }
  measure: total_aua_last_12_month_including_current {
    description: "12-Month AUA"
    type: sum
    sql: ${TABLE}.total_aua_last_12_month_including_current ;;
  }
}
