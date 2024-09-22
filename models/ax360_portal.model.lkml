# Define the database connection to be used for this model.


connection: "@{bq_connection_name}"

# include all the views
include: "/views/*.view.lkml"
include: "/models/*.model"
include: "/dashboards/*.dashboard.lookml"
case_sensitive: no

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Ax360 Portal"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.
#nk_hk_dim_regstr_reprsnttv

datagroup: data_platform_load {
  sql_trigger: SELECT max(END_DATE_TIME) FROM `@{bq_project_id}.@{control_dataset_name}.PIPELINE_RUN_LOG` where PIPELINE_NAME ='dag_regular_load_manager_scheduled' and STATUS ='Completed' ;;
  description: "Refresh cache after daily data platform load"
  max_cache_age: "23 hours"
}

datagroup: nocache {
  sql_trigger: SELECT CURRENT_DATETIME() ;;
  # sql_trigger: SELECT MAX(upsert_stream_apply_watermark) FROM `@{bq_project_id}.@{ods_dataset_name}.INFORMATION_SCHEMA.TABLES` WHERE table_name IN ('HOUSHLDS','HOUSHLD_ACCNTS') ;;
  description: "No Cache Data group"
  max_cache_age: "0 seconds"
}

explore: access_portal {
  view_name: dim_user

  sql_always_where: ${dim_user_rep_cds.rep_cd} <> 'SEAA' AND NOT REGEXP_CONTAINS(${dim_accnt.account_number},r'^[A-Z][A-Z]');; # added for 1276440-adjustment-to-firm-reporting

  join: language {
    relationship: one_to_one
    sql_on: true ;;
  }

  join: first_name_first {
    relationship: one_to_one
    sql_on: true ;;
  }

  # Repeated nested object
  join: dim_user_rep_cds {
    view_label: "Dim User Repcds: Rep Cds"
    sql: LEFT JOIN UNNEST(${dim_user.rep_cds}) as dim_user_rep_cds ;;
    relationship: one_to_many
  }

  join: user_team_id {
    view_label: "Dim User: Team IDs"
    sql: LEFT JOIN UNNEST(${dim_user.team_id_array}) as user_team_id ;;
    relationship: one_to_many
  }

  join: advisor_team_members_details {
    view_label: "Advisor: Team Members Name"
    sql: LEFT JOIN UNNEST(${dim_user.team_members_details}) as advisor_team_members_details ;;
    relationship: one_to_many
  }

  join: team_details_pdt {
    type: inner
    relationship: one_to_one
    sql_on:  case when ${dim_user.user_type}='Head Office' then
            1=1
            else
            ${team_details_pdt.team_id} = ${user_team_id.team_id}
            end ;;
    # sql_on: ${team_details_pdt.team_id} = ${user_team_id.team_id} ;;
  }

  join: filtered_rep_cd_by_rvp_branch_team {
    view_label: ""
    type: inner
    relationship: one_to_one
    sql_on: ${filtered_rep_cd_by_rvp_branch_team.rep_cd} = ${dim_user_rep_cds.rep_cd} ;;
  }

  join: dim_houshld_accnt_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join:  dim_accnt {
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active};;
  }

  join:  dim_accnt_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${dim_accnt_locale.nk_hk_dim_accnt} AND ${dim_accnt_locale.lang_cd} = ${language.lang_pref};;
  }


  join: fact_allctn_holdng {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_allctn_holdng.nk_hk_dim_accnt} AND ${fact_allctn_holdng.lang_cd}= ${language.lang_pref} ;;
  }

