view: dashboard_revenue {
derived_table:  {
  sql:
     Select 1 as dummy;;
}

  dimension: rep_cd_with_rep_cd_name {
    type: string
    label: "rep_cd"
    sql: ${dim_user_rep_cds.rep_cd_with_rep_cd_name} ;;
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;
  }


dimension: allocation_name_locale {
  label: "asset_type" #this lable is localized
  hidden: no
  type: string
  sql: CASE WHEN ${fact_allctn_holdng.allocation_code} ='CASH' THEN
              CASE WHEN ${fact_allctn_holdng.allocation_aua_dim}>0 THEN
              CASE WHEN ${fact_allctn_holdng.lang_cd} ='en' THEN "Cash and Equivalents" ELSE "Encaisse et quasi-espèces" END
              ELSE
              CASE WHEN ${fact_allctn_holdng.lang_cd}='en' THEN "Debit Balance and Owed Investments" ELSE "Solde débiteur et investissements dûs" END END
              ELSE ${fact_allctn_holdng.allocation_name} END;;
}

  measure: total_12_month_revenue {
    type: number
    sql: ${fact_revn_rr_12_months_master_list.total_12_month_revenue} ;;
    value_format_name: decimal_0
  }

measure: total_aua_12_month_including_current_for_segments {   #Created for revenue client segmentation
  hidden: no
  # label: "total_market_value_cad" #this label is localized
  type: number
  sql: ${fact_holdng_rr.total_aua_last_12_month_including_current} ;;
  value_format_name: decimal_0
  html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
}


measure: total_aua_current_month_sample {
  label: "total_market_value_cad" #this label is localized
  hidden: yes
  type: number
  sql: coalesce(${fact_holdng_rr.total_aua_for_clients},0) ;;
  value_format_name: decimal_0
  html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
}


dimension: client_name {
  label: "client"             #this label is localized
  type: string
  sql: ${dim_party.party_name} ;;
  html: <a href="{{link}}&redirect={{ dim_party.nk_hk_dim_party }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; text-align:left; font-weight:600">{{ value }}</p></a>;;
}

dimension: filtered_accnt_progrm_tp__value {
  label:  "program_type"                #this is localized
  type: string
  sql: ${dim_accnt_locale.accnt_progrm_tp__name} ;;
}

dimension: rep_cd {
  type: string
  label: "rep_cd"
  sql: ${dim_user_rep_cds.rep_cd} ;;
  html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;
}

dimension: rep_cd_hist {
  type: string
  label: "rep_cd"
  sql: ${dim_user_rep_cds.rep_cd} ;;
}

dimension: account_status_level_1 {
  label: "account_status"               #this label is localized
  type: string
  sql: ${dim_accnt.account_status_level_1};;
}

measure:  at_least_one_account_open{
  label: "open_account" #this_is_localized
  type: yesno
  hidden: no
  sql: case when max(${account_status_level_1}) = "{{ _localization['Open'] }}" then true
    else false end;;
}

measure: total_clients_pct_drill_for_segments_nohtml {     # Added link for custom drill viz. This measure is been used in Clients segmentation looks of 'Clients' dashboard
  hidden: no
  type: number
  sql:${dim_party.total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0);;
  value_format_name: percent_2
  link: {
    label: "client_details"
    url: "
    {% assign vis_config = '{
    \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
    }' %}
    {{ total_clients_pct_drill_for_segments_nohtml_sample._link }}&sorts=total_revenue_party_ndt.clients_total_12_month_revenue+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
  }
  html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
}

measure: total_clients_pct_drill_for_segments_nohtml_sample {  #referred in above measure
  hidden: yes
  type: count_distinct
  sql: 0;;
  drill_fields: [total_revenue_party_ndt.client_name,total_aua_current_month_sample,total_revenue_party_ndt.clients_total_12_month_revenue,total_revenue_party_ndt.clients_recurring_revenue_ratio,total_revenue_party_ndt.clients_revenue_on_assets_for_drill,total_revenue_party_ndt.ytd_revenue,dashboard.at_least_one_account_open]
}

measure: total_aua_current_month_for_segments {    #Created for revenue client segmentation
  hidden: no
  # label: "total_market_value_cad" #this label is localized
  type: number
  sql: ${fact_holdng_rr.total_aua_current_month} ;;
  value_format_name: decimal_0
  html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;

}

dimension: income_tier {
  label: "income_segment"              #this label is localized
  type: string
  sql:  CASE
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  < 25000 THEN   '{{ _localization['below_25k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 25000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 50000 THEN '{{ _localization['25k_to_49k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 50000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 100000 THEN '{{ _localization['50k_to_99k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 100000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 250000 THEN '{{ _localization['100k_to_249k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 250000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 500000 THEN '{{ _localization['250k_to_499k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 500000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 1000000 THEN '{{ _localization['500k_to_999k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 1000000 THEN '{{ _localization['1m_or_above_income_seg'] }}'
          ELSE   '{{ _localization['not_available'] }}'
          END ;;
}

dimension: age_tier {
  label: "age_segment"                 #this label is localized
  type: string
  sql:  CASE
          WHEN ${dim_party.age}  < 18 AND ${dim_party.age}  > 0  THEN   '{{ _localization['below_18'] }}'
          WHEN ${dim_party.age}  >= 18 AND ${dim_party.age}  < 30 THEN '{{ _localization['18_to_29'] }}'
          WHEN ${dim_party.age}  >= 30 AND ${dim_party.age}  < 40 THEN '{{ _localization['30_to_39'] }}'
          WHEN ${dim_party.age}  >= 40 AND ${dim_party.age}  < 50 THEN '{{ _localization['40_to_49'] }}'
          WHEN ${dim_party.age}  >= 50 AND ${dim_party.age}  < 60 THEN '{{ _localization['50_to_59'] }}'
          WHEN ${dim_party.age}  >= 60 AND ${dim_party.age}  < 65 THEN '{{ _localization['60_to_64'] }}'
          WHEN ${dim_party.age}  >= 65 AND ${dim_party.age}  < 70 THEN '{{ _localization['65_to_69'] }}'
          WHEN ${dim_party.age}  >= 70 THEN '{{ _localization['70_or_above'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
}

measure: active_household_count {     #HTML formatting is been applied
  label: "Total Active Household"      #this label is localized
  type: number
  sql: ${houshlds.total_household_count} ;;
  html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
}




##################################### FACT_REVN_RR ################################################

measure: total_aua_pct_for_revenue_segments {
  label: "Total AUA% (Segments)"
  type: number
  sql:coalesce( ${total_aua_12_month_including_current_for_segments} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0);;
  value_format_name: percent_2
}

measure: average_revenue_per_active_clients {       #added custom value format
  type: number
  sql: coalesce(round(${total_revenue_at_account_ndt.total_12_months_revenue}/nullif( ${dim_party.total_clients},0),0),0) ;;
  # sql: coalesce (sum(case when ${fact_holdng_rr.balance_dt_date}=${last_holding_date.last_update_date} then ${fact_holdng_rr.aua_converted_to_cad_dim} end )/nullif(count(distinct ${dim_party.party_id}),0),0) ;;
  value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
}

measure: total_12_month_revenue_for_pgrm_tp_trend {
  label: "12_month_revenue_revenue_trend"
  type: number
  sql: ${fact_revn_rr.total_12_month_revenue} ;;
  value_format_name: decimal_0
}


measure: average_revenue_title {
  type: string
  sql: '{{ _localization['average_revenue_title'] }}' ;;
}

measure: average_client_revenue_multi_value {            #HTML formatting has been applied. Used this measure in 'Total Clients' and 'New Clients' single value tile of 'CLients' dashboard
  label: "Client"
  hidden: no
  type: number
  sql: ${average_revenue_per_active_clients} ;;
  value_format_name: decimal_0
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}

measure: average_revenue_per_active_houshold {   #added custom value format
  type: number
  sql: coalesce(round(${total_revenue_at_account_ndt.total_12_months_revenue}/nullif(${active_household_count_revenue},0),0),0);;
  value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
}

measure: average_household_revenue_multi_value {           #HTML formatting is been applied
  label: "Household"
  hidden: no
  description: "Total Household (Multi value)"
  type: number
  sql: ${average_revenue_per_active_houshold} ;;
  value_format_name: decimal_0
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}


measure: total_12_month_revenue_multi_value {
  label: "rolling_12_month"
  type: number
  sql: ${total_revenue_last_12_months_pdt.total_12_month_revenue} ;;
  value_format_name: decimal_0
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}

measure: ytd_revenue_multi_value {
  label: "ytd"
  type: number
  sql: ${total_revenue_last_12_months_pdt.ytd_revenue} ;;
  value_format_name: decimal_0
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}

measure: revenue_on_assets_multi_value {
  type: number
  sql: ${total_revenue_last_12_months_pdt.revenue_on_assets} ;;
  value_format_name: percent_2
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}

measure: recurring_revenue_ratio_multi_value {
  type: number
  sql: ${fact_revn_rr.recurring_revenue_ratio_12_month} ;;
  value_format_name: percent_2
  html:
          {% if value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
}

  measure: active_household_count_revenue {     #HTML formatting is been applied
    label: "Total Active Household"      #this label is localized
    type: number
    sql: ${houshlds_revenue.total_household_count} ;;
    html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
  }


#### Quantiphi code ends here

}
