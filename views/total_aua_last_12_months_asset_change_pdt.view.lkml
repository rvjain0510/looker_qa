# This view is created for dashboard_enhancement story [1272928]-Add Additional Tool Tips in Asset Change Graph
view: total_aua_last_12_months_asset_change_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: SELECT  NK_HK_DIM_REGSTR_REPRSNTTV, NK_HK_DIM_ACCNT,
      SUM(CASE WHEN (BALANCE_DT >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
          and BALANCE_DT<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN AUA_CONVERTED_TO_CAD  ELSE NULL END) AS total_aua_12_months,
        sum(case when (case when (extract(month from BALANCE_DT)=12 and
          extract(year from BALANCE_DT)= extract(year from date_sub(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),interval 1 year))) then BALANCE_DT end) = BALANCE_DT then AUA_CONVERTED_TO_CAD ELSE NULL END) total_aua_lyr,
        sum(case when BALANCE_DT =  "{{ _user_attributes['latest_holding_date_dev'] }}" then AUA_CONVERTED_TO_CAD end) as total_aua_current_month
          FROM `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR`
          WHERE BALANCE_DT IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }})
          OR BALANCE_DT =  "{{ _user_attributes['latest_holding_date_dev'] }}"
          group by 1,2 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: primary_key{
    type: string
    primary_key: yes
    sql: ${nk_hk_dim_accnt}||${nk_hk_dim_regstr_reprsnttv} ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  measure: total_aua_12_months {
    type: sum
    sql: ${TABLE}.total_aua_12_months ;;
    value_format_name: decimal_0
  }

  measure: total_aua_current_month {
    type: sum
    sql: ${TABLE}.total_aua_current_month ;;
    value_format_name: decimal_0
  }

  measure: total_aua_12_months_for_clients {  #Avoiding Symmetric aggregation
    type: number
    sql:coalesce(SUM( ${TABLE}.total_aua_12_months),0) ;;
    value_format_name: decimal_0
  }

  measure: total_aua_current_month_for_clients {  #Avoiding Symmetric aggregation
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: coalesce(SUM(${TABLE}.total_aua_current_month),0) ;;
    value_format_name: decimal_0
  }

  measure: aua_lyr_ytd{
    type: sum
    sql: ${TABLE}.total_aua_lyr ;;
    value_format_name: decimal_0
  }

  measure: aua_change_ytd {  #Avoiding Symmetric aggregation
    type: number
    sql: ${total_aua_current_month}-${aua_lyr_ytd} ;;
    value_format_name: decimal_0
    html: {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
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

  measure: market_variation {  #Avoiding Symmetric aggregation
    type: number
    sql: coalesce(${aua_change_ytd},0) - (coalesce(${fact_transctn_rr.existing_clients_cashflow_ytd_scorecard},0) + coalesce(${fact_transctn_rr.new_clients_cashflow_ytd_scorecard},0) + coalesce(${fact_transctn_rr.lost_clients_cashflow_ytd_scorecard},0)) ;;
    value_format_name: decimal_0
    html: {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
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

  measure: total_aua_current_month_for_clients_wo_coalesce {  #Avoiding Symmetric aggregation
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: SUM(${TABLE}.total_aua_current_month) ;;
    value_format_name: decimal_0
  }

  set: detail {
    fields: [
      nk_hk_dim_regstr_reprsnttv,
      nk_hk_dim_accnt,
      total_aua_12_months
    ]
  }
}
