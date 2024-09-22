view: prev_holding_date {


  derived_table: {
    # datagroup_trigger: data_platform_load
    sql:
    select CAST("{{ _user_attributes['prev_holding_date_dev'] }}" AS date) as PREV_HOLDNG_DATE
    ;;

  }

  dimension: prev_holding_date {
    type: date
    datatype: date
    description: "Previous Holding Date"
    sql: ${TABLE}.PREV_HOLDNG_DATE  ;;
  }

}