# 1168770 - Add support in looker  for multiple Trading Authority at the Account Level
  join:  fact_rel_accnt_tradng_authrt {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_tradng_authrt.nk_hk_dim_accnt} AND ${fact_rel_accnt_tradng_authrt.md_active};;
  }

  join: dim_accnt_tradng_authrt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${fact_rel_accnt_tradng_authrt.nk_hk_dim_tradng_authrt} = ${dim_accnt_tradng_authrt.nk_hk_dim_tradng_authrt} AND ${dim_accnt_tradng_authrt.md_active};;
  }

  join:  fact_rel_accnt_benfcr {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_benfcr.nk_hk_dim_accnt} AND ${fact_rel_accnt_benfcr.md_active};;
  }

  join:  dim_accnt_benfcr {
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt_benfcr.nk_hk_dim_benfcr} = ${fact_rel_accnt_benfcr.nk_hk_dim_benfcr} AND ${dim_accnt_benfcr.md_active};;
  }

  join: dim_accnt_benfcr_relation {
    from: ref_data_desc_locale
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_accnt_benfcr.benefic_relen_to_subscri} = ${dim_accnt_benfcr_relation.attrbt_val_src} AND ${dim_accnt_benfcr_relation.lang_cd} = ${language.lang_pref} AND ${dim_accnt_benfcr_relation.attrbt_name_src} = 'BENEFIC_RELEN_TO_SUBSCRI' AND ${dim_accnt_benfcr_relation.attrbt_name_destntn} = 'BENFCR_RELATION' AND ${dim_accnt_benfcr_relation.attrbt_name_src_systm} ='NBIN' AND ${dim_accnt_benfcr_relation.attrbt_name_destntn_systm} ='GCP';;
  }

  join:  fact_rel_accnt_party {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_party.nk_hk_dim_accnt} AND ${fact_rel_accnt_party.md_active};;
  }

  join: dim_party {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_rel_accnt_party.nk_hk_dim_party} = ${dim_party.nk_hk_dim_party} AND ${dim_party.md_active};;
  }

  join: dim_party_power_of_attorney {
    from: dim_party__struct_related_party
    relationship: one_to_many
    view_label: "Dim Party: Power of Attorney"
    sql: LEFT JOIN UNNEST(${dim_party.struct_related_party}) as dim_party_power_of_attorney ;;
  }

  join: dim_party_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.nk_hk_dim_party} = ${dim_party_locale.nk_hk_dim_party}  AND
      ${dim_party_locale.lang_cd} = ${language.lang_pref};;
  }

  join: houshld_accnts {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${houshld_accnts.hk_accnt_id} ;;
  }
  join: houshlds {
    type: inner
    relationship: many_to_one
    sql_on: ${houshlds.houshld_id} = ${houshld_accnts.houshld_id} ;;
  }

  join: household_categories_sdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${household_categories_sdt.houshld_id}=${houshlds.houshld_id} ;;
  }

  join: exchange_rate {
    type:  inner
    relationship: one_to_one
    sql_on:  true;;
  }

  join: holding_param_values {
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }

  join: last_holding_date {
    type:  inner
    relationship: one_to_one
    sql_on:  true;;
  }

  join: fact_holdng_rr {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_holdng_rr.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_holdng_rr.nk_hk_dim_regstr_reprsnttv}
              AND ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}";;
  }

  # added the following join to avoid the "view does not exist" error while refering fact_holdng_rr_12_months_master_list in the dashboard.view file.
  # This join is NOT to be used from this explore.
  join: last_12_months_master_list {
     view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: true ;;
  }

  # added the following join to avoid the "view does not exist" error while refering fact_holdng_rr_12_months_master_list in the dashboard.view file.
  # This join is NOT to be used from this explore.
  join: fact_holdng_rr_12_months_master_list {
    view_label: ""
    from: fact_holdng_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_holdng_rr_12_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_holdng_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}
              AND ${fact_holdng_rr_12_months_master_list.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}"
      AND ${last_12_months_master_list.last_12_months_month} = ${fact_holdng_rr_12_months_master_list.balance_dt_month}
      ;;
  }

  join: prev_holding_date {
    type:  inner
    relationship: one_to_one
    sql_on:  true;;
  }


  join: fact_holdng_rr_prev_day {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_holdng_rr_prev_day.nk_hk_dim_accnt}
                  AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_holdng_rr_prev_day.nk_hk_dim_regstr_reprsnttv}
                AND ${fact_holdng_rr_prev_day.balance_dt} = "{{ _user_attributes['prev_holding_date_dev'] }}" ;;
  }

  join: last_holding_date_by_year {
    type:  left_outer
    relationship: one_to_one
    sql_on:   ${last_holding_date_by_year.holdng_year} =
                  CASE WHEN {% parameter last_holding_date_by_year.param_year %} = 0
                                  THEN EXTRACT(YEAR FROM CURRENT_DATE()) -1
                                  ELSE ({% parameter last_holding_date_by_year.param_year %} - 1)
                  END
                ;;
  }

  join: dim_prodct_hld {
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active};;
  }

  join: fact_prodct_price {
    type: left_outer
    relationship: one_to_one
    sql_on: ${fact_prodct_price.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} ;;
  }

  join: fact_transctn_rr {
    type:  inner
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt}
             -- AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv}  # 1144073 Transaction Looker Model Change (AX360)
                AND ${fact_transctn_rr.canclld_transctn} is null ;;
  }

  join: fact_transctn_rr_12_months_master_list {
    from: fact_transctn_rr
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr_12_months_master_list.nk_hk_dim_accnt}
      AND ${fact_transctn_rr_12_months_master_list.canclld_transctn} is null
       AND ${last_12_months_master_list.last_12_months_month} = ${fact_transctn_rr_12_months_master_list.trad_dt_month};;
  }

  join: dim_prodct_tran {
    from: dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_transctn_rr.nk_hk_dim_prodct} = ${dim_prodct_tran.nk_hk_dim_prodct} AND ${dim_prodct_tran.md_active};;
  }
  join: dim_prodct_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_prodct_tran.nk_hk_dim_prodct} = ${dim_prodct_locale.nk_hk_dim_prodct} AND ${language.lang_pref} = ${dim_prodct_locale.lang_cd};;
  }
  join: dim_transctn_cd {
    type:  left_outer   #changed join from 'innner' to 'left_outer' since clients were getting filtered in the case of lost client AUA where client is lost but it does not have any transaction associated with it.
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr.nk_hk_dim_transctn_cd} = ${dim_transctn_cd.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd.lang_cd} = ${language.lang_pref} ;;
  }

  join: dim_transctn_cd_12_months_master_list {
    from: dim_transctn_cd
    type:  left_outer   #changed join from 'innner' to 'left_outer' since clients were getting filtered in the case of lost client AUA where client is lost but it does not have any transaction associated with it.
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr_12_months_master_list.nk_hk_dim_transctn_cd} = ${dim_transctn_cd_12_months_master_list.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd_12_months_master_list.lang_cd} = ${language.lang_pref} ;;
  }

  join: total_aua_last_12_months_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_aua_last_12_months_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_aua_last_12_months_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  # Joined the following view for dashboard_enhancement story [1272928]-Add Additional Tool Tips in Asset Change Graph
  join: total_aua_last_12_months_asset_change_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_aua_last_12_months_asset_change_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_aua_last_12_months_asset_change_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: fact_revn_rr {
    type:  inner
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr.nk_hk_dim_accnt}
                AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr.nk_hk_dim_regstr_reprsnttv}
               AND ${fact_revn_rr.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
               and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date);;
  }

  join: ref_revenue_type_desc {
    type: left_outer
    relationship: many_to_one
        sql_on: ${fact_revn_rr.revenue_source_code} = ${ref_revenue_type_desc.sourcecode}
    AND (case when ${fact_revn_rr.revenue_source_code}='MNL' then case when ${fact_revn_rr.entry_type_cd}='INSREV'
    then ${fact_revn_rr.entry_type_cd} = ${ref_revenue_type_desc.entry_type}  else ${ref_revenue_type_desc.entry_type} != 'INSREV' end else 1=1 end ) ;;
    }

  join: dim_prodct_revn {
    from: dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_revn_rr.nk_hk_dim_product} = ${dim_prodct_revn.nk_hk_dim_prodct} AND ${dim_prodct_revn.md_active};;
  }

  ########## Following joins added by Quantiphi ############################

  join: new_client_recruitment_period{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt.account_number}=${new_client_recruitment_period.account_number} ;;
  }

  join: lost_client_departure_period{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt.account_number}=${lost_client_departure_period.account_number} ;;
  }

  join: new_clients{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_party.nk_hk_dim_party}=${new_clients.nk_hk_dim_party} ;;
  }

  join: lost_clients{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_party.nk_hk_dim_party}=${lost_clients.nk_hk_dim_party} ;;
  }

#this join is to get orphan accounts

  join: accnts_orphan {
    from: accnts
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${accnts_orphan.hk_accnt_id} ;;
  }
  join: houshld_accnts_orphan {
    from: houshld_accnts
    type: left_outer
    relationship: many_to_one
    sql_on: ${accnts_orphan.hk_accnt_id} = ${houshld_accnts_orphan.hk_accnt_id} ;;
  }

  join: advisor_info_pdt {
    type: inner
    relationship: many_to_one
    sql_on: case when ${dim_user.user_type}='Head Office' then
            1=1
           -- ${advisor_info_pdt.rep_cd}=${dim_user_rep_cds.rep_cd}
            --and ${advisor_info_pdt.rr_role_type}='Advisor'
            else
            ${advisor_info_pdt.advisor_user_id} = ${dim_user.user_id} and ${advisor_info_pdt.rep_cd}=${dim_user_rep_cds.rep_cd}
            end;;
                        #and ${advisor_info_pdt.team_id}=${user_team_id.team_id}
    }

    join: advisor_info_for_ax360_dashboards {
      from: advisor_info_pdt
      type: inner
      relationship: many_to_one
      sql_on: case when ${dim_user.user_type}='Head Office' then
            ${advisor_info_for_ax360_dashboards.rep_cd}=${dim_user_rep_cds.rep_cd}
            else
            ${advisor_info_for_ax360_dashboards.advisor_user_id} = ${dim_user.user_id} and ${advisor_info_for_ax360_dashboards.rep_cd}=${dim_user_rep_cds.rep_cd}
            end;;
                        #and ${advisor_info_pdt.team_id}=${user_team_id.team_id}
      }

  ##########  joins added by Quantiphi Ends here ###########################

}

