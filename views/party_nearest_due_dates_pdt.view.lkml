# This NDT view is specifically created for AX360 team based on their requirements
view: party_nearest_due_dates_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: WITH nearest_kyc_date AS (
        SELECT dim_party.PARTY_ID  AS party_id,
        dim_party.md_hash_nat_keys as client_id,
        dim_regstr_reprsnttv.REP_CODE  AS rep_cd,
        dim_regstr_reprsnttv.md_hash_nat_keys AS nk_hk_dim_regstr_reprsnttv,
          (CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
          DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
          ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
          END) AS kyc_due_date,
          dim_accnt.last_kyc_update as last_kyc_update,
          dim_accnt.no_change_form_date as no_change_form_date,
          dim_party.is_registered_to_client_portal as is_registered_to_client_portal,
          dim_party.party_type as party_type,

      --------------Integrity Columns--------------

      CASE WHEN dim_party.party_estimated_total_net_worth is NULL OR dim_party.party_estimated_total_net_worth in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS net_worth,
      CASE WHEN dim_party.current_party_approx_annual_income is NULL THEN 1 ELSE 0 END AS income,
      CASE WHEN dim_party.party_occupation is NULL OR dim_party.party_occupation in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS occupation,
      CASE WHEN dim_party.party_employer_name is NULL OR dim_party.party_employer_name in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS employer,
      CASE WHEN dim_party_locale.party_marital_status.name is NULL OR dim_party_locale.party_marital_status.name in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS marital_status,
      CASE WHEN dim_party.party_number_of_dependents  is NULL THEN 1 ELSE 0 END AS dependents,
      CASE WHEN dim_party.party_investment_knowledge is NULL OR dim_party.party_investment_knowledge in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS investment_knowledge,
      CASE WHEN dim_accnt.account_investment_objectives_kyc is NULL OR dim_accnt.account_investment_objectives_kyc in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS investment_objective,
      CASE WHEN dim_accnt.account_risk_profile_kyc is NULL OR dim_accnt.account_risk_profile_kyc in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS risk_profile,
      CASE WHEN dim_accnt.time_horizon_code is NULL OR dim_accnt.time_horizon_code in ( "", "NA","-","N/A","Not applicable","Not-applicable","Non applicable","Non-applicable","Unknown","UNKNOWN","unknown") THEN 1 ELSE 0 END AS time_horizon,

      --------------Integrity Columns--------------


      --ROW NUMBER FOR POSITIVE DELTA BETWEEN CURRENT_DATE AND KYC_DUE_DATE
      CASE WHEN( DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY)) < 0 THEN 0 ELSE

      (ROW_NUMBER() OVER (PARTITION BY dim_party.PARTY_ID,  dim_regstr_reprsnttv.REP_CODE,  CASE WHEN( DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY)) < 0 THEN 0 ELSE 1 END

      ORDER BY DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY)))  END AS row_num_pos,

      CASE WHEN( DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY)) >= 0 THEN 0 ELSE

      (ROW_NUMBER() OVER (PARTITION BY dim_party.PARTY_ID,  dim_regstr_reprsnttv.REP_CODE,  CASE WHEN( DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY)) >= 0 THEN 0 ELSE 1 END

      ORDER BY DATE_DIFF((CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) , CURRENT_DATE(), DAY) DESC)) END  AS row_num_neg


      FROM ${dim_houshld_accnt_pdt.SQL_TABLE_NAME}  AS dim_houshld_accnt_pdt
      --INNER JOIN ${dim_user_unnested.SQL_TABLE_NAME}  AS dim_user_unnested ON dim_houshld_accnt_pdt.NK_HK_DIM_REGSTR_REPRSNTTV = dim_user_unnested.NK_HK_DIM_REGSTR_REPRSNTTV
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` as dim_regstr_reprsnttv on dim_houshld_accnt_pdt.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV`  AS dim_accnt ON dim_houshld_accnt_pdt.nk_hk_dim_accnt = dim_accnt.MD_HASH_NAT_KEYS AND dim_accnt.MD_ACTIVE
      INNER JOIN  ${dim_accnt_locale.SQL_TABLE_NAME} AS dim_accnt_locale ON dim_accnt.MD_HASH_NAT_KEYS = dim_accnt_locale.MD_HASH_NAT_KEYS AND dim_accnt_locale.LANG_CD = 'en'
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY_MV`  AS fact_rel_accnt_party ON dim_accnt.MD_HASH_NAT_KEYS = fact_rel_accnt_party.NK_HK_DIM_ACCNT AND fact_rel_accnt_party.MD_ACTIVE
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY_MV`  AS dim_party ON fact_rel_accnt_party.NK_HK_DIM_PARTY = dim_party.MD_HASH_NAT_KEYS AND dim_party.MD_ACTIVE
      LEFT JOIN  ${lost_clients.SQL_TABLE_NAME} AS lost_clients ON dim_party.MD_HASH_NAT_KEYS=lost_clients.md_hash_nat_keys
      INNER JOIN ${dim_party_locale.SQL_TABLE_NAME} AS dim_party_locale ON dim_party.MD_HASH_NAT_KEYS = dim_party_locale.MD_HASH_NAT_KEYS AND dim_party_locale.LANG_CD = 'en'
      WHERE
      (CASE WHEN dim_accnt.ACCOUNT_NUMBER LIKE '38%'
      AND (CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) <="2017-08-04" then "No" ELSE "Yes" END) = "Yes"
      and lost_clients.md_hash_nat_keys is null and dim_accnt.ACCOUNT_STATUS_LEVEL_1='Open' and NOT REGEXP_CONTAINS(dim_accnt.ACCOUNT_NUMBER, '[Jj]$')

      ),

      aua_for_client_id as    (
      SELECT dim_party.PARTY_ID  AS party_id, dim_regstr_reprsnttv.rep_code as rep_cd,
      round(SUM(fact_holdng_rr.AUA_CONVERTED_TO_CAD),2) as aua_converted_to_cad

      FROM
      --INNER JOIN ${dim_user_unnested.SQL_TABLE_NAME}  AS dim_user_unnested ON dim_houshld_accnt_pdt.NK_HK_DIM_REGSTR_REPRSNTTV = dim_user_unnested.NK_HK_DIM_REGSTR_REPRSNTTV
      `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV`  AS dim_accnt
      INNER JOIN  ${dim_accnt_locale.SQL_TABLE_NAME} AS dim_accnt_locale ON dim_accnt.MD_HASH_NAT_KEYS = dim_accnt_locale.MD_HASH_NAT_KEYS AND dim_accnt_locale.LANG_CD = 'en'
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_REL_ACCNT_PARTY_MV`  AS fact_rel_accnt_party ON dim_accnt.MD_HASH_NAT_KEYS = fact_rel_accnt_party.NK_HK_DIM_ACCNT AND fact_rel_accnt_party.MD_ACTIVE
      INNER JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY_MV`  AS dim_party ON fact_rel_accnt_party.NK_HK_DIM_PARTY = dim_party.MD_HASH_NAT_KEYS AND dim_party.MD_ACTIVE
      LEFT JOIN  ${lost_clients.SQL_TABLE_NAME} AS lost_clients ON dim_party.MD_HASH_NAT_KEYS=lost_clients.md_hash_nat_keys
      LEFT JOIN `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR`  AS fact_holdng_rr ON dim_accnt.MD_HASH_NAT_KEYS = fact_holdng_rr.NK_HK_DIM_ACCNT
      AND fact_holdng_rr.BALANCE_DT =  "{{ _user_attributes['latest_holding_date_dev'] }}"
      LEFT JOIN `@{bq_project_id}.@{bq_dataset_name}.DIM_REGSTR_REPRSNTTV_MV` as dim_regstr_reprsnttv on fact_holdng_rr.NK_HK_DIM_REGSTR_REPRSNTTV = dim_regstr_reprsnttv.MD_HASH_NAT_KEYS
      WHERE(CASE WHEN dim_accnt.ACCOUNT_NUMBER LIKE '38%'
      AND (CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
      DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
      ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
      END) <="2017-08-04" then "No" ELSE "Yes" END) = "Yes"
      and lost_clients.md_hash_nat_keys is null and dim_accnt.ACCOUNT_STATUS_LEVEL_1='Open' and NOT REGEXP_CONTAINS(dim_accnt.ACCOUNT_NUMBER, '[Jj]$')

      group by 1,2
      ),

      party_integrity as(
      SELECT kyc.party_id party_id, kyc.client_id as client_id,kyc.rep_cd as rep_cd, nk_hk_dim_regstr_reprsnttv,
      -----Integrity calculation---
      CASE WHEN ( SUM(net_worth) + SUM(income) + SUM(occupation) + SUM(employer)+SUM(marital_status) + SUM(dependents) +  SUM(investment_knowledge) +
      SUM(investment_objective) + SUM(risk_profile) + SUM(time_horizon)) >0 THEN "Incomplete" ELSE "Complete" END AS client_integrity
      -----Integrity calculation---
      FROM nearest_kyc_date as kyc
      --  INNER JOIN aua_for_client_id as aua ON kyc.party_id=aua.party_id
      WHERE kyc.kyc_due_date is not null
      group by 1,2,3,4
      ),

      nearest_kyc_party_level as(
      SELECT kyc.party_id party_id, kyc.client_id as client_id,kyc.rep_cd as rep_cd, nk_hk_dim_regstr_reprsnttv,
      MAX(kyc.kyc_due_date) as kyc_due_date,
      -----Integrity calculation---
      --CASE WHEN ( SUM(net_worth) + SUM(income) + SUM(occupation) + SUM(employer)+SUM(marital_status) + SUM(dependents) +  SUM(investment_knowledge) +
      --SUM(investment_objective) + SUM(risk_profile) + SUM(time_horizon)) >0 THEN "Incomplete" ELSE "Complete" END AS client_integrity
      -----Integrity calculation---
      --SUM(aua.aua_converted_to_cad) as aua_converted_to_cad
      FROM nearest_kyc_date as kyc
      --  INNER JOIN aua_for_client_id as aua ON kyc.party_id=aua.party_id
      WHERE (row_num_neg = 1 or row_num_pos=1) and kyc.kyc_due_date is not null
      group by 1,2,3,4),

      nearest_kyc_additional_cols as(
      select kyc.party_id, last_kyc_update, no_change_form_date, kyc.rep_cd, kyc.nk_hk_dim_regstr_reprsnttv, kyc.is_registered_to_client_portal, kyc.party_type
      from nearest_kyc_date as kyc
      join nearest_kyc_party_level as nearest_kyc
      on nearest_kyc.party_id=kyc.party_id and  nearest_kyc.rep_cd=kyc.rep_cd
      WHERE (row_num_neg = 1 or row_num_pos=1) and kyc.kyc_due_date is not null and nearest_kyc.kyc_due_date = kyc.kyc_due_date
      )

      select p.party_id as party_id, p.client_id, p.kyc_due_date, aua.aua_converted_to_cad as aua_converted_to_cad, p.rep_cd as rep_cd, ac.is_registered_to_client_portal, ac.party_type,
      p.nk_hk_dim_regstr_reprsnttv, client_integrity, no_change_form_date, last_kyc_update
      from nearest_kyc_party_level p
      join party_integrity i on p.party_id = i.party_id and p.rep_cd=i.rep_cd
      LEFT JOIN aua_for_client_id as aua ON p.party_id=aua.party_id and  p.rep_cd=aua.rep_cd
      LEFT JOIN nearest_kyc_additional_cols as ac on ac.party_id=p.party_id and  ac.rep_cd=p.rep_cd ;;
  }

  #     SELECT kyc.party_id, kyc.client_id, kyc.rep_cd, MAX(kyc.kyc_due_date) as kyc_due_date,
  #     SUM(aua.aua_converted_to_cad) as aua_converted_to_cad
  #     FROM nearest_kyc_date as kyc
  #     INNER JOIN aua_for_client_id as aua ON kyc.party_id=aua.party_id
  #     WHERE row_num_neg = 1 or row_num_pos=1 and kyc_due_date is not null
  #     group by 1,2,3;;
  # }



  # limit_one_rep_code_for_party as(
  # select kyc.party_id as party_id, rep_cd
  # from nearest_kyc_date as kyc
  # join nearest_kyc_party_level as p
  # on kyc.party_id = p.party_id and  kyc.kyc_due_date = p.kyc_due_date
  # WHERE row_num_neg = 1 or row_num_pos=1 and kyc.kyc_due_date is not null
  # )

