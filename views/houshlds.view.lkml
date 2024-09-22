view: houshlds {
sql_table_name: `@{bq_project_id}.@{ods_dataset_portal}.HOUSHLDS` ;;

  #derived_table: {
    # persist_for: "0 seconds"
    # datagroup_trigger: nocache
   # sql:  select * from `@{bq_project_id}.@{ods_dataset_name}.HOUSHLDS`;;
  #}
  drill_fields: [houshld_id]

  parameter: search_filter {
  }

  measure: searchclientfilter {
    type: number
    sql: INSTR(UPPER((STRING_AGG(DISTINCT ${dim_houshld_accnt_pdt.client_list_name},", " order by ${dim_houshld_accnt_pdt.client_list_name}
      ) )), UPPER({{ search_filter._parameter_value }})) ;;
  }

#to be chnaged to Part name
  measure: houshld_client_list {
    type: string
    description: "Household Client List"
    sql: (STRING_AGG(DISTINCT ${dim_houshld_accnt_pdt.client_list_name},", " order by ${dim_houshld_accnt_pdt.client_list_name}
      ) ) ;;
  }

  measure: houshld_client_list_with_type {
    type: string
    description: "Household Client List"
    sql: (STRING_AGG(DISTINCT ${dim_houshld_accnt_pdt.client_list_type_name},", " order by ${dim_houshld_accnt_pdt.client_list_type_name}
      ) ) ;;
  }

  ##1154382-Created the following measure the view for concatenated account list
  measure: acct_type_and_number_list {
    type: string
    description: "Account Type and Number List"
    sql: (STRING_AGG(DISTINCT ${dim_accnt.acct_type_and_number},", " order by ${dim_accnt.acct_type_and_number}) ) ;;
  }

  dimension: houshld_id_str {
    type: string
    value_format: "0"
    sql: CAST (${TABLE}.HOUSHLD_ID AS STRING) ;;
  }
  dimension: houshld_id {
    primary_key: yes
    type: number
    value_format: "0"
    sql: ${TABLE}.HOUSHLD_ID ;;
  }


  dimension: created_by_user_id {
    type: string
    sql: ${TABLE}.CREATED_BY_USER_ID ;;
  }


  dimension: houshld_addrss {
    type: string
    sql: ${TABLE}.HOUSHLD_ADDRSS ;;
  }

  dimension: houshld_name {
    type: string
    sql: ${TABLE}.HOUSHLD_NAME ;;
  }

  dimension: houshld_note {
    type: string
    sql: ${TABLE}.HOUSHLD_NOTE ;;
  }

  dimension: houshld_type {
    type: string
    sql: ${TABLE}.HOUSHLD_TYPE ;;
  }

  dimension: is_system_generated {
    type: yesno
    sql: ${TABLE}.IS_SYSTEM_GENERATED ;;
  }

  dimension: accnt_holdr_name {
    type: string
    description: "Account Holder Name"
    sql: ${dim_houshld_accnt_pdt.accnt_holdr_name} ;;
  }


  measure: count {
    type: count
    drill_fields: [houshld_id, houshld_name, houshld_accnts.count]
  }

 ########################## ACCENTURE AREA ENDS HERE #####################################################


  ### Quantiphi Area

  measure: total_household_count { #Total active households
    hidden: yes
    type: count_distinct
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql: case when ${dim_accnt.account_status_level_1_without_locale} = "Open" then ${houshld_id} end ;;
  }

  ### Quantiphi Area ends here

}