explore: access_portal_api {
  extends: [access_portal]
  # persist_with: data_platform_load
  always_filter: {
    filters: [dim_user.user_id: "0", language.lang_pref: "en", first_name_first.first_name_first: "Yes"]
  }

  join: data_navigator {
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }
  # 1154400 - Joined the global_search_client_ndt_access_portal_api view to add multifilter client in the Access Portal API explore
  join: global_search_client_ndt_access_portal_api {
    type: inner
    relationship: one_to_one
    sql_on: ${global_search_client_ndt_access_portal_api.dim_party_nk_hk_dim_party_str} = ${dim_party.nk_hk_dim_party_str} ;;
  }

  # 1154400 - Joined the global_search_household_ndt_access_portal_api view to add multifilter houshld in the Access Portal API explore
  join: global_search_household_ndt_access_portal_api {
    type: inner
    relationship: one_to_one
    sql_on: ${global_search_household_ndt_access_portal_api.houshld_id} = ${houshlds.houshld_id} ;;
  }

  join: client_list_count_ndt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.nk_hk_dim_party_str} = ${client_list_count_ndt.nk_hk_dim_party_str} ;;
  }

  join: kyc_eligibility_ndt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${kyc_eligibility_ndt.party_id} ;;
  }

  join: household_list_count_ndt {
    type: inner
    relationship: one_to_one
    sql_on: ${houshlds.houshld_id} = ${household_list_count_ndt.houshld_id} ;;
  }

  join: party_with_aua_ndt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${party_with_aua_ndt.party_id} ;;
  }

  join: party_nearest_due_dates_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${party_nearest_due_dates_pdt.party_id} AND ${party_nearest_due_dates_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: party_details_nearest_due_dates_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${party_details_nearest_due_dates_pdt.party_id} AND ${party_details_nearest_due_dates_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }
}

explore: access_portal_api_hh {
  extends: [access_portal_api]
  persist_with: nocache
}

