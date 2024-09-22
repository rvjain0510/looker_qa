#This view is calculating departure period of lost client i.e. departure_start_dt and departure_end_dt
view: lost_client_departure_period {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load

    sql:
       select ACCOUNT_NUMBER, a.md_hash_nat_keys, max(lost_client_departure_dt) as departure_end_dt from
        `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT` as a
        join

      `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY` as link
      on link.NK_HK_DIM_ACCNT = a.md_hash_nat_keys
      join ${lost_clients.SQL_TABLE_NAME} as r
      on link.NK_HK_DIM_PARTY = r.md_hash_nat_keys
      where a.MD_ACTIVE = true
      group by 1,2
      ;;

    # If there are 3 people in the account with two of them qualifying as new clients, then take the minimul of the departure date
    # min(case when departure_start_dt >= date_sub(current_date(), interval 12 month) then departure_start_dt else null end) as departure_start_dt
  }

  fields_hidden_by_default: yes

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.ACCOUNT_NUMBER ;;
  }
  dimension: md_hash_nat_keys {
    type: string
    sql: ${TABLE}.md_hash_nat_keys ;;
  }

  dimension: departure_end_dt {
    type: date
    datatype: date
    sql: ${TABLE}.departure_end_dt ;;
  }


  dimension: departure_start_dt {
    type: date
    datatype: date
    sql: date_sub(${departure_end_dt}, interval 12 month)+1 ;;  ###1142971 - AUA Change Explained Dates Change(Added +1 in the dimension)
  }

  set: detail {
    fields: [
    ]
  }
}
