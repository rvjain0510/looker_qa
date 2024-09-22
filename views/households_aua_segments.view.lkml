#This view is created to build age and income segments for households.
view: households_aua_segments {

  derived_table: {

    explore_source: ax360_dashboards_hh {
      column: houshld_id { field: houshlds.houshld_id }
      column: houshld_houshld_name { field: houshlds.houshld_name }

      #1168403-changes-for-j-and-closed-accounts: To eliminate symmetric aggregation
      column: total_aua { field: fact_holdng_rr.aua_converted_to_cad_current_month }
      # bind_all_filters: yes

      # 1168403-changes-for-j-and-closed-accounts: Commented the filter as the filter is not to be applied on AUA
      # filters: [dim_accnt.account_status_level_1_without_locale: "Open"]

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


  dimension: houshld_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.houshld_id ;;
  }

  dimension: houshld_houshld_name {
    label: "Household Name"
    type: string
    sql: ${TABLE}.houshld_houshld_name ;;
  }

  dimension: total_aua {
    label: "Total AUA"
    type: number
    sql: ${TABLE}.total_aua ;;
    value_format_name: decimal_0
  }

  dimension: aua_tier {
    label: "asset_segment" #this label is localized
    type: string
    sql:  CASE
          WHEN ${total_aua}  < 50000 THEN '{{ _localization['below_50k_aua_seg'] }}'
          WHEN ${total_aua}  >= 50000 AND ${total_aua}  < 100000 THEN '{{ _localization['50k_to_99k_aua_seg'] }}'
          WHEN ${total_aua}  >= 100000 AND ${total_aua}  < 250000 THEN '{{ _localization['100k_to_249k_aua_seg'] }}'
          WHEN ${total_aua}  >= 250000 AND ${total_aua}  < 500000 THEN '{{ _localization['250k_to_499k_aua_seg'] }}'
          WHEN ${total_aua}  >= 500000 AND ${total_aua}  < 1000000 THEN '{{ _localization['500k_to_999k_aua_seg'] }}'
          WHEN ${total_aua}  >= 1000000 AND ${total_aua}  < 2000000 THEN '{{ _localization['1m_to_1.9m_aua_seg'] }}'
          WHEN ${total_aua}  >= 2000000 THEN '{{ _localization['2m_or_above_aua_seg'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }

  measure: households_aua {
    label: "total_market_value_cad" #this is localized
    type: sum
    sql: ${total_aua} ;;
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
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql:  case when ${dim_accnt.account_status_level_1} = "{{ _localization['Open']}}" then ${houshld_id} end ;;
  }

  measure: aua_pct_drill {
    label: "Total AUA %"
    type: number
    sql: coalesce(${households_aua}/nullif(${total_household_for_segments_ndt.total_aua} ,0),0) ;;
    value_format_name: percent_2
    html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
  }

}
