view: houshld_accnts {

# sql_table_name: `@{bq_project_id}.@{ods_dataset_name}.HOUSHLD_ACCNTS` ;;
  derived_table: {
    # persist_for: "0 seconds"
    # datagroup_trigger: nocache
    # 1168403-changes-for-j-and-closed-accounts: Updated the SQL; now selecting specific columns instead of "select *" as the column HK_ACCNT_ID column had repeated values
    sql: select distinct HK_ACCNT_ID, HOUSHLD_ID  from `@{bq_project_id}.@{ods_dataset_portal}.HOUSHLD_ACCNTS`;;
    # WHERE HK_ACCNT_ID!=-417248019973753685;;
  }

  dimension: hk_accnt_id {
    primary_key: yes
    type: number
    value_format: "0"
    sql: ${TABLE}.HK_ACCNT_ID ;;
  }

  dimension: hk_accnt_id_str {
    type: string
    description: "hk_accnt_id_str"
    value_format: "0"
    sql: CAST(${TABLE}.HK_ACCNT_ID AS STRING) ;;
  }

  dimension: houshld_id {
    type: number
    value_format: "0"
    sql: ${TABLE}.HOUSHLD_ID ;;
  }


  # dimension: houshld_accnt_id {
  #   type: number
  #   value_format: "0"
  #   sql: ${TABLE}.HOUSHLD_ACCNT_ID ;;
  # }


  measure: count {
    type: count
    drill_fields: [houshlds.houshld_id, houshlds.houshld_name]
  }
}
