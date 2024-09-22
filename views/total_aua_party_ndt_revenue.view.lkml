#This view is created to create AUA tier for client segmentations.
view: total_aua_party_ndt_revenue {
  derived_table: {
    explore_source: ax360_dashboards_revenue
    {
      column: id { field: dim_party.id }
      column: md_hash_nat_keys { field: dim_party.nk_hk_dim_party }
      column: total_aua {field:fact_holdng_rr.total_aua_for_clients}
      column: client_name {field: dim_party.party_name}
      filters: {
        field: dim_party.md_active
        value: "Yes"
      }
      filters: {
        field: fact_holdng_rr.current_month_latest_business_day_flag
        value: "Yes"
      }
      # 1168403-changes-for-j-and-closed-accounts: Commented the filter as the filter is not to be applied on AUA
      # filters: [dim_accnt.account_status_level_1_without_locale: "Open" , dim_accnt.md_active: "Yes"]
      filters: [ dim_accnt.md_active: "Yes"]
      bind_filters: {
        # to_field: dim_regstr_reprsnttv.rep_cd
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
  fields_hidden_by_default: yes

  dimension: id {
    type: number
  }

  dimension: md_hash_nat_keys {
    type: number
    primary_key: yes
  }

  dimension: aua {
    label: "Total AUA (Party)"
    value_format: "$#,##0"
    type: number
    sql: ${TABLE}.total_aua ;;
  }

  dimension: client_name {
    label: "Full Name"
    type: string
    sql: ${TABLE}.client_name ;;
  }

  dimension: aua_tier {
    label: "asset_segment" #this label is localized
    group_label: "Pre-set Buckets"
    type: string
    sql:  CASE
          WHEN ${aua}  < 50000 THEN '{{ _localization['below_50k_aua_seg'] }}'
          WHEN ${aua}  >= 50000 AND ${aua}  < 100000 THEN '{{ _localization['50k_to_99k_aua_seg'] }}'
          WHEN ${aua}  >= 100000 AND ${aua}  < 250000 THEN '{{ _localization['100k_to_249k_aua_seg'] }}'
          WHEN ${aua}  >= 250000 AND ${aua}  < 500000 THEN '{{ _localization['250k_to_499k_aua_seg'] }}'
          WHEN ${aua}  >= 500000 AND ${aua}  < 1000000 THEN '{{ _localization['500k_to_999k_aua_seg'] }}'
          WHEN ${aua}  >= 1000000 AND ${aua}  < 2000000 THEN '{{ _localization['1m_to_1.9m_aua_seg'] }}'
          WHEN ${aua}  >= 2000000 THEN '{{ _localization['2m_or_above_aua_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }


  measure: total_clients {
    type: number
    # sql: case when ${dim_accnt.account_status_level_1}="{{ _localization['Open'] }}" then ${md_hash_nat_keys} end ;;
    sql: ${dim_party.total_clients}  ;;
  }

  measure: aua_segments_clients_pct {
    #label: "Total Client% (AUA Segment)"
    hidden: no
    type: number
    sql: ${dim_party.total_clients}/nullif(${totals_for_segments_ndt.total_clients_for_segments},0) ;;
    value_format_name: percent_2
    link: {
      label: "client_details" #this label is localized
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
      }' %}
      {{ dashboard.total_clients_pct_drill_for_segments_sample._link }}&sorts=fact_holdng_rr.total_aua_current_month_sample+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }

    html:
      {% if value < 0 %}
      <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
      {% else %}
      <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
      {% endif %};;
  }

  measure: aua_segments_clients_pct_sample {
    type: count_distinct
    sql: 0;;
    drill_fields: [total_aua_party.client_name,total_aua_party.total_aua,dashboard.at_least_one_account_open]
  }

  measure: aua_segments_aua_pct {
    #label: "Total AUA% (AUA Segment)"
    type: number
    sql: ${total_aua}/nullif(${totals_for_segments_ndt.total_aua_for_segments},0) ;;
    value_format_name: percent_2
  }

  measure: total_aua {
    type: sum
    label: "Total AUA"
    sql: ${aua} ;;
    value_format_name: decimal_0
    html:
      {% if value < 0 %}
      <span style="color:#B5252A;">{{rendered_value}}</span>
      {% else %}
      {{rendered_value}}
      {% endif %};;
  }

  measure: avg_aua {
    #label: "Average AUA (AUA Segment)"
    hidden: no
    type: number
    sql: coalesce(${total_aua}/nullif(${total_clients},0),0);;
    value_format_name: decimal_0
  }
}