explore: access_portal_dashboard {
  extends: [access_portal]
  persist_with: data_platform_load
  access_filter: {
    field: dim_user.user_id
    user_attribute: user_id_dev_dev
  }

  access_filter: {
    field: language.lang_pref
    user_attribute: locale
  }

  access_filter: {
    field: first_name_first.first_name_first
    user_attribute: first_name_first
  }


########## Following joins added by Quantiphi ############################

  join: total_aua_party_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${total_aua_party_ndt.md_hash_nat_keys}=${dim_party.nk_hk_dim_party} ;;
  }

  join: households_age_income_segments {
    view_label : ""
    relationship: one_to_one
    type: inner
    sql_on: ${houshlds.houshld_id} = ${households_age_income_segments.houshld_id} ;;
  }

  join: party_age_income_by_household_ndt {
    view_label : ""
    type: inner
    relationship: one_to_many
    sql_on: ${party_age_income_by_household_ndt.houshld_id}=${houshlds.houshld_id} and ${party_age_income_by_household_ndt.party_id} = ${dim_party.party_id};;
  }

  join: households_aua_segments {
    view_label : ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_segments.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: households_revenue_segments_ndt {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_revenue_segments_ndt.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: households_aua_for_revenue_segments_ndt {
    from: households_aua_segments
    view_label : ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_for_revenue_segments_ndt.houshld_id}=${households_revenue_segments_ndt.houshld_id} ;;
  }

  # join: households_revenue_segments_ndt {
  #   view_label : ""
  #   type: left_outer
  #   relationship: one_to_one
  #   sql_on: ${households_revenue_segments_ndt.houshld_id}=${households_age_income_segments.houshld_id} ;;
  # }

  join: totals_for_segments_ndt {   # this view is created to get total of AUA to use in the denominator while calculating %AUA
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_household_for_segments_ndt {    # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_asset_allocation_ndt {  # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_new_client_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_last_12_months_at_party_ndt { # used in revenue segmentation look.
    type: left_outer
    relationship: one_to_one
    sql_on:  ${dim_party.party_id} = ${total_aua_last_12_months_at_party_ndt.party_id} ;;
  }

##########  joins added by Quantiphi Ends here ############################

  join: dashboard {
    view_label: ""
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }

  #adding the following join to eliminate "Unknown view. View does not exist" error. Fields from the following join are referenced in dashboard.view file
  # added the following joins for asset_change_ndt_tran for dashboard_enhancement stories [1272931]-Add Total Row For Asset Change Table and [1272928]-Add Additional Tool Tips in Asset Change Graph
  join: asset_change_ndt_tran {
    from: asset_change_ndt
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${last_12_months_master_list.last_12_months_month} = ${asset_change_ndt_tran.last_12_months_month} ;;
  }

  # join: dim_user_hisorical_rep_cds { #added to avoid reference issue.
  #   view_label: "Dim User Repcds: Rep Cds"
  #   sql:true;;
  #   relationship: one_to_many
  # }
}

# explore: ref_data_desc_locale {}

# explore: ref_data_desc {}

# explore: fact_allctn_prodct {}

# 1154400 - Created the following explore to add multifilter household in the Access Portal API explore

explore: access_portal_dashboard_hh {
  extends: [access_portal_dashboard]
  persist_with: nocache
}


explore: global_search_client_ndt {
  # sql_always_where:
  # {% if global_search_client_ndt.big_search_filter._in_query %}
  # SEARCH(global_search_client_ndt, {% parameter global_search_client_ndt.big_search_filter %})
  # {% else %}
  # 1=1
  # {% endif %};;
}


explore: global_search_household_ndt {
  # sql_always_having:
  # {% if global_search_household_ndt.big_search_filter._in_query %}
  # --SEARCH(${global_search_household_ndt.houshld_client_list}, {% parameter global_search_household_ndt.big_search_filter %})
  # ${global_search_household_ndt.houshld_client_list} LIKE {% parameter global_search_household_ndt.big_search_filter %}
  # {% else %}
  # 1=1
  # {% endif %};;
}


explore: ax360_dashboards {    ### Explore added by Quantiphi
  extends: [access_portal_dashboard]
  label: "details" #this is localized

  join:  dim_accnt {
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active}
           {% if dashboard.filtered_accnt_tp__name_merged._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'
          {% elsif dashboard.filtered_accnt_progrm_tp__value._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'

      {% else %}

      {% endif %}
      ;;
  }

  join: fact_holdng_rr {
    view_label : ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr.nk_hk_dim_accnt}
                           {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif dashboard.average_assets_per_active_accounts._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif dashboard.total_aua_current_month._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif dashboard.average_assets_per_active_clients._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif dashboard.total_aua_current_month_sample._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif total_aua_party_ndt.avg_aua._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif   fact_holdng_rr.aua_converted_to_cad_current_month._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif   fact_holdng_rr.total_aua_for_clients._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
                              {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
                              AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% else %}
      AND (${fact_holdng_rr.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
      OR ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
      {% endif %}
      ;;
  }

  # added the following join to avoid the "view does not exist" error while refering fact_holdng_rr_12_months_master_list in the dashboard.view file.
  # This join is NOT to be used from this explore.
  join: fact_holdng_rr_12_months_master_list {
  view_label : ""
  from: fact_holdng_rr
  type: left_outer
  relationship: one_to_many
  sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr_12_months_master_list.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_holdng_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}

    {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif dashboard.average_assets_per_active_accounts._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif dashboard.total_aua_current_month._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif dashboard.average_assets_per_active_clients._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif dashboard.total_aua_current_month_sample._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif total_aua_party_ndt.avg_aua._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif   fact_holdng_rr_12_months_master_list.aua_converted_to_cad_current_month._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif   fact_holdng_rr_12_months_master_list.total_aua_for_clients._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
    {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
    AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"


    {% else %}
    AND (${fact_holdng_rr_12_months_master_list.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
    OR ${fact_holdng_rr_12_months_master_list.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
    {% endif %}

    AND ${last_12_months_master_list.last_12_months_month} = ${fact_holdng_rr_12_months_master_list.balance_dt_month}
    ;;
  }


  join: dim_prodct_hld {
    sql_where: {% if dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
               ${dim_prodct_hld.prodct_id}  NOT IN ('CAD','USD')  AND ${dim_prodct_hld.prodct_id} is NOT NULL
            {% else %}
            {% endif %} ;;
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active} ;;
  }


  join: fact_transctn_rr {
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt} AND
    -- 1144074- Transaction Looker Model Change Dashboards (Added this conditional join to not consider historical transactions for lost client/account's average AUA)
    {% if dashboard.total_lost_accounts_multi_value._in_query %}
    ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv} AND
    {% elsif dashboard.total_lost_client_multi_value._in_query %}
    ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv} AND
    {% else %}
    {% endif %}
    ${fact_transctn_rr.canclld_transctn} is null
    AND ${fact_transctn_rr.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}";;
  }

  join: fact_revn_rr {
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr.nk_hk_dim_accnt}
             AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr.nk_hk_dim_regstr_reprsnttv} AND
               {% if fact_revn_rr.total_revenue._in_query %}
             ${fact_revn_rr.transaction_date} >=DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 23 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% else %}
             ${fact_revn_rr.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% endif %};;
  }

  join: total_aua_for_asset_allocation_ndt {  # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: dashboard {
    view_label : ""
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }

  #adding the following join to eliminate Unknown view. View does not exist error. Fields from the following join are referenced in dashboard.view file
  join: asset_change_ndt_tran {
    from: asset_change_ndt
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${last_12_months_master_list.last_12_months_month} = ${asset_change_ndt_tran.last_12_months_month} ;;
  }
}

explore: ax360_dashboards_hh {
  persist_with: nocache
  extends: [ax360_dashboards]
}

############################### EXPLORE FOR HISTORICAL REP CODES BEGIN ###############################################

explore: ax360_dashboards_historical {    ### Explore added by Quantiphi
  extends: [access_portal_dashboard]
  label: "details"


  persist_with: data_platform_load
  access_filter: {
    field: dim_user.user_id
    user_attribute: user_id_dev_dev
  }
  access_filter: {
    field: language.lang_pref
    user_attribute: locale
  }
  access_filter: {
    field: first_name_first.first_name_first
    user_attribute: first_name_first
  }

  ########## Following joins added by Quantiphi ############################


  join: dim_user_rep_cds {
    view_label : ""
    from: dim_user_rep_cds
    sql: LEFT JOIN UNNEST(${dim_user.rep_cds}) as dim_user_rep_cds ;;
    relationship: one_to_many
  }

  join: dim_houshld_accnt_pdt {
    view_label : ""
    from: dim_houshld_accnt_historical_pdt
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join:  dim_accnt {
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active}
          {% if dashboard.filtered_accnt_tp__name_merged._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'
          {% elsif dashboard.filtered_accnt_progrm_tp__value._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'

      {% else %}

      {% endif %}
      ;;
  }

  join: fact_allctn_holdng {
    from: fact_allctn_holdng_historical
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_allctn_holdng.nk_hk_dim_accnt}
            AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_allctn_holdng.nk_hk_dim_regstr_reprsnttv}
            AND ${fact_allctn_holdng.lang_cd}= ${language.lang_pref} ;;
  }

  join: dim_prodct_hld {
    view_label : ""
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active}
    {% if dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
              AND ${dim_prodct_hld.prodct_id}  NOT IN ('CAD','USD')  AND ${dim_prodct_hld.prodct_id} is NOT NULL
            {% else %}
            {% endif %}
            ;;
  }

  join: fact_holdng_rr {
    view_label : ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr.nk_hk_dim_accnt}
        AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_holdng_rr.nk_hk_dim_regstr_reprsnttv}

      {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_accounts._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif total_aua_party_ndt.avg_aua._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.aua_converted_to_cad_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.total_aua_for_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"

      {% else %}
      AND (${fact_holdng_rr.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
      OR ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
      {% endif %}

      ;;
  }

  # added the following joins for asset_change_ndt and asset_change_ndt_tran for dashboard_enhancement stories [1272931]-Add Total Row For Asset Change Table and [1272928]-Add Additional Tool Tips in Asset Change Graph
  # the following two joins are added in historical explore as they are being used only on the Book of Business dashboard for the Tooltip in asset change chart and in market variation and total growth scorecard under 12 months net change
  join: asset_change_ndt {
    sql_where: ${asset_change_ndt.last_12_months_month} is not null ;;
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.balance_dt_month}= ${asset_change_ndt.last_12_months_month} ;;
  }

  join: asset_change_ndt_tran {
    # sql_where: ${asset_change_ndt_tran.balance_dt_month} is not null ;;
    from: asset_change_ndt
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${last_12_months_master_list.last_12_months_month} = ${asset_change_ndt_tran.last_12_months_month}
      ;;
  }

  join: last_12_months_master_list {
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: true ;;
  }

  join: fact_holdng_rr_12_months_master_list {
    view_label : ""
    from: fact_holdng_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr_12_months_master_list.nk_hk_dim_accnt}
        AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_holdng_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}

      {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_accounts._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_clients._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_sample._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif total_aua_party_ndt.avg_aua._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr_12_months_master_list.aua_converted_to_cad_current_month._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr_12_months_master_list.total_aua_for_clients._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
      AND ${fact_holdng_rr_12_months_master_list.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"


      {% else %}
      AND (${fact_holdng_rr_12_months_master_list.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
      OR ${fact_holdng_rr_12_months_master_list.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
      {% endif %}

      AND ${last_12_months_master_list.last_12_months_month} = ${fact_holdng_rr_12_months_master_list.balance_dt_month}
      ;;
  }

  join: fact_transctn_rr {
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv}
      AND ${fact_transctn_rr.canclld_transctn} is null
      AND ${fact_transctn_rr.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}"
       ;;
  }

  join: fact_transctn_rr_12_months_master_list {
    from: fact_transctn_rr
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr_12_months_master_list.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}
      AND ${fact_transctn_rr_12_months_master_list.canclld_transctn} is null
      AND ${fact_transctn_rr_12_months_master_list.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}"
       AND ${last_12_months_master_list.last_12_months_month} = ${fact_transctn_rr_12_months_master_list.trad_dt_month};;
  }

  join: dim_transctn_cd {
    type:  left_outer   #changed join from 'innner' to 'left_outer' since clients were getting filtered in the case of lost client AUA where client is lost but it does not have any transaction associated with it.
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr.nk_hk_dim_transctn_cd} = ${dim_transctn_cd.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd.lang_cd} = ${language.lang_pref} ;;
  }

  join: dim_transctn_cd_12_months_master_list {
    from: dim_transctn_cd
    type:  left_outer   #changed join from 'innner' to 'left_outer' since clients were getting filtered in the case of lost client AUA where client is lost but it does not have any transaction associated with it.
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr_12_months_master_list.nk_hk_dim_transctn_cd} = ${dim_transctn_cd_12_months_master_list.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd_12_months_master_list.lang_cd} = ${language.lang_pref} ;;
  }

  join: fact_revn_rr {
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr.nk_hk_dim_accnt}
          AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr.nk_hk_dim_regstr_reprsnttv}
          AND  ${fact_revn_rr.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
            and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
          ;;
  }

  join: ref_revenue_type_desc {
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_revn_rr.revenue_source_code} = ${ref_revenue_type_desc.sourcecode}
          AND (case when ${fact_revn_rr.revenue_source_code}='MNL' then case when ${fact_revn_rr.entry_type_cd}='INSREV'
          then ${fact_revn_rr.entry_type_cd} = ${ref_revenue_type_desc.entry_type}  else ${ref_revenue_type_desc.entry_type} != 'INSREV' end else 1=1 end ) ;;
  }

  join: dashboard {
    view_label : ""
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }
##########  joins added by Quantiphi Ends here ############################
}


