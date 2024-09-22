view: last_12_months_master_list {
### This view is used in 'AUA CHange Explained' Look where we have to show all the historical transction of historical Rep Code even if it has 0 AUA.
  derived_table: {
    datagroup_trigger: data_platform_load
sql: select distinct last_12_months_date
          from (select cast(last_12_months_date as date) as last_12_months_date  from unnest([ {{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }} ]) AS last_12_months_date
                UNION ALL Select CAST("{{ _user_attributes['latest_holding_date_dev']}}" AS date) AS last_12_months_date);;
  }

  dimension_group: last_12_months {
    type: time
    timeframes: [raw, date, week, month, quarter, year,month_num,month_name]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_12_months_date ;;
    drill_fields: []
  }

  dimension: primary_key {
    primary_key: yes
    type: date
    sql:   ${TABLE}.last_12_months_date ;;
  }

  dimension: last_12_month_with_mtd {
    label: "month" #this is localized
    sql: CASE WHEN FORMAT_DATE('%Y-%m',${last_12_months_date})= FORMAT_DATE('%Y-%m',  cast("{{ _user_attributes['latest_holding_date_dev'] }}" as date) )  THEN '{{ _localization['month_to_date'] }}'
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
              END ;;
    order_by_field: last_12_months_month
  }

  dimension: last_12_month_with_mtd_wo_13th_month{
    label: "month" #this is localized
    sql:
         CASE WHEN  ${last_12_months_date} >= DATE_SUB( ${last_holding_date.last_update_date}, INTERVAL 11 month) THEN
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
              END
          END;;
    order_by_field: last_12_months_month
  }

}
