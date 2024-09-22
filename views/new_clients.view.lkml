#This view is created to calculate total number of new clients.
view: new_clients {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load

    sql: SELECT party_id, p.md_hash_nat_keys, concat(PARTY_FIRST_PREFERRED_NAME, " ",PARTY_last_PREFERRED_NAME) as full_name,
        min(ACCOUNT_CREATION_DATE) as new_client_recruitment_dt FROM `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY` as p
        join
        `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY` as link
        on link.NK_HK_DIM_PARTY = p.md_hash_nat_keys
        join
        `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT` as a
        on link.NK_HK_DIM_ACCNT = a.md_hash_nat_keys
        where p.MD_ACTIVE = true and a.MD_ACTIVE = true
        group by 1,2,3
    ;;
    # New Clients are considered as Clients who have created their first account within the last 12 months from the latest business day.

  }
  fields_hidden_by_default: yes

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

  dimension: new_client_recruitment_dt {
    type: date
    datatype: date
    sql: ${TABLE}.new_client_recruitment_dt ;;
  }



  dimension: recruitment_end_dt {
    type: date
    datatype: date
    sql: date_add(${new_client_recruitment_dt}, interval 12 month)-1 ;;  ###1142971 - AUA Change Explained Dates Change(Added -1 in the dimension)
  }

}
