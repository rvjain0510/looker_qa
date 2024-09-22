
#created this to calculate Rolling 12 month in Rolling 12-Month Revenue Trend chart.
view: last_24_month_master_list {
derived_table: {
  datagroup_trigger: data_platform_load
  publish_as_db_view: yes
    sql:
    select FORMAT_DATE('%Y-%m',  cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date) ) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 1 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 2 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 3 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 4 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 5 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 6 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 7 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 8 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 9 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 10 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 11 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 12 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 13 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 14 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 15 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 16 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 17 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 18 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 19 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 20 MONTH))  as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 21 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 22 MONTH)) as last_24_months
union all
select FORMAT_DATE('%Y-%m',DATE_SUB(cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date), INTERVAL 23 MONTH)) as last_24_months
    ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: last_24_months {
    type: string
    sql: ${TABLE}.last_24_months ;;
  }

  dimension: last_24_month_with_mtd {
    label: "month" #this is localized
    sql: CASE WHEN ${last_24_months}= FORMAT_DATE('%Y-%m',  cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date) )  THEN '{{ _localization['month_to_date'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="January" THEN '{{ _localization['january'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="February" THEN '{{ _localization['february'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="March" THEN '{{ _localization['march'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="April" THEN '{{ _localization['april'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="May" THEN '{{ _localization['may'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="June" THEN '{{ _localization['june'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="July" THEN '{{ _localization['july'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="August" THEN '{{ _localization['august'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="September" THEN '{{ _localization['september'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="October" THEN '{{ _localization['october'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="November" THEN '{{ _localization['november'] }}'
              WHEN cast(format_date('%B', PARSE_DATE('%Y-%m', ${last_24_months})) as string) ="December" THEN '{{ _localization['december'] }}'
              END ;;
    order_by_field: last_24_months
  }

  set: detail {
    fields: [
      last_24_months
    ]
  }
}
