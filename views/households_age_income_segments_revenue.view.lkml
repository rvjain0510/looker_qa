view: households_age_income_segments_revenue {
#This view is created to build age and income segments for households.

  derived_table: {

    sql: select houshld_id, houshld_name as houshld_houshld_name, sum(current_party_approx_annual_income) as total_household_income,
      avg(age) as avg_household_age
      from ${party_age_income_by_household_ndt_revenue.SQL_TABLE_NAME}
      group by 1,2 ;;
  }

  dimension: houshld_id {
    label: "ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.houshld_id ;;
  }

  dimension: houshld_houshld_name {
    label: "household" #this is localized
    type: string
    sql: ${TABLE}.houshld_houshld_name ;;
    html: <a href="{{link}}&linkType=household&redirect={{ households_age_income_segments.houshld_id }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; text-align:left; font-weight:600">{{ value }}</p></a>;;

  }

  dimension: total_household_income {
    label: "Income"
    type: number
    sql: ${TABLE}.total_household_income ;;
  }

  dimension: avg_household_age {
    label: "Age"
    type: number
    sql: ${TABLE}.avg_household_age ;;
  }

  dimension: age_tier {
    label: "age_segment" #this is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
        WHEN ${avg_household_age}  < 18 AND ${avg_household_age}  > 0 THEN   '{{ _localization['below_18'] }}'
        WHEN ${avg_household_age}  >= 18 AND ${avg_household_age}  < 30 THEN  '{{ _localization['18_to_29'] }}'
        WHEN ${avg_household_age}  >= 30 AND ${avg_household_age}  < 40 THEN '{{ _localization['30_to_39'] }}'
        WHEN ${avg_household_age}  >= 40 AND ${avg_household_age}  < 50 THEN '{{ _localization['40_to_49'] }}'
        WHEN ${avg_household_age}  >= 50 AND ${avg_household_age}  < 60 THEN '{{ _localization['50_to_59'] }}'
        WHEN ${avg_household_age}  >= 60 AND ${avg_household_age}  < 65 THEN '{{ _localization['60_to_64'] }}'
        WHEN ${avg_household_age}  >= 65 AND ${avg_household_age}  < 70 THEN '{{ _localization['65_to_69'] }}'
        WHEN ${avg_household_age}  >= 70 THEN '{{ _localization['70_or_above'] }}'
        ELSE  '{{ _localization['not_available'] }}'
        END ;;
  }

  dimension: income_tier {
    label: "income_segment" #this is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
        WHEN ${total_household_income}  > 0 AND ${total_household_income}  < 25000 THEN  '{{ _localization['below_25k_income_seg'] }}'
        WHEN ${total_household_income}  >= 25000 AND ${total_household_income}  < 50000 THEN '{{ _localization['25k_to_49k_income_seg'] }}'
        WHEN ${total_household_income}  >= 50000 AND ${total_household_income}  < 100000 THEN '{{ _localization['50k_to_99k_income_seg'] }}'
        WHEN ${total_household_income}  >= 100000 AND ${total_household_income}  < 250000 THEN '{{ _localization['100k_to_249k_income_seg'] }}'
        WHEN ${total_household_income}  >= 250000 AND ${total_household_income}  < 500000 THEN '{{ _localization['250k_to_499k_income_seg'] }}'
        WHEN ${total_household_income}  >= 500000 AND ${total_household_income}  < 1000000 THEN '{{ _localization['500k_to_999k_income_seg'] }}'
        WHEN ${total_household_income}  >= 1000000 THEN '{{ _localization['1m_or_above_income_seg'] }}'
        ELSE  '{{ _localization['not_available'] }}'
        END ;;
  }


  measure: total_households_count {
    type: count_distinct
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql: case when ${dim_accnt.account_status_level_1_without_locale}='Open' then ${houshld_id} end ;;
  }

  measure: avg_age {
    label: "Average Age"
    type: average
    sql: (${TABLE}.avg_household_age) ;;
    value_format_name: decimal_0
  }

  measure: average_household_age {
    label: "average_household_age"
    type: string
    sql: coalesce(cast(round(${avg_age}) as string), "{{ _localization['not_available'] }}" );;
  }

  measure: households_pct_drill {
    type: number
    sql: coalesce( ${total_households_count}/nullif(${total_household_for_segments_ndt.total_no_households} ,0),0) ;;
    value_format_name: percent_2
    link: {
      label: "household_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
      }' %}
      {{ households_age_income_segments.total_household_pct_drill_for_segments_sample._link }}&sorts=households_aua_segments.households_aua+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;
  }

  measure: total_household_pct_drill_for_segments_sample {
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [households_age_income_segments.houshld_houshld_name,households_aua_segments.households_aua,dashboard.at_least_one_account_open]
  }

  measure: households_pct_for_revenue_drill {  ## Created this for Revenue segmentation
    type: number
    sql: coalesce( ${total_households_count}/nullif(${total_household_revenue_for_segments_ndt.total_no_households} ,0),0) ;;
    value_format_name: percent_2
    link: {
      label: "household_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ households_age_income_segments.total_household_pct_drill_for_revenue_segments_sample._link }}&sorts=total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;
  }

  measure: total_household_pct_drill_for_revenue_segments_sample {
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [households_age_income_segments.houshld_houshld_name,total_aua_last_12_months_pdt.total_aua_current_month_for_clients,total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,total_revenue_last_12_months_pdt.revenue_on_assets_for_clients,total_revenue_last_12_months_pdt.ytd_revenue_for_clients]
    # drill_fields: [households_age_income_segments.houshld_houshld_name,households_revenue_segments_ndt.households_total_12_month_revenue,households_revenue_segments_ndt.households_recurring_revenue_ratio,households_revenue_segments_ndt.households_revenue_on_assets,households_revenue_segments_ndt.ytd_revenue,dashboard.total_aua_current_month_sample]
  }


}
