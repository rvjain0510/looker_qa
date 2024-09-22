# The name of this view in Looker is "Ref Revenue Type Desc"

view: ref_revenue_type_desc {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{bq_project_id}.@{dv_dataset_name}.REF_REVENUE_TYPE_DESC` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Entry Type" in Explore.

  dimension: entry_type {
    type: string
    sql: ${TABLE}.ENTRY_TYPE ;;
  }

  dimension: hk_ref {
    type: number
    sql: ${TABLE}.HK_REF ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_hk_ref {
    type: sum
    sql: ${hk_ref} ;;  }
  measure: average_hk_ref {
    type: average
    sql: ${hk_ref} ;;  }

  dimension: md_creatn_log_id {
    type: string
    sql: ${TABLE}.MD_CREATN_LOG_ID ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: md {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.MD_DATE ;;
  }

  dimension: md_modfy_log_id {
    type: string
    sql: ${TABLE}.MD_MODFY_LOG_ID ;;
  }

  dimension: md_src_systm {
    type: string
    sql: ${TABLE}.MD_SRC_SYSTM ;;
  }

  dimension: revenue_type_code {
    type: string
    sql: ${TABLE}.`Revenue Type Code` ;;
  }

  dimension: revenue_type_desc_eng {
    type: string
    sql: ${TABLE}.`Revenue Type Desc ENG` ;;
  }

  dimension: revenue_type_desc_fra {
    type: string
    sql: ${TABLE}.`Revenue Type Desc FRA` ;;
  }

  dimension: sourcecode {
    type: string
    sql: ${TABLE}.SOURCECODE ;;
  }
  measure: count {
    type: count
  }
}
