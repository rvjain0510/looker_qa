#1146322 Create New Household Categories
view: household_categories_sdt {
  derived_table: {
    sql: WITH household_by_aua as (
        SELECT
          houshlds.HOUSHLD_ID  AS houshld_id,
          coalesce( sum(CASE WHEN  ( fact_holdng_rr.BALANCE_DT = "{{ _user_attributes['latest_holding_date_dev'] }}")  THEN  fact_holdng_rr.AUA_CONVERTED_TO_CAD   ELSE NULL END),0) AS total_aua
      FROM `@{bq_project_id}.@{ods_dataset_name}.HOUSHLDS` as houshlds
      INNER JOIN `@{bq_project_id}.@{ods_dataset_name}.HOUSHLD_ACCNTS` as houshld_accnts  ON houshlds.HOUSHLD_ID = houshld_accnts.HOUSHLD_ID
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV` AS dim_accnt
          ON dim_accnt.MD_HASH_NAT_KEYS = houshld_accnts.HK_ACCNT_ID
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_REGSTR_REPRSNTTV_ACCNT_MV` AS rel
          ON dim_accnt.MD_HASH_NAT_KEYS = rel.NK_HK_DIM_ACCNT
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` as dim_regstr_reprsnttv on rel.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS
      LEFT JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR`  AS fact_holdng_rr
      ON dim_accnt.MD_HASH_NAT_KEYS=fact_holdng_rr.NK_HK_DIM_ACCNT AND fact_holdng_rr.BALANCE_DT="{{ _user_attributes['latest_holding_date_dev'] }}"
    -- WHERE (UPPER(( dim_accnt.ACCOUNT_STATUS_LEVEL_1  )) = UPPER('Open'))
      GROUP BY
          1
      ),
      household_by_revenue as (SELECT
          houshlds.HOUSHLD_ID  AS houshld_id,
          coalesce(SUM(CASE WHEN fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
            and fact_revn_rr.TRANSACTION_DATE<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date)  THEN fact_revn_rr.REVENUE_AMOUNT_CAD  ELSE NULL END),0) AS total_12_month_revenue
      FROM `@{bq_project_id}.@{ods_dataset_name}.HOUSHLDS` as houshlds
      INNER JOIN `@{bq_project_id}.@{ods_dataset_name}.HOUSHLD_ACCNTS` as houshld_accnts  ON houshlds.HOUSHLD_ID = houshld_accnts.HOUSHLD_ID
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV` AS dim_accnt
          ON dim_accnt.MD_HASH_NAT_KEYS = houshld_accnts.HK_ACCNT_ID
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_REGSTR_REPRSNTTV_ACCNT_MV` AS rel
          ON dim_accnt.MD_HASH_NAT_KEYS = rel.NK_HK_DIM_ACCNT
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` as dim_regstr_reprsnttv on rel.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS
      LEFT JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REVN_RR`  AS fact_revn_rr
      ON dim_accnt.MD_HASH_NAT_KEYS=fact_revn_rr.NK_HK_DIM_ACCNT AND fact_revn_rr.TRANSACTION_DATE >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)


      --  WHERE (UPPER(( dim_accnt.ACCOUNT_STATUS_LEVEL_1  )) = UPPER('Open'))
      GROUP BY
      1)

      select  aua.HOUSHLD_ID  AS houshld_id,
      (CASE WHEN aua.total_aua >= 250000  THEN 'Yes' ELSE 'No' END) AS is_priority,
      (CASE WHEN revenue.total_12_month_revenue >= 2500  THEN 'Yes' ELSE 'No' END) AS is_core,
      (CASE WHEN revenue.total_12_month_revenue < 500  THEN 'Yes' ELSE 'No' END) AS is_stagnant
      from household_by_aua as aua
      INNER JOIN household_by_revenue as revenue ON aua.houshld_id=revenue.houshld_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: houshld_id {
    type: number
    sql: ${TABLE}.houshld_id ;;
  }

  dimension: is_priority {
    type: string
    sql: ${TABLE}.is_priority ;;
  }

  dimension: is_core {
    type: string
    sql: ${TABLE}.is_core ;;
  }

  dimension: is_stagnant {
    type: string
    sql: ${TABLE}.is_stagnant ;;
  }

  set: detail {
    fields: [
      houshld_id,
      is_priority,
      is_core,
      is_stagnant
    ]
  }
}
