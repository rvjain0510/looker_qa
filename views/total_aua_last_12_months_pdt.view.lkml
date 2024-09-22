view: total_aua_last_12_months_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: SELECT  NK_HK_DIM_REGSTR_REPRSNTTV, NK_HK_DIM_ACCNT,
      SUM(CASE WHEN (BALANCE_DT >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
          and BALANCE_DT<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN AUA_CONVERTED_TO_CAD  ELSE NULL END) AS total_aua_12_months,
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