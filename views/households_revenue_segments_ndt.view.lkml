#This view is created to build age and income segments for households.
view: households_revenue_segments_ndt {

  derived_table: {

    explore_source: ax360_dashboards_revenue {
      column: houshld_id { field: houshlds.houshld_id }
      column: houshld_houshld_name { field: houshlds.houshld_name }
      column: total_12_month_revenue { field: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients_wo_coalesce }
      column: total_12_month_recurring_revenue { field: total_revenue_last_12_months_pdt.total_12_month_recurring_revenue_for_clients }
      #ROA % is above 100 so commenting this field BUG - 1274427
      #column: revenue_on_assets { field: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients }
      column: ytd_revenue { field: total_revenue_last_12_months_pdt.ytd_revenue_for_clients }

      # filters: [dim_accnt.account_status_level_1_without_locale: "Open"]

      bind_filters: {
        to_field: dim_user_rep_cds.rep_cd_with_rep_cd_name
        from_field: dashboard.rep_cd_with_rep_cd_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
        from_field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.team_name
        from_field: filtered_rep_cd_by_rvp_branch_team.team_name
      }

      bind_filters: {
        to_field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
        from_field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      }
    }
  }


  dimension: houshld_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.houshld_id ;;
  }

  dimension: houshld_houshld_name {
    label: "household_name"
    type: string
    sql: ${TABLE}.houshld_houshld_name ;;
    html: <a href="{{link}}&linkType=household&redirect={{ households_revenue_segments_ndt.houshld_id }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; text-align:left; font-weight:600">{{ value }}</p></a>;;
  }

  dimension: total_12_month_revenue {
    label: "Total 12 Month Revenue"
    type: number
    sql: ${TABLE}.total_12_month_revenue ;;
    value_format_name: decimal_0
  }

  dimension: total_12_month_recurring_revenue {
    label: "Recurring Revenue Ratio"
    type: number
    sql: ${TABLE}.total_12_month_recurring_revenue ;;
    value_format_name: decimal_0
  }

  dimension: revenue_tier {
    label: "revenue_segment" #this label is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
          WHEN ${total_12_month_revenue}  < 500 THEN '{{ _localization['below_500_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 500 AND ${total_12_month_revenue}  < 1000 THEN '{{ _localization['500_to_999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 1000 AND ${total_12_month_revenue}  < 2500 THEN '{{ _localization['1000_to_2499_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 2500 AND ${total_12_month_revenue}  < 5000 THEN '{{ _localization['2500_to_4999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 5000 AND ${total_12_month_revenue}  < 10000 THEN '{{ _localization['5k_to_9999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 10000 AND ${total_12_month_revenue}  < 20000 THEN '{{ _localization['10k_to_19999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 20000 THEN '{{ _localization['20k_or_above_revenue_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }

  dimension: revenue_segment {
    label: "revenue_segment_tier" #this label is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
          WHEN ${total_12_month_revenue}  < 500 THEN '{{ _localization['below_500_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 500 AND ${total_12_month_revenue}  < 1000 THEN '{{ _localization['500_to_999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 1000 AND ${total_12_month_revenue}  < 2500 THEN '{{ _localization['1000_to_2499_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 2500 AND ${total_12_month_revenue}  < 5000 THEN '{{ _localization['2500_to_4999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 5000 AND ${total_12_month_revenue}  < 10000 THEN '{{ _localization['5k_to_9999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 10000 AND ${total_12_month_revenue}  < 20000 THEN '{{ _localization['10k_to_19999_revenue_seg'] }}'
          WHEN ${total_12_month_revenue}  >= 20000 THEN '{{ _localization['20k_or_above_revenue_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }


  measure: households_total_12_month_revenue {
    label: "12_month_revenue_de"
    type: sum
    sql: ${total_12_month_revenue} ;;
    value_format_name: decimal_0
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: households_total_12_month_recurring_revenue {
    type: sum
    sql: ${total_12_month_recurring_revenue} ;;
    value_format_name: decimal_0
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: households_recurring_revenue_ratio {
    label: "recurring_revenue_ratio"
    type: number
    sql: coalesce(${households_total_12_month_recurring_revenue}/ nullif(${households_total_12_month_revenue},0),0) ;;
    value_format_name: percent_2
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: median_household_revenue {
    type: median
    sql: coalesce(${total_12_month_revenue},0) ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

  measure: avg_aua_for_households {
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${total_aua_last_12_months_pdt.total_aua_12_months_for_clients}/12 ;;
  }

  measure: households_revenue_on_assets {
    label: "revenue_on_assets"
    type: number
    #sql: ${TABLE}.revenue_on_assets ;;
    sql: ${households_total_12_month_revenue}/nullif(${avg_aua_for_households},0) ;;
    value_format_name: percent_2
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: ytd_revenue {
    label: "ytd_revenue_field"
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


  measure: total_households {
    label: "Total Households"
    type: count_distinct
    sql: ${houshld_id} ;;
  }

#Revenue open account filter
  measure: total_households_rs {
    label: "Total Households"
    type: count_distinct
    sql: case when ${dim_accnt.account_status_level_1_without_locale} = "Open" then ${houshld_id} end ;;
    link: {
      label: "household_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_households_rs_sample._link }}&sorts=households_revenue_segments_ndt.households_total_12_month_revenue+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
  }

  measure: total_households_rs_sample {  #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [houshld_houshld_name,households_total_12_month_revenue,households_total_12_month_revenue,households_recurring_revenue_ratio,households_revenue_on_assets,ytd_revenue,dashboard.total_aua_current_month_sample]
  }
}
