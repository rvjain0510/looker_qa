# This NDT view is specifically created for AX360 team to get correct count after adding AUA filter on client list page.

view: household_list_count_ndt {
  derived_table: {
    explore_source: access_portal_api_hh {
      column: houshld_id { field: houshlds.houshld_id }
      column: houshld_name { field: houshlds.houshld_name }
      column: is_system_generated { field: houshlds.is_system_generated }
      column: houshld_client_list_with_type { field: houshlds.houshld_client_list_with_type }
      column: acct_type_and_number_list { field: houshlds.acct_type_and_number_list }
      column: aua_converted_to_cad_rounded_off { field: fact_holdng_rr.aua_converted_to_cad_rounded_off }

      bind_filters: {
        to_field: dim_user.user_id
        from_field: dim_user.user_id
      }

      bind_filters: {
        to_field: dim_user_rep_cds.rep_cd
        from_field: dim_user_rep_cds.rep_cd
      }

      bind_filters: {
        to_field: dim_party.party_name
        from_field: dim_party.party_name
      }

      bind_filters: {
        to_field: dim_party.party_address
        from_field: dim_party.party_address
      }

      bind_filters: {
        to_field: fact_holdng_rr.aua_converted_to_cad_rounded_off
        from_field: fact_holdng_rr.aua_converted_to_cad_rounded_off
      }

      bind_filters: {
        to_field: houshlds.houshld_name
        from_field: houshlds.houshld_name
      }

      bind_filters: {
        to_field: houshlds.acct_type_and_number_list
        from_field: houshlds.acct_type_and_number_list
      }

      bind_filters: {
        to_field: dim_accnt_locale.account_status__name
        from_field: dim_accnt_locale.account_status__name
      }
    }
  }
  dimension: houshld_id {
    primary_key: yes
  }
  dimension: houshld_name {}

  dimension: is_system_generated {}

  dimension: houshld_client_list_with_type {}

  dimension: acct_type_and_number_list {}

  dimension: aua_converted_to_cad_rounded_off {
    description: "AUA Converted to CAD"
    value_format: "#,##0.00"
    type: number
    sql: ${TABLE}.aua_converted_to_cad_rounded_off ;;
  }

  measure: count {
    type: count
  }
}