explore: ax360_dashboards_revenue {    ### Explore added by Quantiphi
  extends: [access_portal]
  label: "details"
  view_name: dim_user

  persist_with: data_platform_load

  access_filter: {
    field: dim_user.user_id
    user_attribute: user_id_dev_dev
  }

  access_filter: {
    field: language.lang_pref
    user_attribute: locale
  }

  access_filter: {
    field: first_name_first.first_name_first
    user_attribute: first_name_first
  }

  ########## Following joins added by Quantiphi ############################


  join: dim_user_rep_cds {
    view_label: ""
    from: dim_user_rep_cds_revenue
    sql: LEFT JOIN UNNEST(${dim_user.revenue_rep_cds}) as dim_user_rep_cds ;;
    relationship: one_to_many
  }

  join: dim_houshld_accnt_pdt {
    view_label : ""
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join:  dim_accnt {
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active}
           {% if dashboard.filtered_accnt_tp__name_merged._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'
          {% elsif dashboard.filtered_accnt_progrm_tp__value._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'

      {% else %}

      {% endif %}
      ;;
  }

  join: fact_allctn_holdng {
    from: fact_allctn_holdng_historical
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_allctn_holdng.nk_hk_dim_accnt}
            AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_allctn_holdng.nk_hk_dim_regstr_reprsnttv}
            AND ${fact_allctn_holdng.lang_cd}= ${language.lang_pref} ;;
  }




  join: fact_holdng_rr {
    view_label : ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr.nk_hk_dim_accnt}
        AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_holdng_rr.nk_hk_dim_regstr_reprsnttv}

      {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_accounts._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif total_aua_party_ndt.avg_aua._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.aua_converted_to_cad_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.total_aua_for_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"

      {% else %}
      AND (${fact_holdng_rr.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
      OR ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
      {% endif %}
      ;;
  }

  join: dim_prodct_hld {
    view_label : ""
    sql_where: {% if dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
               ${dim_prodct_hld.prodct_id}  NOT IN ('CAD','USD')  AND ${dim_prodct_hld.prodct_id} is NOT NULL
            {% else %}
            {% endif %} ;;
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active} ;;
  }

  join: fact_transctn_rr {
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv}
      AND ${fact_transctn_rr.canclld_transctn} is null
      AND ${fact_transctn_rr.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}";;
  }


  join: total_aua_party_ndt {
    from: total_aua_party_ndt_revenue
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${total_aua_party_ndt.md_hash_nat_keys}=${dim_party.nk_hk_dim_party} ;;
  }

  join: households_age_income_segments {
    from: households_age_income_segments_revenue
    view_label : ""
    relationship: one_to_one
    type: inner
    sql_on: ${houshlds.houshld_id} = ${households_age_income_segments.houshld_id} ;;
  }

  join: party_age_income_by_household_ndt {
    from: party_age_income_by_household_ndt_revenue
    view_label : ""
    type: inner
    relationship: one_to_many
    sql_on: ${party_age_income_by_household_ndt.houshld_id}=${houshlds.houshld_id} and ${party_age_income_by_household_ndt.party_id} = ${dim_party.party_id};;
  }

  join: households_aua_segments {
    from: households_aua_segments_revenue
    view_label : ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_segments.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: totals_for_segments_ndt {   # this view is created to get total of AUA to use in the denominator while calculating %AUA
    from: totals_for_segments_ndt_revenue
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_household_for_segments_ndt {    # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    from: total_household_for_segments_ndt_revenue
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_asset_allocation_ndt {  # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_new_client_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }


  join: dashboard {
    from: dashboard_revenue
    view_label : ""
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }

  join: total_aua_last_12_months_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_aua_last_12_months_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_aua_last_12_months_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: last_24_month_master_list {
    # view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: true ;;
  }

  join: fact_revn_rr {
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr.nk_hk_dim_accnt}
             AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr.nk_hk_dim_regstr_reprsnttv} AND
               {% if fact_revn_rr.total_revenue._in_query %}
             ${fact_revn_rr.transaction_date} >=DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 23 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% else %}
             ${fact_revn_rr.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% endif %};;
  }

  join: ref_revenue_type_desc {
    type: left_outer
    relationship: many_to_one
       sql_on: ${fact_revn_rr.revenue_source_code} = ${ref_revenue_type_desc.sourcecode}
    AND (case when ${fact_revn_rr.revenue_source_code}='MNL' then case when ${fact_revn_rr.entry_type_cd}='INSREV'
    then ${fact_revn_rr.entry_type_cd} = ${ref_revenue_type_desc.entry_type}  else ${ref_revenue_type_desc.entry_type} != 'INSREV' end else 1=1 end ) ;;
  }

  join: fact_revn_rr_12_months_master_list {
    # view_label: ""
    from: fact_revn_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr_12_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv} and
             ${fact_revn_rr_12_months_master_list.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
             and ${fact_revn_rr_12_months_master_list.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
             and ${last_12_months_master_list.last_12_months_month} = ${fact_revn_rr_12_months_master_list.transaction_month}
      ;;
  }

  join: fact_revn_rr_24_months_master_list {
    fields: [fact_revn_rr_24_months_master_list.transaction_month,fact_revn_rr_24_months_master_list.total_revenue]
    view_label: ""
    from: fact_revn_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr_24_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr_24_months_master_list.nk_hk_dim_regstr_reprsnttv} and
             ${fact_revn_rr_24_months_master_list.transaction_date} >=DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 23 MONTH),MONTH)
             and ${fact_revn_rr_24_months_master_list.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
            AND ${last_24_month_master_list.last_24_months} = ${fact_revn_rr_24_months_master_list.transaction_month}
      ;;
  }

  join: total_revenue_at_account_ndt {
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_household_revenue_for_segments_ndt {    # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: households_revenue_segments_ndt {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_revenue_segments_ndt.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: households_aua_for_revenue_segments_ndt {
    from: households_aua_segments_revenue
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_for_revenue_segments_ndt.houshld_id}=${households_revenue_segments_ndt.houshld_id} ;;
  }

  join: total_aua_last_12_months_at_party_ndt { # used in revenue segmentation look.
    type: left_outer
    relationship: one_to_one
    sql_on:  ${dim_party.party_id} = ${total_aua_last_12_months_at_party_ndt.party_id} ;;
  }

  join: total_revenue_party_ndt {
    view_label: ""
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${total_revenue_party_ndt.party_id} and ${dim_party.nk_hk_dim_party} = ${total_revenue_party_ndt.md_hash_nat_keys};;
  }

  join: total_revenue_last_12_months_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_revenue_last_12_months_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_revenue_last_12_months_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: houshld_accnts_revenue {
    from: houshld_accnts
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${houshld_accnts_revenue.hk_accnt_id} ;;
  }
  join: houshlds_revenue {
    from: houshlds
    type: left_outer
    relationship: many_to_one
    sql_on: ${houshlds_revenue.houshld_id} = ${houshld_accnts_revenue.houshld_id} ;;
  }

##########  joins added by Quantiphi Ends here ############################

}

