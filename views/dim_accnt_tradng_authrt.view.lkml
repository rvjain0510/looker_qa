# The name of this view in Looker is "Dim Accnt Tradng Authrt"
view: dim_accnt_tradng_authrt {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_TRADNG_AUTHRT` ;;
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
    # This dimension will be called "Addresstype" in Explore.

  dimension: addresstype {
    type: string
    sql: ${TABLE}.ADDRESSTYPE ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: birth {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BIRTH_DATE ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: civicnumber {
    type: string
    sql: ${TABLE}.CIVICNUMBER ;;
  }

  dimension: civicnumbersuffix {
    type: string
    sql: ${TABLE}.CIVICNUMBERSUFFIX ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.COUNTRYCODE ;;
  }

  dimension: emailaddress {
    type: string
    sql: ${TABLE}.EMAILADDRESS ;;
  }

  dimension: extension {
    type: string
    sql: ${TABLE}.EXTENSION ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: trading_authority_name  {
    type: string
    sql: ARRAY_TO_STRING([${firstname}, ${lastname}],' ') ;;
  }

  dimension: majorsort {
    type: number
    sql: ${TABLE}.MAJORSORT ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_majorsort {
    type: sum
    sql: ${majorsort} ;;  }
  measure: average_majorsort {
    type: average
    sql: ${majorsort} ;;  }

  dimension: md_active {
    type: yesno
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: md_creatn_log_id {
    type: string
    sql: ${TABLE}.MD_CREATN_LOG_ID ;;
  }

  dimension_group: md_end_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.MD_END_DT ;;
  }

  dimension: nk_hk_dim_tradng_authrt {
    type: number
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

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

  dimension: otherrelationshipdesc {
    type: string
    sql: ${TABLE}.OTHERRELATIONSHIPDESC ;;
  }

  dimension: phonenumber {
    type: string
    sql: ${TABLE}.PHONENUMBER ;;
  }

  dimension: phonetype {
    type: string
    sql: ${TABLE}.PHONETYPE ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: provincecode {
    type: string
    sql: ${TABLE}.PROVINCECODE ;;
  }

  dimension: sequence_no {
    type: number
    sql: ${TABLE}.SEQUENCE_NO ;;
  }

  dimension: sin {
    type: string
    sql: ${TABLE}.SIN ;;
  }

  dimension: stationname {
    type: string
    sql: ${TABLE}.STATIONNAME ;;
  }

  dimension: stationtype {
    type: string
    sql: ${TABLE}.STATIONTYPE ;;
  }

  dimension: streetname {
    type: string
    sql: ${TABLE}.STREETNAME ;;
  }

  dimension: streettype {
    type: string
    sql: ${TABLE}.STREETTYPE ;;
  }

  dimension: tradng_authrt_id {
    type: string
    sql: ${TABLE}.TRADNG_AUTHRT_ID ;;
  }

  dimension: unitnumber {
    type: string
    sql: ${TABLE}.UNITNUMBER ;;
  }

  dimension: unittype {
    type: string
    sql: ${TABLE}.UNITTYPE ;;
  }
  measure: count {
    type: count
    drill_fields: [id, firstname, lastname, stationname, streetname]
  }
}
