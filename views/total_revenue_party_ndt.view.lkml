view: total_revenue_party_ndt {
#This view is created to create revenue tier for client segmentations.
  derived_table: {
    explore_source: ax360_dashboards_revenue
    {
      #removed ID column from select statement as its required
      column: party_id { field: dim_party.party_id }
      column: total_clients { field: dim_party.total_clients }
      column: md_hash_nat_keys { field: dim_party.nk_hk_dim_party }
      column: client_name {field: dim_party.party_name}
      column: total_revenue {field:fact_revn_rr.total_12_month_revenue_for_clients}
      column: total_12_month_recurring_revenue { field: fact_revn_rr.total_12_month_recurring_revenue }
      column: ytd_revenue { field: fact_revn_rr.ytd_revenue }
      filters: {
        field: dim_party.md_active
        value: "Yes"
      }
      filters: [dim_accnt.md_active: "Yes"]
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
  # fields_hidden_by_default: yes


  dimension: party_id {
    type: string
    sql: ${TABLE}.party_id ;;
  }

  dimension: md_hash_nat_keys {
    type: number
    primary_key: yes
  }

  dimension: revenue {
    label: "Total Revenue (Party)"
    value_format: "$#,##0"
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension: client_name {
    label: "full_name"
    type: string
    sql: ${TABLE}.client_name ;;
    html: <a href="{{link}}&redirect={{ dim_party.nk_hk_dim_party }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; text-align:left; font-weight:600">{{ value }}</p></a>;;

  }

  dimension: revenue_tier {
    label: "revenue_segment" #this label is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
          WHEN ${revenue}  < 500 THEN '{{ _localization['below_500_revenue_seg'] }}'
          WHEN ${revenue}  >= 500 AND ${revenue}  < 1000 THEN '{{ _localization['500_to_999_revenue_seg'] }}'
          WHEN ${revenue}  >= 1000 AND ${revenue}  < 2500 THEN '{{ _localization['1000_to_2499_revenue_seg'] }}'
          WHEN ${revenue}  >= 2500 AND ${revenue}  < 5000 THEN '{{ _localization['2500_to_4999_revenue_seg'] }}'
          WHEN ${revenue}  >= 5000 AND ${revenue}  < 10000 THEN '{{ _localization['5k_to_9999_revenue_seg'] }}'
          WHEN ${revenue}  >= 10000 AND ${revenue}  < 20000 THEN '{{ _localization['10k_to_19999_revenue_seg'] }}'
          WHEN ${revenue}  >= 20000 THEN '{{ _localization['20k_or_above_revenue_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }

  dimension: revenue_segment {
    label: "revenue_segment_tier" #this label is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
          WHEN ${revenue}  < 500 THEN '{{ _localization['below_500_revenue_seg'] }}'
          WHEN ${revenue}  >= 500 AND ${revenue}  < 1000 THEN '{{ _localization['500_to_999_revenue_seg'] }}'
          WHEN ${revenue}  >= 1000 AND ${revenue}  < 2500 THEN '{{ _localization['1000_to_2499_revenue_seg'] }}'
          WHEN ${revenue}  >= 2500 AND ${revenue}  < 5000 THEN '{{ _localization['2500_to_4999_revenue_seg'] }}'
          WHEN ${revenue}  >= 5000 AND ${revenue}  < 10000 THEN '{{ _localization['5k_to_9999_revenue_seg'] }}'
          WHEN ${revenue}  >= 10000 AND ${revenue}  < 20000 THEN '{{ _localization['10k_to_19999_revenue_seg'] }}'
          WHEN ${revenue}  >= 20000 THEN '{{ _localization['20k_or_above_revenue_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }

  measure: clients_total_12_month_revenue {
    label: "12_month_revenue"
    type: sum
    sql: ${revenue} ;;
    value_format_name: decimal_0
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: clients_total_12_month_revenue_drill {
    label: "12_month_revenue"
    type: sum
    sql: ${revenue} ;;
    value_format_name: decimal_0
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

  measure: clients_total_12_month_recurring_revenue {
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

  measure: clients_recurring_revenue_ratio {
    label: "recurring_revenue_ratio"
    type: number
    sql: coalesce(${clients_total_12_month_recurring_revenue}/ nullif(${clients_total_12_month_revenue},0),0) ;;
    value_format_name: percent_2
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }


  # measure: clients_revenue_on_assets {
  #   label: "Revenue on Assets"
  #   type: number
  #   sql: ${clients_total_12_month_revenue}/nullif((${clients_aua_segments.clients_aua_12_month}/12),0);;
  #   value_format_name: percent_2
  #   html:
  #         {% if value < 0 %}
  #         <span style="color:#B5252A;">{{rendered_value}}</span>
  #         {% else %}
  #         {{rendered_value}}
  #         {% endif %};;
  # }

  measure: clients_revenue_on_assets_for_drill {
    label: "revenue_on_assets"
    type: number
    sql: coalesce(${clients_total_12_month_revenue}/nullif((${total_aua_last_12_months_at_party_ndt.total_aua_last_12_month_including_current}/12),0),0);;
    value_format_name: percent_2
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

#Revenue open account filter
  measure: total_clients {
    label: "Total Clients"
    type: count_distinct
    sql: case when ${dim_accnt.account_status_level_1_without_locale} = "Open" then ${party_id} end ;;
  }

#Revenue open account filter
  measure: total_clients_rs {
    label: "Total Clients"
    type: count_distinct
    sql: case when ${dim_accnt.account_status_level_1_without_locale} = "Open" then ${party_id} end ;;
    link: {
      label: "client_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
      }' %}
      {{ total_clients_rs_sample._link }}&sorts=total_revenue_party_ndt.clients_total_12_month_revenue+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
  }

#Revenue open account filter
  measure: total_clients_rs_sample {  #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,clients_total_12_month_revenue_drill,clients_recurring_revenue_ratio,clients_revenue_on_assets_for_drill,ytd_revenue,dashboard.total_aua_current_month_sample,dashboard.at_least_one_account_open]
  }

#Revenue open account filter
  measure: total_clients_pct_drill_for_segment {     # Added link for custom drill viz. This measure is been used in Clients segmentation looks of 'Clients' dashboard
    hidden: no
    type: number
    sql:${total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0);;
    value_format_name: percent_2
    link: {
      label: "client_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
      }' %}
      {{ total_clients_pct_drill_for_segments_sample._link }}&sorts=fact_revn_rr.total_12_month_revenue+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
  }

#Revenue open account filter
  measure: total_clients_pct_drill_for_segments_sample {  #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,dashboard.total_aua_current_month_sample,clients_total_12_month_revenue_drill,clients_recurring_revenue_ratio,clients_revenue_on_assets_for_drill,ytd_revenue,dashboard.at_least_one_account_open]
  }

  measure: median_client_revenue {
    type: median
    sql: coalesce(${revenue},0) ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
  }

}