explore: ax360_dashboards_hh_revenue {
  persist_with: nocache
  extends: [ax360_dashboards_revenue]
}

explore: ax360_dashboards_revenue_api {    ### Explore added by Quantiphi
  extends: [access_portal]
  view_name: dim_user

  always_filter: {
    filters: [dim_user.user_id: "0", language.lang_pref: "en", first_name_first.first_name_first: "Yes"]
  }

  persist_with: data_platform_load

  ########## Following joins added by Quantiphi ############################


  join: dim_user_rep_cds {
    view_label : ""
    from: dim_user_rep_cds_revenue
    sql: LEFT JOIN UNNEST(${dim_user.revenue_rep_cds}) as dim_user_rep_cds ;;
    relationship: one_to_many
  }

  join: dim_houshld_accnt_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join:  dim_accnt {
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active}
           {% if dashboard.filtered_accnt_tp__name_merged._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'
          {% elsif dashboard.filtered_accnt_progrm_tp__value._in_query %}
          AND ${dim_accnt.accnt_rap_cd}!='J'

      {% else %}

      {% endif %}
      ;;
  }

  join: fact_allctn_holdng {
    from: fact_allctn_holdng_historical
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_allctn_holdng.nk_hk_dim_accnt}
            AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_allctn_holdng.nk_hk_dim_regstr_reprsnttv}
            AND ${fact_allctn_holdng.lang_cd}= ${language.lang_pref} ;;
  }


  join: fact_holdng_rr {
    view_label : ""
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt}=${fact_holdng_rr.nk_hk_dim_accnt}
        AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_holdng_rr.nk_hk_dim_regstr_reprsnttv}

      {% if dashboard.total_aua_current_month_drill_prgrm_tp_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_accounts._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.average_assets_per_active_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif dashboard.total_aua_current_month_sample._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif total_aua_party_ndt.avg_aua._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.aua_converted_to_cad_current_month._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   fact_holdng_rr.total_aua_for_clients._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"
      {% elsif   dashboard.average_assets_per_active_houshold._in_query %}
      AND ${fact_holdng_rr.balance_dt}="{{ _user_attributes['latest_holding_date_dev'] }}"

      {% else %}
      AND (${fact_holdng_rr.balance_dt} IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
      OR ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}")
      {% endif %}
      ;;
  }

  join: dim_prodct_hld {
    view_label : ""
    sql_where: {% if dashboard.total_aua_current_month_drill_top_10_sample._in_query %}
               ${dim_prodct_hld.prodct_id}  NOT IN ('CAD','USD')  AND ${dim_prodct_hld.prodct_id} is NOT NULL
            {% else %}
            {% endif %} ;;
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active} ;;
  }

  join: fact_transctn_rr {
     view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv}
      AND ${fact_transctn_rr.canclld_transctn} is null
      AND ${fact_transctn_rr.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}";;
  }


  join: total_aua_party_ndt {
    from:  total_aua_party_ndt_revenue
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${total_aua_party_ndt.md_hash_nat_keys}=${dim_party.nk_hk_dim_party} ;;
  }

  join: households_age_income_segments {
    from: households_age_income_segments_revenue
    view_label : ""
    relationship: one_to_one
    type: inner
    sql_on: ${houshlds.houshld_id} = ${households_age_income_segments.houshld_id} ;;
  }

  join: party_age_income_by_household_ndt {
    from: party_age_income_by_household_ndt_revenue
    view_label : ""
    type: inner
    relationship: one_to_many
    sql_on: ${party_age_income_by_household_ndt.houshld_id}=${houshlds.houshld_id} and ${party_age_income_by_household_ndt.party_id} = ${dim_party.party_id};;
  }

  join: households_aua_segments {
    from: households_aua_segments_revenue
    view_label : ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_segments.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: totals_for_segments_ndt {   # this view is created to get total of AUA to use in the denominator while calculating %AUA
    from: totals_for_segments_ndt_revenue
    view_label : ""
    type: inner
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_household_for_segments_ndt {    # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    from: total_household_for_segments_ndt_revenue
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_asset_allocation_ndt {  # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_aua_for_new_client_at_account_ndt {
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: dashboard {
    from: dashboard_revenue
    view_label : ""
    type: inner
    relationship: one_to_one
    sql_on: true ;;
  }

  join: total_aua_last_12_months_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_aua_last_12_months_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_aua_last_12_months_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: last_24_month_master_list {
    # view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: true ;;
  }

  join: fact_revn_rr {
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr.nk_hk_dim_accnt}
             AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr.nk_hk_dim_regstr_reprsnttv} AND
               {% if fact_revn_rr.total_revenue._in_query %}
             ${fact_revn_rr.transaction_date} >=DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 23 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% else %}
             ${fact_revn_rr.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
             and ${fact_revn_rr.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
               {% endif %};;
  }

  join: ref_revenue_type_desc {
    type: left_outer
    relationship: many_to_one
        sql_on: ${fact_revn_rr.revenue_source_code} = ${ref_revenue_type_desc.sourcecode}
    AND (case when ${fact_revn_rr.revenue_source_code}='MNL' then case when ${fact_revn_rr.entry_type_cd}='INSREV'
    then ${fact_revn_rr.entry_type_cd} = ${ref_revenue_type_desc.entry_type}  else ${ref_revenue_type_desc.entry_type} != 'INSREV' end else 1=1 end ) ;;
  }

  join: fact_revn_rr_12_months_master_list {
    fields: [fact_revn_rr_12_months_master_list.transaction_month,fact_revn_rr_12_months_master_list.total_12_month_revenue]
    view_label: ""
    from: fact_revn_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr_12_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv} and
             ${fact_revn_rr_12_months_master_list.transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 MONTH),MONTH)
             and ${fact_revn_rr_12_months_master_list.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
            AND ${last_12_months_master_list.last_12_months_month} = ${fact_revn_rr_12_months_master_list.transaction_month}
      ;;
  }

  join: fact_revn_rr_24_months_master_list {
    fields: [fact_revn_rr_24_months_master_list.transaction_month,fact_revn_rr_24_months_master_list.total_revenue]
    view_label: ""
    from: fact_revn_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_revn_rr_24_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${fact_revn_rr_24_months_master_list.nk_hk_dim_regstr_reprsnttv} and
             ${fact_revn_rr_24_months_master_list.transaction_date} >=DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 23 MONTH),MONTH)
             and ${fact_revn_rr_24_months_master_list.transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)
            AND ${last_24_month_master_list.last_24_months} = ${fact_revn_rr_24_months_master_list.transaction_month}
      ;;
  }

  join: total_revenue_at_account_ndt {
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: total_household_revenue_for_segments_ndt {    # this view is created to get total of AUA and use it in the denominator for calculating %AUA
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: 1=1 ;;
  }

  join: households_revenue_segments_ndt {
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_revenue_segments_ndt.houshld_id}=${households_age_income_segments.houshld_id} ;;
  }

  join: households_aua_for_revenue_segments_ndt {
    from: households_aua_segments_revenue
    view_label: ""
    type: left_outer
    relationship: one_to_one
    sql_on: ${households_aua_for_revenue_segments_ndt.houshld_id}=${households_revenue_segments_ndt.houshld_id} ;;
  }

  join: total_aua_last_12_months_at_party_ndt { # used in revenue segmentation look.
    type: left_outer
    relationship: one_to_one
    sql_on:  ${dim_party.party_id} = ${total_aua_last_12_months_at_party_ndt.party_id} ;;
  }

  join: total_revenue_party_ndt {
    view_label: ""
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${total_revenue_party_ndt.party_id} and ${dim_party.nk_hk_dim_party} = ${total_revenue_party_ndt.md_hash_nat_keys};;
  }

  join: total_revenue_last_12_months_pdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${total_revenue_last_12_months_pdt.nk_hk_dim_accnt}
      AND ${dim_user_rep_cds.nk_hk_dim_regstr_reprsnttv} = ${total_revenue_last_12_months_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: houshld_accnts_revenue {
    from: houshld_accnts
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${houshld_accnts_revenue.hk_accnt_id} ;;
  }
  join: houshlds_revenue {
    from: houshlds
    type: left_outer
    relationship: many_to_one
    sql_on: ${houshlds_revenue.houshld_id} = ${houshld_accnts_revenue.houshld_id} ;;
  }

##########  joins added by Quantiphi Ends here ############################

}

