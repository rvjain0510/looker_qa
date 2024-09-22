# This NDT view is specifically created for AX360 team to get correct count after adding AUA filter on client list page.

view: client_list_count_ndt {
  derived_table: {
    explore_source: access_portal_api {
      column: nk_hk_dim_party_str { field: dim_party.nk_hk_dim_party_str }
      column: party_name { field: dim_party.party_name }
      column: party_type { field: dim_party.party_type }
      column: party_address { field: dim_party.party_address }
      column: acct_type_and_number_list { field: dim_party.acct_type_and_number_list }
      column: party_primary_email { field: dim_party.party_primary_email }
      column: party_primary_phone { field: dim_party.party_primary_phone }
      column: party_date_of_birth_date { field: dim_party.party_date_of_birth_date }
      column: aua_converted_to_cad_rounded_off { field: fact_holdng_rr.aua_converted_to_cad_rounded_off }
      column: acct_type_and_number_list { field: dim_party.acct_type_and_number_list }

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
        to_field: dim_party.acct_type_and_number_list
        from_field: dim_party.acct_type_and_number_list
      }

      bind_filters: {
        to_field: dim_party.party_primary_email
        from_field: dim_party.party_primary_email
      }

      bind_filters: {
        to_field: dim_party.party_primary_phone
        from_field: dim_party.party_primary_phone
      }

      bind_filters: {
        to_field: dim_party.party_date_of_birth_date
        from_field: dim_party.party_date_of_birth_date
      }

      bind_filters: {
        to_field: dim_accnt_locale.account_status__name
        from_field: dim_accnt_locale.account_status__name
      }

      bind_filters: {
        to_field: dim_party.acct_type_and_number_list
        from_field: dim_party.acct_type_and_number_list
      }
    }
  }
  dimension: nk_hk_dim_party_str {
    primary_key: yes
    description: "MD_HASH_NAT_KEYS"
    value_format: "0"
  }
  dimension: party_name {
    description: ""
  }
  dimension: party_type {
    description: "1 = Individual, 2 = Organization"
  }
  dimension: party_address {
    description: "Party Address"
  }
  dimension: party_primary_email {
    description: "Email"
  }
  dimension: party_primary_phone {
    description: "Phone Number"
  }
  dimension: party_date_of_birth_date {
    description: "Party Date of Birth"
    type: date
  }

  dimension: acct_type_and_number_list {
    description: "Acc type and Acc number"
    type: string
  }

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
