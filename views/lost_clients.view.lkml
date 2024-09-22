#This view is created to calculate total number of lost client.
view: lost_clients {
  fields_hidden_by_default: yes
  derived_table: {

    publish_as_db_view: yes
    datagroup_trigger: data_platform_load

    sql: SELECT party_id, p.md_hash_nat_keys, concat(PARTY_FIRST_PREFERRED_NAME, " ",PARTY_last_PREFERRED_NAME) as full_name,
          max(ACCOUNT_CLOSE_DATE) as lost_client_departure_dt, count(a.account_number) as total_accounts, count(a.ACCOUNT_CLOSE_DATE) as total_closed_accounts
          FROM `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY` as p
          join
          `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY` as link
          on link.NK_HK_DIM_PARTY = p.md_hash_nat_keys
          join
          `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT` as a
          on link.NK_HK_DIM_ACCNT = a.md_hash_nat_keys
          where a.MD_ACTIVE = true and p.MD_ACTIVE = true
          group by 1,2,3
          having total_accounts=total_closed_accounts;;
    # Lost Clients are considered as Clients who have closed all of their accounts within the last 12 Months from the latest business day.
  }

  dimension: party_id {
    type: string
    sql: ${TABLE}.party_id ;;
  }

  dimension: nk_hk_dim_party {
    type: number
    sql: ${TABLE}.md_hash_nat_keys ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: lost_client_departure_dt {
    type: date
    datatype: date
    sql: ${TABLE}.lost_client_departure_dt ;;
  }

  dimension: total_accounts {
    type: number
    sql: ${TABLE}.total_accounts ;;
  }

  dimension: total_closed_accounts {
    type: number
    sql: ${TABLE}.total_closed_accounts ;;
  }

  dimension: is_lost_client {
    type: yesno
    sql: ${party_id} is not null ;;
  }

}
