# this view is created to get overall total of AUA and use it in the denominator of %AUA calculation

view: totals_for_segments_ndt {

    derived_table: {
      explore_source: ax360_dashboards {
        column: aua_converted_to_cad_current_month { field: fact_holdng_rr.total_aua_for_clients }
        column: total_clients { field: dim_party.total_clients }


        # 1168403-changes-for-j-and-closed-accounts: Commented the filter as the filter is not to be applied on AUA
        # filters: {
        #   field: dim_accnt.account_status_level_1_without_locale
        #   value: "Open"
        # }

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

    dimension: id {
      sql: 1 ;;
      type: number
      primary_key: yes
    }

    dimension: aua_converted_to_cad_current_month {
      description: ""
      type: number
    }
    dimension: total_clients {
      description: ""
      type: number
    }

  measure: total_clients_for_segments {
    type: average
    sql: ${TABLE}.total_clients ;;
  }

  measure: total_aua_for_segments {
    type: average
    sql: ${TABLE}.aua_converted_to_cad_current_month ;;
  }
  }
