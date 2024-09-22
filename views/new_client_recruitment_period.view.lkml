#This view is calculating recruitment period of new client i.e. recruitment_start_dt and recruitment_end_dt

view: new_client_recruitment_period {
  derived_table: {

    publish_as_db_view: yes
    datagroup_trigger: data_platform_load

    sql:
    -- if there is a new md_hash_nat_keys, then its a new party. Update the PDT.
        select ACCOUNT_NUMBER, a.md_hash_nat_keys, max(new_client_recruitment_dt) as recruitment_start_dt from
        `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT` as a
        join
        `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY` as link
        on link.NK_HK_DIM_ACCNT = a.md_hash_nat_keys
        join ${new_clients.SQL_TABLE_NAME} as r
        on link.NK_HK_DIM_PARTY = r.md_hash_nat_keys
        where a.MD_ACTIVE = true
        group by 1,2
        ;;
        # If there are 3 people in the account with two of them qualifying as new clients, then take the minimul of the recruitment date
        # min(case when recruitment_start_dt >= date_sub(current_date(), interval 12 month) then recruitment_start_dt else null end) as recruitment_start_dt
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

    dimension: recruitment_start_dt {
      type: date
      datatype: date
      sql: ${TABLE}.recruitment_start_dt ;;
    }

    dimension: recruitment_end_dt {
      type: date
      datatype: date
      sql: date_add(${recruitment_start_dt}, interval 12 month)-1 ;; ###1142971 - AUA Change Explained Dates Change(Added -1 in the dimension)
    }


  dimension: accnt_with_new_client_ind {  # Yes/No field to check whether the account belongs to new clients
    label: "New Client Account Indicator"
    type: yesno
    sql: date_sub( ${last_holding_date.last_update_date}, INTERVAL 12 month)+1 <= ${recruitment_start_dt};;
  }

    set: detail {
      fields: [
      ]
    }
  }
