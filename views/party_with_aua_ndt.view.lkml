# If necessary, uncomment the line below to include explore_source.

# include: "ax360_portal.model.lkml"

view: party_with_aua_ndt {
  derived_table: {
    explore_source: access_portal_api {
      column: party_id { field: dim_party.party_id }
      column: aua_converted_to_cad_rounded_off { field: fact_holdng_rr.aua_converted_to_cad_rounded_off }
      column: nk_hk_dim_party { field: dim_party.nk_hk_dim_party }
      bind_filters: {
        to_field: dim_user.user_id
        from_field: dim_user.user_id
      }

      bind_filters: {
        to_field: dim_user_rep_cds.rep_cd
        from_field: dim_user_rep_cds.rep_cd
      }

      bind_filters: {
        to_field: dim_party.nk_hk_dim_party
        from_field: dim_party.nk_hk_dim_party
      }

      bind_filters: {
        to_field: fact_holdng_rr.aua_converted_to_cad_rounded_off
        from_field: fact_holdng_rr.aua_converted_to_cad_rounded_off
      }

      filters: {
        field: dim_accnt.account_status_level_1_without_locale
        value: "Open"
      }
    }
  }

  dimension: party_id {
    primary_key: yes
    description: "Party ID"
  }

  dimension: aua_converted_to_cad_rounded_off {
    description: "AUA Converted to CAD"
    value_format: "#,##0.00"
    type: number
  }

  dimension: nk_hk_dim_party {
    description: "MD_HASH_NAT_KEYS"
    type: number
  }

  measure: aua_converted_to_cad {
    description: "AUA Converted to CAD"
    value_format: "#,##0.00"
    type: sum
    sql: ${aua_converted_to_cad_rounded_off} ;;
  }

  measure: count {
    type: count
  }



}
