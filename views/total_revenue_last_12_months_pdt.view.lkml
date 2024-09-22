
view: total_revenue_last_12_months_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: SELECT
          fact_revn_rr.NK_HK_DIM_ACCNT  AS nk_hk_dim_accnt,
          fact_revn_rr.NK_HK_DIM_REGSTR_REPRSNTTV  AS nk_hk_dim_regstr_reprsnttv,

      SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN fact_revn_rr.REVENUE_AMOUNT_CAD  ELSE NULL END) AS total_12_month_revenue,

      (SUM(CASE WHEN ( DATE_DIFF( "{{ _user_attributes['latest_holding_date_dev'] }}", fact_revn_rr.TRANSACTION_DATE,year)=0) AND  ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN fact_revn_rr.REVENUE_AMOUNT_CAD  ELSE NULL END)) AS ytd_revenue,

      ifnull(COALESCE(SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) AND  (ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Fixed fees" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Managed" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Frais Fixes" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Gestion discrétionnaire") then   fact_revn_rr.REVENUE_AMOUNT_CAD  else 0 END), 0) + COALESCE(SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) AND  (ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Trailer fees and GIC" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Commissions de suivi et de CPG") then   fact_revn_rr.REVENUE_AMOUNT_CAD  else 0 end ), 0) / nullif(COALESCE(SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN fact_revn_rr.REVENUE_AMOUNT_CAD  ELSE NULL END), 0), 0), 0) AS recurring_revenue_ratio,

      COALESCE(SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) AND  (ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Fixed fees" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Managed" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Frais Fixes" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Gestion discrétionnaire") then   fact_revn_rr.REVENUE_AMOUNT_CAD  else 0 END), 0) + COALESCE(SUM(CASE WHEN ( fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) AND  (ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Trailer fees and GIC" or  ref_revenue_type_desc.`Revenue Type Desc ENG`  = "Commissions de suivi et de CPG") then   fact_revn_rr.REVENUE_AMOUNT_CAD  else 0 end ), 0) AS total_12_month_recurring_revenue
      FROM  `@{bq_project_id}.@{bq_dataset_name}.FACT_REVN_RR`  AS fact_revn_rr

      LEFT JOIN `@{bq_project_id}.@{dv_dataset_name}.REF_REVENUE_TYPE_DESC`  AS ref_revenue_type_desc ON fact_revn_rr.REVENUE_SOURCE_CODE = ref_revenue_type_desc.SOURCECODE
      AND (case when fact_revn_rr.REVENUE_SOURCE_CODE='MNL' then case when fact_revn_rr.ENTRY_TYPE_CD='INSREV'
      then fact_revn_rr.ENTRY_TYPE_CD = ref_revenue_type_desc.ENTRY_TYPE  else ref_revenue_type_desc.ENTRY_TYPE != 'INSREV' end else 1=1 end )

      GROUP BY
      1,
      2
      ORDER BY
      3 DESC ;;
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

  dimension: nk_hk_dim_accnt {
    type: number
    sql: ${TABLE}.nk_hk_dim_accnt ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.nk_hk_dim_regstr_reprsnttv ;;
  }

  measure: total_12_month_revenue {
    label: "12_month_revenue" #this label is localized
    type: sum
    sql: ${TABLE}.total_12_month_revenue ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: ytd_revenue {
    label: "ytd_revenue_field" #this label is localized
    type: sum
    sql: ${TABLE}.ytd_revenue ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

   measure: recurring_revenue_ratio {
    type: number
    sql: coalesce(${total_12_month_recurring_revenue}/nullif(${total_12_month_revenue},0),0) ;;
    value_format_name: percent_2
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }


  measure: total_12_month_recurring_revenue {
    type: sum
    sql: ${TABLE}.total_12_month_recurring_revenue ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: avg_aua {
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${total_aua_last_12_months_pdt.total_aua_12_months}/12 ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: revenue_on_assets {
    label: "return_on_assets_ratio" #this label is localized
    type: number
    sql: ifnull(${total_12_month_revenue}/nullif(${avg_aua},0),0) ;;
    value_format_name: percent_2
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: revenue_pct {
    type: percent_of_total
    sql: ${total_12_month_revenue} ;;
    value_format: "0.00\%"
  }

  measure: total_12_month_revenue_for_clients {  #Avoiding Symmetric aggregation
    label: "12_month_revenue" #this label is localized
    type: number
    sql: coalesce(SUM(${TABLE}.total_12_month_revenue),0) ;;
    value_format: "#,##0"
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: total_12_month_revenue_for_clients_wo_coalesce {  #Avoiding Symmetric aggregation
    label: "12_month_revenue" #this label is localized
    type: number
    sql: SUM(${TABLE}.total_12_month_revenue) ;;
    value_format: "#,##0"
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: total_12_month_recurring_revenue_for_clients {  #Avoiding Symmetric aggregation
    type: number
    value_format: "#,##0"
    sql: coalesce(SUM(${TABLE}.total_12_month_recurring_revenue),0);;
  }

  measure: recurring_revenue_ratio_12_month_for_clients {   #Avoiding Symmetric aggregation
    label: "recurring_revenue_ratio" #this label is localized
    type: number
    sql:  ifnull(${total_12_month_recurring_revenue_for_clients} / nullif(${total_12_month_revenue_for_clients},0),0) ;;
    value_format_name: percent_2
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: ytd_revenue_for_clients {  #Avoiding Symmetric aggregation
    label: "ytd_revenue_field" #this label is localized
    type: number
    sql: coalesce(sum(${TABLE}.ytd_revenue),0) ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: avg_aua_for_clients {   #Avoiding Symmetric aggregation
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${total_aua_last_12_months_pdt.total_aua_12_months_for_clients}/12 ;;
  }

  measure: revenue_on_assets_for_clients {  #Avoiding Symmetric aggregation
    label: "return_on_assets_ratio" #this label is localized
    type: number
    sql: ifnull(${total_12_month_revenue_for_clients}/nullif(${avg_aua_for_clients},0),0) ;;
    value_format_name: percent_2
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  set: detail {
    fields: [
      nk_hk_dim_accnt,
      nk_hk_dim_regstr_reprsnttv,
      total_12_month_revenue,
      ytd_revenue,
      recurring_revenue_ratio,
      total_12_month_recurring_revenue
    ]
  }
}