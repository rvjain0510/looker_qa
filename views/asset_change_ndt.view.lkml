# This view is created for dashboard_enhancement stories [1272931]-Add Total Row For Asset Change Table and [1272928]-Add Additional Tool Tips in Asset Change Graph
view: asset_change_ndt {
  derived_table: {
    explore_source: ax360_dashboards_historical {
      column: total_aua_last_12_month_including_current { field: fact_holdng_rr_12_months_master_list.aua_converted_to_cad_last_business_day_of_months }
      column: last_12_months_month { field: last_12_months_master_list.last_12_months_month }
      derived_column: total_aua_pre_month {
        sql: lag(total_aua_last_12_month_including_current) over (order by last_12_months_month asc) ;;
      }

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

      bind_filters: {
        to_field: dashboard.allocation_name_locale
        from_field: dashboard.allocation_name_locale
      }

      bind_filters: {
        to_field: dim_accnt.accnt_tp_value
        from_field: dim_accnt.accnt_tp_value
      }

      bind_filters: {
        to_field: dim_accnt.accnt_progrm_tp_name
        from_field: dim_accnt.accnt_progrm_tp_name
      }
    }
  }

  dimension: last_12_months_month {
    label: ""
    description: ""
    type: date_month
  }

  dimension: primary_key {
    type: string
    primary_key: yes
    sql: ${TABLE}.last_12_months_month ;;
  }

  dimension: last_12_months_date {
    type: date
    sql: parse_date('%Y-%m-%d', concat(${last_12_months_month},'-01')) ;;
  }

  dimension: year {
    type: number
    sql: extract(year from ${last_12_months_date}) ;;
  }

  dimension: asset_change_mtd_wo_13th_month{
    label: "" #this is localized
    sql:
           CASE WHEN FORMAT_DATE('%Y-%m',${last_12_months_date})= FORMAT_DATE('%Y-%m',  cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date) )  THEN '{{ _localization['month_to_date'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="January" THEN '{{ _localization['january'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="February" THEN '{{ _localization['february'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="March" THEN '{{ _localization['march'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="April" THEN '{{ _localization['april'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="May" THEN '{{ _localization['may'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="June" THEN '{{ _localization['june'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="July" THEN '{{ _localization['july'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="August" THEN '{{ _localization['august'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="September" THEN '{{ _localization['september'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="October" THEN '{{ _localization['october'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="November" THEN '{{ _localization['november'] }}'
              WHEN cast(format_date('%B',${last_12_months_date}) as string) ="December" THEN '{{ _localization['december'] }}'
              END;;
  }

  dimension: total_aua_last_12_month_including_current {
    description: ""
    type: number
    value_format_name: decimal_0
  }

  dimension:  total_aua_pre_month{
    description: ""
    type: number
    value_format_name: decimal_0
  }

  dimension: aua_change {
    description: ""
    type: number
    sql: coalesce(${total_aua_last_12_month_including_current},0)-coalesce(${total_aua_pre_month},0) ;;
    value_format_name: decimal_0
  }

  measure: total_aua {
    type: sum
    sql: ${total_aua_last_12_month_including_current} ;;
    value_format_name: decimal_0
  }

  measure: sum_aua_change {
    label: "asset_change_cad"
    type: sum
    sql: ${aua_change} ;;
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

  measure: sum_aua_change_scorecard {
    label: "asset_change_cad"
    type: sum
    sql: case when FORMAT_DATE('%Y-%m',${last_12_months_date}) =  FORMAT_DATE('%Y-%m',date_sub(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),interval 1 year)) then 0 else ${aua_change} end;;
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

  measure: temp{
    type: number
    sql:round(${dashboard.existing_client_cashflow} )
          --+ coalesce(${fact_transctn_rr_12_months_master_list.total_new_clients_cashflow},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_lost_clients_cashflow},0)
          ;;
  }

  measure: market_variation {
    label: "market_variation_scorecard_cad"
    type: number
    sql: round(coalesce(${sum_aua_change_scorecard},0) - (coalesce(${fact_transctn_rr_12_months_master_list.total_existing_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_new_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_lost_clients_cashflow_round_off_last_12_months},0)),0);;
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

  measure: total_net_growth {
    type: number
    sql: round(coalesce(${fact_transctn_rr_12_months_master_list.total_existing_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_new_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_lost_clients_cashflow_round_off_last_12_months},0),0)+round(coalesce(${market_variation},0),0);;
    value_format: "#,##0"
  }

  measure: total_net_growth_scorecard {
    label: "total_growth"
    type: number
    sql: round(coalesce(${fact_transctn_rr_12_months_master_list.total_existing_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_new_clients_cashflow_round_off_last_12_months},0) + coalesce(${fact_transctn_rr_12_months_master_list.total_lost_clients_cashflow_round_off_last_12_months},0),0)+round(coalesce(${market_variation},0),0);;
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
      {% endif %} ;;
  }

  measure: total_aua_change {
    label: "asset_change_cad"
    type: sum
    sql: ${aua_change}  ;;
    value_format_name: decimal_0
    html:
    <div style='padding-left: 5px;padding-right: 5px;'>
    {{rendered_value}}<br><br>
    {{asset_change_mtd_wo_13th_month}} {{year}}
    <table>
    <tr>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{ _localization['existing_clients_cad'] }}</td>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{fact_transctn_rr_12_months_master_list.total_existing_clients_cashflow_round_off_last_12_months._rendered_value}}</td>
    </tr>
    <tr>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{ _localization['new_clients_cad'] }}</td>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{fact_transctn_rr_12_months_master_list.total_new_clients_cashflow_round_off_last_12_months._rendered_value}}</td>
    </tr>
    <tr>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{ _localization['lost_clients_cad'] }}</td>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{fact_transctn_rr_12_months_master_list.total_lost_clients_cashflow_round_off_last_12_months._rendered_value}}</td>
    </tr>
    <tr>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{ _localization['market_variation_cad'] }}</td>
    <td style='border: 1px solid #ddd; padding: 8px;'>{{market_variation._rendered_value}}</td>
    </tr>
    <tr>
    <td style='border: 1px solid #ddd; padding: 8px;'>Total</td>
    <td style='border: 1px solid #ddd; padding: 8px; font-weight: bold;'>{{total_net_growth._rendered_value}}</td>
    </tr>
    </table></div>;;
  }
}