# t1 as (
# select party_id, rep_cd, kyc_due_date,
# CASE WHEN DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY) <0 then  0 ELSE (row_number()  OVER (PARTITION BY party_id, CASE WHEN DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY) <0 then  0 ELSE 1 end ORDER BY DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY)))  END AS row_num_pos,

# CASE WHEN DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY) >=0 then  0 ELSE (row_number()  OVER (PARTITION BY party_id, CASE WHEN DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY) >=0 then  0 ELSE 1 end ORDER BY DATE_DIFF(date (kyc_due_date), CURRENT_DATE(), DAY) desc)) END AS row_num_neg
# from data)

# select  party_id, rep_cd, max(kyc_due_date) as kyc_due_date
# from t1
# where row_num_pos = 1 or row_num_neg = 1
# group by 1,2

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: party_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.party_id ;;
  }

  dimension: client_id {
    type: number
    sql: ${TABLE}.client_id ;;
  }

  dimension: rep_cd {
    type: string
    sql: ${TABLE}.rep_cd ;;
  }

  dimension: party_type {
    type: string
    sql: ${TABLE}.party_type ;;
  }

  dimension: is_registered_to_client_portal {
    type: string
    sql: ${TABLE}.is_registered_to_client_portal ;;
  }

  dimension: kyc_due_date {
    type: date
    datatype: date
    sql: ${TABLE}.kyc_due_date ;;
  }

  dimension: aua_converted_to_cad_dim {
    type: number
    sql: ${TABLE}.aua_converted_to_cad ;;
  }

  dimension: client_integrity {
    type: string
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
  }

   dimension: last_kyc_update {
    type: date
    datatype: date
    sql: ${TABLE}.last_kyc_update ;;
  }

  dimension: no_change_form_date {
    type: date
    datatype: date
    sql: ${TABLE}.no_change_form_date ;;
  }

  dimension: kyc_eligibility{
    type: yesno
    sql: ${client_integrity} = "Complete" and ${is_registered_to_client_portal} = True and ${party_type} != "Organization" and ${kyc_due_date} >= "2019-01-01" ;;
  }

  measure: aua_converted_to_cad {
    type: sum
    sql: ${TABLE}.aua_converted_to_cad ;;
  }



  set: detail {
    fields: [
      party_id,
      rep_cd,
      kyc_due_date
    ]
  }
}
