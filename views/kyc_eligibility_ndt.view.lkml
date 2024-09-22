# This NDT view is specifically created for AX360 team to get correct count after adding KYC filter on kyc page.

view: kyc_eligibility_ndt {
  derived_table: {
    explore_source: access_portal_api {
      column: client_id { field: party_details_nearest_due_dates_pdt.client_id }
      column: party_id { field: party_details_nearest_due_dates_pdt.party_id }
      column: kyc_eligibility { field: party_details_nearest_due_dates_pdt.kyc_eligibility_fin }

      bind_filters: {
        to_field: dim_user.user_id
        from_field: dim_user.user_id
      }

      bind_filters: {
        to_field: dim_user_rep_cds.rep_cd
        from_field: dim_user_rep_cds.rep_cd
      }

      bind_filters: {
        to_field: party_details_nearest_due_dates_pdt.kyc_eligibility_fin
        from_field: party_details_nearest_due_dates_pdt.kyc_eligibility_fin
      }
    }
  }
  dimension: client_id {
    primary_key: yes
  }
  dimension: party_id {
    type: string
  }
  dimension: kyc_eligibility {
  }

  measure: count {
    type: count
  }
}