explore: ax360_dashboards_hh_revenue_api {
  persist_with: nocache
  extends: [ax360_dashboards_revenue_api]
}

explore: access_portal_no_dim_user_api {
  view_name: dim_houshld_accnt_pdt

  # Using view dim_houshld_accnt_pdt_no_dim_user_api which has the filters applied for 1276440-adjustment-to-firm-reporting
  # The filters are not applied here as they led to skipping of row numbers in the row_limit_index_row_no_user_repcd_pdt and /views/row_limit_index_row_no_pdt
  from: dim_houshld_accnt_pdt_no_dim_user_api

  join: dim_user_unnested {
    view_label: "Dim User Repcds: Rep Cds"
    type: inner
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_user_unnested.nk_hk_dim_regstr_reprsnttv} ;;
    relationship: one_to_one
  }

  join:  dim_accnt {
    type: inner
    relationship: many_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${dim_accnt.nk_hk_dim_accnt} AND ${dim_accnt.md_active};;
  }

  join:  dim_accnt_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${dim_accnt_locale.nk_hk_dim_accnt} AND ${dim_accnt_locale.lang_cd} = ${language.lang_pref};;
  }

# 1168770 - Add support in looker  for multiple Trading Authority at the Account Level
  join:  fact_rel_accnt_tradng_authrt {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_tradng_authrt.nk_hk_dim_accnt} AND ${fact_rel_accnt_tradng_authrt.md_active};;
  }

  join: dim_accnt_tradng_authrt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${fact_rel_accnt_tradng_authrt.nk_hk_dim_tradng_authrt} = ${dim_accnt_tradng_authrt.nk_hk_dim_tradng_authrt} AND ${dim_accnt_tradng_authrt.md_active};;
  }

  join:  fact_rel_accnt_benfcr { # added to avoid lookml reference error
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_benfcr.nk_hk_dim_accnt} AND ${fact_rel_accnt_benfcr.md_active};;
  }

  join:  dim_accnt_benfcr {    # added to avoid lookml reference error
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt_benfcr.nk_hk_dim_benfcr} = ${fact_rel_accnt_benfcr.nk_hk_dim_benfcr} AND ${dim_accnt_benfcr.md_active};;
  }

  join: dim_accnt_benfcr_relation {  # added to avoid lookml reference error
    from: ref_data_desc_locale
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_accnt_benfcr.benefic_relen_to_subscri} = ${dim_accnt_benfcr_relation.attrbt_val_src} AND ${dim_accnt_benfcr_relation.lang_cd} = ${language.lang_pref} AND ${dim_accnt_benfcr_relation.attrbt_name_src} = 'BENEFIC_RELEN_TO_SUBSCRI' AND ${dim_accnt_benfcr_relation.attrbt_name_destntn} = 'BENFCR_RELATION' AND ${dim_accnt_benfcr_relation.attrbt_name_src_systm} ='NBIN' AND ${dim_accnt_benfcr_relation.attrbt_name_destntn_systm} ='GCP';;
  }

  join:  fact_rel_accnt_party {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${fact_rel_accnt_party.nk_hk_dim_accnt} AND ${fact_rel_accnt_party.md_active};;
  }

  join: dim_party {
    type: inner
    relationship: many_to_one
    sql_on: ${fact_rel_accnt_party.nk_hk_dim_party} = ${dim_party.nk_hk_dim_party} AND ${dim_party.md_active};;
  }

  join: dim_party_power_of_attorney {
    from: dim_party__struct_related_party
    relationship: one_to_many
    view_label: "Dim Party: Power of Attorney"
    sql: LEFT JOIN UNNEST(${dim_party.struct_related_party}) as dim_party_power_of_attorney ;;
  }

  join: dim_party_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.nk_hk_dim_party} = ${dim_party_locale.nk_hk_dim_party}  AND
      ${dim_party_locale.lang_cd} = ${language.lang_pref};;
  }

  join: party_nearest_due_dates_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${party_nearest_due_dates_pdt.party_id} AND ${party_nearest_due_dates_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: party_details_nearest_due_dates_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_party.party_id} = ${party_details_nearest_due_dates_pdt.party_id} AND ${party_details_nearest_due_dates_pdt.nk_hk_dim_regstr_reprsnttv} = ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} ;;
  }

  join: houshld_accnts {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${houshld_accnts.hk_accnt_id} ;;
  }
  join: houshlds {
    type: inner
    relationship: many_to_one
    sql_on: ${houshlds.houshld_id} = ${houshld_accnts.houshld_id} ;;
  }

  join: household_categories_sdt {
    type: left_outer
    relationship: one_to_one
    sql_on: ${household_categories_sdt.houshld_id}=${houshlds.houshld_id} ;;
  }

  join: last_holding_date {     # added to avoid lookml reference error
    type:  inner
    relationship: one_to_one
    sql_on:  true;;
  }

  join: fact_holdng_rr {
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_holdng_rr.nk_hk_dim_accnt}
              AND ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${fact_holdng_rr.nk_hk_dim_regstr_reprsnttv}
              AND ${fact_holdng_rr.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}";;
  }

  join: dim_prodct_hld {
    from:  dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_holdng_rr.nk_hk_dim_prodct} = ${dim_prodct_hld.nk_hk_dim_prodct} AND ${dim_prodct_hld.md_active};;
  }

  join: dim_prodct_locale {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_prodct_hld.nk_hk_dim_prodct} = ${dim_prodct_locale.nk_hk_dim_prodct} AND ${language.lang_pref} = ${dim_prodct_locale.lang_cd};;
  }

  join: fact_transctn_rr {
    type:  inner
    relationship: one_to_many
    sql_on:  ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_transctn_rr.nk_hk_dim_accnt}
               -- AND ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${fact_transctn_rr.nk_hk_dim_regstr_reprsnttv}   -- # 1144073 Transaction Looker Model Change (AX360)
                AND ${fact_transctn_rr.canclld_transctn} is null ;;
  }

  join: dim_prodct_tran {
    from: dim_prodct
    type: left_outer
    relationship: many_to_one
    sql_on: ${fact_transctn_rr.nk_hk_dim_prodct} = ${dim_prodct_tran.nk_hk_dim_prodct} AND ${dim_prodct_tran.md_active};;
  }

  join: last_12_months_master_list {
    view_label: ""
    type: left_outer
    relationship: many_to_one
    sql_on: true ;;
  }

  # added the following join to avoid the "view does not exist" error while refering fact_holdng_rr_12_months_master_list in the dashboard.view file.
  # This join is NOT to be used from this explore.
  join: fact_holdng_rr_12_months_master_list {
    view_label: ""
    from: fact_holdng_rr
    type: left_outer
    relationship: one_to_many
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${fact_holdng_rr_12_months_master_list.nk_hk_dim_accnt}
              AND ${dim_user_unnested.nk_hk_dim_regstr_reprsnttv} = ${fact_holdng_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}
              AND ${fact_holdng_rr_12_months_master_list.balance_dt} =  "{{ _user_attributes['latest_holding_date_dev'] }}"
      AND ${last_12_months_master_list.last_12_months_month} = ${fact_holdng_rr_12_months_master_list.balance_dt_month}
      ;;
  }

  join: fact_transctn_rr_12_months_master_list {
    from: fact_transctn_rr
    view_label : ""
    type:  left_outer
    relationship: one_to_many
    sql_on:  ${dim_accnt.nk_hk_dim_accnt} = ${fact_transctn_rr_12_months_master_list.nk_hk_dim_accnt}
      AND ${dim_user_unnested.nk_hk_dim_regstr_reprsnttv}=${fact_transctn_rr_12_months_master_list.nk_hk_dim_regstr_reprsnttv}
      AND ${fact_transctn_rr_12_months_master_list.canclld_transctn} is null
      AND ${fact_transctn_rr_12_months_master_list.trad_dt_date} <=  "{{ _user_attributes['latest_holding_date_dev'] }}"
       AND ${last_12_months_master_list.last_12_months_month} = ${fact_transctn_rr_12_months_master_list.trad_dt_month};;
  }

  join: dim_transctn_cd {
    type:  inner
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr.nk_hk_dim_transctn_cd} = ${dim_transctn_cd.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd.lang_cd} = ${language.lang_pref} ;;
  }

  join: dim_transctn_cd_12_months_master_list {
    from: dim_transctn_cd
    type:  left_outer   #changed join from 'innner' to 'left_outer' since clients were getting filtered in the case of lost client AUA where client is lost but it does not have any transaction associated with it.
    relationship: many_to_one
    sql_on:  ${fact_transctn_rr_12_months_master_list.nk_hk_dim_transctn_cd} = ${dim_transctn_cd_12_months_master_list.nk_hk_dim_transctn_cd} AND ${dim_transctn_cd_12_months_master_list.lang_cd} = ${language.lang_pref} ;;
  }


  join: new_client_recruitment_period{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt.account_number}=${new_client_recruitment_period.account_number} ;;
  }

  join: lost_client_departure_period{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_accnt.account_number}=${lost_client_departure_period.account_number} ;;
  }

  join: new_clients{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_party.nk_hk_dim_party}=${new_clients.nk_hk_dim_party} ;;
  }

  join: lost_clients{
    view_label : ""
    type: left_outer
    relationship: many_to_one
    sql_on: ${dim_party.nk_hk_dim_party}=${lost_clients.nk_hk_dim_party} ;;
  }


  join: fact_holdng_rr_prev_day {  # added to avoid lookml reference error
    type: left_outer
    relationship: one_to_many
    sql_on: true ;;
  }

  join: language {                   # added to avoid lookml reference error
    relationship: one_to_one
    sql_on: true ;;
  }

  join: first_name_first {                   # added to avoid lookml reference error
    relationship: one_to_one
    sql_on: true ;;
  }
  #adding to avoid validation errors
  join: accnts_orphan {
    from: accnts
    type: left_outer
    relationship: one_to_one
    sql_on: ${dim_accnt.nk_hk_dim_accnt} = ${accnts_orphan.hk_accnt_id} ;;
  }

  join: houshld_accnts_orphan {
    from: houshld_accnts
    type: left_outer
    relationship: many_to_one
    sql_on: ${accnts_orphan.hk_accnt_id} = ${houshld_accnts_orphan.hk_accnt_id} ;;
  }

  join: row_limit_index_row_no_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${row_limit_index_row_no_pdt.nk_hk_dim_regstr_reprsnttv} and ${dim_houshld_accnt_pdt.nk_hk_dim_accnt} = ${row_limit_index_row_no_pdt.nk_hk_dim_account};;
  }

  join: row_limit_index_row_no_user_repcd_pdt {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv} = ${row_limit_index_row_no_user_repcd_pdt.nk_hk_dim_regstr_reprsnttv};;
  }
}

explore: incremental_changes_userrepcode_combination {
  view_name: incremental_changes_user_repcode_access

  sql_always_where: ${incremental_changes_user_repcode_access.rep_cds} <> 'SEAA';; # added for 1276440-adjustment-to-firm-reporting
}
