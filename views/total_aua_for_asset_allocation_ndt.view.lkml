# this view is created to get overall total of AUA and use it in the denominator of %AUA calculation

view: total_aua_for_asset_allocation_ndt {
  derived_table: {
    explore_source: ax360_dashboards_historical {
      column: allocation_aua { field: fact_allctn_holdng.allocation_aua }

      bind_filters: {
        # to_field: dim_regstr_reprsnttv.rep_cd
        to_field: dim_user_rep_cds.rep_cd_with_rep_cd_name
        from_field: dashboard.rep_cd_with_rep_cd_name
      }

      bind_filters: {
        to_field: dashboard.allocation_name_locale
        from_field: dashboard.allocation_name_locale
      }

      bind_filters: {
        to_field: dim_accnt.accnt_tp_value
        from_field: dim_accnt.accnt_tp_value
      }

      bind_filters: {
        to_field: dim_accnt.accnt_progrm_tp_name
        from_field: dim_accnt.accnt_progrm_tp_name
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

  # fields_hidden_by_default: yes

  dimension: allocation_aua {
    primary_key: yes
    type: number
    sql: ${TABLE}.allocation_aua ;;
  }

  measure: total_aua {
    type: sum
    sql: ${allocation_aua} ;;
  }
}
