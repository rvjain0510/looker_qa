# The name of this view in Looker is "Fact Revn Rr"
view: fact_revn_rr {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REVN_RR` ;;
  # drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.

  dimension: accurate_indicator {
    type: yesno
    sql: ${TABLE}.ACCURATE_INDICATOR ;;
  }

  dimension: affect_gross_commission_indicator {
    type: yesno
    sql: ${TABLE}.AFFECT_GROSS_COMMISSION_INDICATOR ;;
  }

  dimension: cancel_indicator {
    type: yesno
    sql: ${TABLE}.CANCEL_INDICATOR ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.CURRENCY ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.DESCRIPTION ;;
  }

  dimension: entry_type_cd {
    type: string
    sql: ${TABLE}.ENTRY_TYPE_CD ;;
  }

  dimension: exchange_rate {
    type: number
    sql: ${TABLE}.EXCHANGE_RATE ;;
  }

  dimension: ext_trans_id {
    type: string
    sql: ${TABLE}.EXT_TRANS_ID ;;
  }

  dimension: management_company_code {
    type: string
    sql: ${TABLE}.MANAGEMENT_COMPANY_CODE ;;
  }

  dimension: market {
    type: string
    sql: ${TABLE}.MARKET ;;
  }

  dimension: md_creatn_log_id {
    type: string
    sql: ${TABLE}.MD_CREATN_LOG_ID ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: md {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MD_DATE ;;
  }

  dimension: md_src_systm {
    type: string
    sql: ${TABLE}.MD_SRC_SYSTM ;;
  }

  dimension: net_commission {
    type: number
    sql: ${TABLE}.NET_COMMISSION ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_product {
    type: number
    sql: ${TABLE}.NK_HK_DIM_PRODUCT ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: override_indicator {
    type: yesno
    sql: ${TABLE}.OVERRIDE_INDICATOR ;;
  }

  dimension: payout_rate {
    type: number
    sql: ${TABLE}.PAYOUT_RATE ;;
  }

  dimension_group: process {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PROCESS_DATE ;;
  }

  dimension: quantity {
    type: number
    sql: ${TABLE}.QUANTITY ;;
  }

  dimension: revenue_amount {
    type: number
    sql: ${TABLE}.REVENUE_AMOUNT ;;
  }

  dimension: revenue_amount_cad {
    type: number
    sql: ${TABLE}.REVENUE_AMOUNT_CAD ;;
  }

  dimension: revenue_source_code {
    type: string
    sql: ${TABLE}.REVENUE_SOURCE_CODE ;;
  }

  dimension: revenue_type_code {
    type: string
    sql: ${ref_revenue_type_desc.revenue_type_code} ;;
   }

  dimension: revenue_type_desc {
    type: string
    sql: {% if _user_attributes['locale'] == 'en' %} ${ref_revenue_type_desc.revenue_type_desc_eng}
          {% elsif _user_attributes['locale'] == 'fr_FR' %} ${ref_revenue_type_desc.revenue_type_desc_fra}
          {% endif %};;
  }

  dimension: revno {
    type: number
    sql: ${TABLE}.REVNO ;;
  }

  dimension: share_indicator {
    type: yesno
    sql: ${TABLE}.SHARE_INDICATOR ;;
  }

  dimension: sk_dim_accnt {
    type: number
    sql: ${TABLE}.SK_DIM_ACCNT ;;
  }

  dimension: sk_dim_prodct {
    type: number
    sql: ${TABLE}.SK_DIM_PRODCT ;;
  }

  dimension: sk_dim_regstr_reprsnttv {
    type: number
    sql: ${TABLE}.SK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: ticket_number {
    type: string
    sql: ${TABLE}.TICKET_NUMBER ;;
  }

  dimension_group: transaction {
    type: time
    timeframes: [raw, date, week, month, quarter, year, month_name]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.TRANSACTION_DATE ;;
  }

  dimension_group: last_12_months_trend { # used this measure in 'AUA Trend' look to show last 12 months including current month('Month to Date')
    type: time
    #description: "BALANCE_DT"
    timeframes: [raw, date, week, month, quarter, year,month_num,month_name]
    convert_tz: no
    datatype: date
    #hidden: yes
    sql:  case when ${transaction_date} >=  DATE_TRUNC( DATE_SUB( ${last_holding_date.last_update_date}, INTERVAL 11 month), MONTH) then ${transaction_date} end ;;
  }

  dimension: last_12_month_with_mtd { # used this measure in 'AUA Trend' look to show last 12 months and current month as 'Month to Date'
    #hidden: yes
    label: "month" #this is localized
    sql: CASE WHEN ${last_12_months_trend_month}= (FORMAT_DATE('%Y-%m', ${last_holding_date.last_update_date} ))  THEN '{{ _localization['month_to_date'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="January" THEN '{{ _localization['january'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="February" THEN '{{ _localization['february'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="March" THEN '{{ _localization['march'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="April" THEN '{{ _localization['april'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="May" THEN '{{ _localization['may'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="June" THEN '{{ _localization['june'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="July" THEN '{{ _localization['july'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="August" THEN '{{ _localization['august'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="September" THEN '{{ _localization['september'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="October" THEN '{{ _localization['october'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="November" THEN '{{ _localization['november'] }}'
              WHEN cast(format_date('%B',${last_12_months_trend_date}) as string) ="December" THEN '{{ _localization['december'] }}'
              END ;;
    order_by_field: last_12_months_trend_month
  }

  dimension: transaction_fee {
    type: number
    sql: ${TABLE}.TRANSACTION_FEE ;;
  }

  dimension: transaction_id {
    type: number
    sql: ${TABLE}.TRANSACTION_ID ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }

  dimension: is_last_12_month {
    type: yesno
    sql:  ${transaction_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and ${transaction_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ;;
  }

  dimension: ytd_flag { #Year to date flag
    hidden: yes
    type: yesno
    sql: DATE_DIFF( ${last_holding_date.last_update_date}, ${transaction_date},year)=0;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_revenue {
    type: sum
    sql: ${revenue_amount_cad} ;;
  }

  measure: total_12_month_revenue {
    label: "12-Month Revenue"
    type: sum
    sql: ${revenue_amount_cad} ;;
    filters: [is_last_12_month: "Yes"]
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
    value_format_name: decimal_0
  }

  measure: revenue_pct {
    type: percent_of_total
    sql: ${total_12_month_revenue} ;;
    value_format: "0.00\%"
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: ytd_revenue {
    label: "YTD Revenue"
    type: sum
    sql: ${revenue_amount_cad} ;;
    filters: [ytd_flag: "Yes"]
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
    value_format_name: decimal_0
  }

#   measure: total_12_month_revenue_drill {
#     type: number
#     sql: ${total_12_month_revenue} ;;
#     value_format_name: decimal_0
#     link: {
#       label: "Revenue Details"  #this label is localized
#       url: "
#       {% assign vis_config = '{
# \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":true,\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"circle\",\"show_value_labels\":false,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"y_axes\":[{\"label\":\"Total Revenue($)\",\"orientation\":\"left\",\"series\":[{\"axisId\":\"fact_revn_rr.total_12_month_commission_revenue\",\"id\":\"fact_revn_rr.total_12_month_commission_revenue\",\"name\":\"Commission-based Revenue\"},{\"axisId\":\"fact_revn_rr.total_12_month_feebased_revenue\",\"id\":\"fact_revn_rr.total_12_month_feebased_revenue\",\"name\":\"Fee-based Revenue\"},{\"axisId\":\"fact_revn_rr.total_12_month_managed_revenue\",\"id\":\"fact_revn_rr.total_12_month_managed_revenue\",\"name\":\"Managed Revenue\"},{\"axisId\":\"fact_revn_rr.total_12_month_sma_revenue\",\"id\":\"fact_revn_rr.total_12_month_sma_revenue\",\"name\":\"SMA Revenue\"},{\"axisId\":\"fact_revn_rr.total_12_month_uma_revenue\",\"id\":\"fact_revn_rr.total_12_month_uma_revenue\",\"name\":\"UMA Revenue\"}],\"showLabels\":true,\"showValues\":true,\"unpinAxis\":false,\"tickDensity\":\"default\",\"tickDensityCustom\":5,\"type\":\"linear\"}],\"x_axis_label\":\"Month\",\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"series_colors\":{\"fact_revn_rr.total_12_month_feebased_revenue\":\"#00A873\",\"fact_revn_rr.total_12_month_managed_revenue\":\"#C78500\",\"fact_revn_rr.total_12_month_sma_revenue\":\"#8A3EB0\",\"fact_revn_rr.total_12_month_uma_revenue\":\"#CBD0E1\"},\"x_axis_datetime_label\":\"%B\",\"type\":\"looker_line\",\"defaults_version\":1      }' %}
#       {{ revenue_by_program_type_drill_sample._link }}&sorts=transaction_month+asc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
#     }
#     html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
#   }

#   measure: revenue_by_program_type_drill_sample {  # Referred it in above measure
#     hidden: yes
#     type: count_distinct
#     sql: 0;;
#     drill_fields: [transaction_month,total_12_month_commission_revenue,total_12_month_feebased_revenue,total_12_month_managed_revenue,total_12_month_sma_revenue,total_12_month_uma_revenue]
#     }



  measure: total_12_month_commission_revenue {
    label: "Commission-based"
    type: sum
    sql: case when ${dim_accnt_locale.accnt_progrm_tp__name} = "Commission-based" OR  ${dim_accnt_locale.accnt_progrm_tp__name} = "Comptes à commissions"
         then  coalesce(${revenue_amount_cad},0) else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }

  measure: total_12_month_feebased_revenue {
    label: "Fee-based"
    type: sum
    sql: case when ${dim_accnt_locale.accnt_progrm_tp__name} = "Fee-based" OR ${dim_accnt_locale.accnt_progrm_tp__name} = "Comptes à gestion Unifiée Élite"
        then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }

  measure: total_12_month_managed_revenue {
    label: "Managed"
    type: sum
    sql: case when ${dim_accnt_locale.accnt_progrm_tp__name} = "Managed" OR ${dim_accnt_locale.accnt_progrm_tp__name} = "Comptes à honoraires"
          then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }

  measure: total_12_month_sma_revenue {
    label: "SMA"
    type: sum
    sql: case when ${dim_accnt_locale.accnt_progrm_tp__name} = "SMA" OR ${dim_accnt_locale.accnt_progrm_tp__name} = "Comptes gérés séparément"
        then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }

  measure: total_12_month_uma_revenue {
    label: "UMA"
    type: sum
    sql: case when ${dim_accnt_locale.accnt_progrm_tp__name} = "UMA" OR ${dim_accnt_locale.accnt_progrm_tp__name} = "Gérés"
        then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }

  measure: avg_aua {
    type: number
    sql: ${total_aua_last_12_months_pdt.total_aua_12_months}/12 ;;
  }

  measure: revenue_on_assets {
    type: number
    sql: ifnull(${total_12_month_revenue}/nullif(${avg_aua},0),0) ;;
    html:
    <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
    <p style=" width: 70%; font-size: 24px; font-style: normal; font-weight: 700;color:#525870; font-size: 24px;" >{{rendered_value}}<p>
    </div>;;
    value_format_name: percent_2
  }

  measure: revenue_on_assets_wo_html {
    label: "Revenue on Assets"
    type: number
    sql: ifnull(${total_12_month_revenue}/nullif(${avg_aua},0) ,0) ;;
    value_format_name: percent_2
  }

  # measure: revenue_on_assets_for_segment_drill {
  #   label: "Revenue on Assets"
  #   type: number
  #   sql: ifnull(${total_12_month_revenue}/nullif(${total_aua_last_12_months_pdt_at_party_ndt.total_aua_last_12_month_including_current}/12,0) ,0) ;;
  #   value_format_name: percent_2
  # }
  measure: total_12_month_feebased_managed_revenue {
    type: sum
    sql: case when ${revenue_type_desc} = "Fixed fees" or ${revenue_type_desc} = "Managed" or ${revenue_type_desc} = "Frais Fixes" or ${revenue_type_desc} = "Gestion discrétionnaire" then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }
  measure: total_12_month_trailers_revenue {
    type: sum
    sql: case when ${revenue_type_desc} = "Trailer fees and GIC" or ${revenue_type_desc} = "Commissions de suivi et de CPG" then  ${revenue_amount_cad} else 0 end;;
    filters: [is_last_12_month: "Yes"]
    value_format: "#,##0"
  }
  measure: total_12_month_recurring_revenue {
    type: number
    sql: ${total_12_month_feebased_managed_revenue} + ${total_12_month_trailers_revenue} ;;
    value_format: "#,##0"
  }

  measure: recurring_revenue_ratio_12_month {
    type: number
    sql:  ifnull(${total_12_month_recurring_revenue} / nullif(${total_12_month_revenue},0),0) ;;
    html:
    <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
    <p style=" width: 70%; font-size: 24px; font-style: normal; font-weight: 700;color:#525870; font-size: 24px;" >{{rendered_value}}<p>
    </div>;;
    value_format_name: percent_2
  }

  measure: recurring_revenue_ratio_12_month_wo_html {
    label: "Recurring Revenue Ratio"
    type: number
    sql:  ifnull(${total_12_month_recurring_revenue} / nullif(${total_12_month_revenue},0),0) ;;
    value_format_name: percent_2
  }

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.


  measure: total_revenue_amount {
    type: sum
    sql: ${revenue_amount} ;;  }
  measure: average_revenue_amount {
    type: average
    sql: ${revenue_amount} ;;  }


  measure: total_12_month_revenue_for_clients {  #Total AUA. Created separately since we need it without symmetric aggregation in client segmentation looks.
    type: number
    sql: sum(case when ${is_last_12_month} then ${fact_revn_rr.revenue_amount_cad} end );;
    value_format_name: decimal_0
  }
}