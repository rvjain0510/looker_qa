view: last_holding_date {

derived_table: {
  # datagroup_trigger: data_platform_load

#   sql: SELECT   PARSE_DATE('%Y%m%d',MAX(partition_id)) AS LAST_UPDATE_DATE
# FROM `@{bq_project_id}.@{bq_dataset_name}.INFORMATION_SCHEMA.PARTITIONS`
# WHERE table_name = 'FACT_HOLDNG_RR'
# and partition_id <> "__NULL__";;
sql:  select CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) as LAST_UPDATE_DATE ;;

}


  dimension: last_update_date {
    type: date
    datatype: date
    description: "Last Update Date"
    sql: ${TABLE}.LAST_UPDATE_DATE  ;;
  }



}