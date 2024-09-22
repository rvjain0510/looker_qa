# The name of this view in Looker is "Fact Rel Accnt Tradng Authrt"
view: fact_rel_accnt_tradng_authrt {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_TRADNG_AUTHRT` ;;
  drill_fields: [id]

  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Md Active" in Explore.

  dimension: md_active {
    type: yesno
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: md_creatn_log_id {
    type: string
    sql: ${TABLE}.MD_CREATN_LOG_ID ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: md_end_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MD_END_DT ;;
  }

  dimension: md_hash_nat_keys {
    type: number
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_md_hash_nat_keys {
    type: sum
    sql: ${md_hash_nat_keys} ;;  }
  measure: average_md_hash_nat_keys {
    type: average
    sql: ${md_hash_nat_keys} ;;  }

  dimension: md_hashdiff {
    type: number
    sql: ${TABLE}.MD_HASHDIFF ;;
  }

  dimension: md_modfy_log_id {
    type: string
    sql: ${TABLE}.MD_MODFY_LOG_ID ;;
  }

  dimension: md_src_systm {
    type: string
    sql: ${TABLE}.MD_SRC_SYSTM ;;
  }

  dimension_group: md_start_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MD_START_DT ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_tradng_authrt {
    type: number
    sql: ${TABLE}.NK_HK_DIM_TRADNG_AUTHRT ;;
  }

  dimension: sk_dim_accnt {
    type: number
    sql: ${TABLE}.SK_DIM_ACCNT ;;
  }

  dimension: sk_dim_tradng_authrt {
    type: number
    sql: ${TABLE}.SK_DIM_TRADNG_AUTHRT ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
