view: party_age_income_by_household_ndt_revenue {

  derived_table: {
    explore_source: ax360_dashboards_revenue {
      column: houshld_id { field: houshlds.houshld_id }
      column: houshld_name { field: houshlds.houshld_name }
      column: party_id { field: dim_party.party_id }
      column: current_party_approx_annual_income { field: dim_party.current_party_approx_annual_income_numeric }
      column: age { field: dim_party.age }

      filters: [dim_accnt.account_status_level_1_without_locale: "Open"]

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
  dimension: houshld_id {
    type: number
    sql: ${TABLE}.houshld_id ;;
  }

  dimension: houshld_houshld_name {
    type: string
    sql: ${TABLE}.houshld_houshld_name ;;
  }

  dimension: party_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.party_id ;;
  }

  dimension: party_approx_annual_income {
    type: number
    sql: ${TABLE}.party_approx_annual_income ;;
  }

  dimension: age {
    type: number
    sql:  ${TABLE}.age  ;;
  }


}
