# This NDT view is specifically created for AX360 team based on their requirements
#account no is added

view: party_details_nearest_due_dates_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: WITH nearest_kyc_date AS (
        SELECT dim_party.PARTY_ID  AS party_id,
        cast(dim_party.md_hash_nat_keys as string) as client_id,
        dim_regstr_reprsnttv.REP_CODE  AS rep_cd,
        dim_regstr_reprsnttv.md_hash_nat_keys AS nk_hk_dim_regstr_reprsnttv,
          (CASE WHEN dim_accnt_locale.ACCNT_MANAGEMENT_TYPE.VALUE ="Non-Managed" then
          DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 3 YEAR)
          ELSE DATE_ADD(dim_accnt.LAST_KYC_UPDATE, INTERVAL 1 YEAR)
          END) AS kyc_due_date,
          dim_accnt.last_kyc_update as last_kyc_update,
          dim_accnt.no_change_form_date as no_change_form_date,
          dim_accnt.new_client_form_date as new_client_form_date,
          dim_accnt.ACCOUNT_NUMBER as account_no,
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

      --this account_number_list is for creating account no array for the client

      account_number_list as (
      select
      dim_party.PARTY_ID  AS party_id,
      dim_houshld_accnt_pdt.NK_HK_DIM_REGSTR_REPRSNTTV as NK_HK_DIM_REGSTR_REPRSNTTV,
      dim_party.md_hash_nat_keys as client_id,
      dim_accnt.ACCOUNT_NUMBER as account_no
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

      aua_for_client_id as (
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

      --this nearest_kyc_additional_cols we have added rownumber for AX360 team

      nearest_kyc_additional_cols as(
      select * from(
      select kyc.party_id, kyc.kyc_due_date, last_kyc_update, no_change_form_date, new_client_form_date, kyc.rep_cd, kyc.nk_hk_dim_regstr_reprsnttv, kyc.account_no, kyc.is_registered_to_client_portal, kyc.party_type,
      row_number() over(partition by kyc.party_id order by kyc.kyc_due_date asc)row_num
      from nearest_kyc_date as kyc
      join nearest_kyc_party_level as nearest_kyc
      on nearest_kyc.party_id=kyc.party_id and  nearest_kyc.rep_cd=kyc.rep_cd
      WHERE (row_num_neg = 1 or row_num_pos=1) and kyc.kyc_due_date is not null and nearest_kyc.kyc_due_date = kyc.kyc_due_date
      group by 1,2,3,4,5,6,7,8,9,10)
      where row_num = 1
      ),

      -- this joint_account_flag is for indicating if the client is having joint account or not(1231501)

      joint_account_flag as(
      select account_no,
      case when party_count > 1 then 'Joint_account' else 'Non_Joint_account' end joint_acc_flag
      from(
      select
      account_no,count(distinct party_id)party_count
      from nearest_kyc_date
      group by 1
      )),

      --this joint_account_client_list is for providing client list in array for joint account(1232668)

      joint_account_client_list as(
      select
      account_no,ARRAY_AGG( distinct client_id ORDER BY client_id) client_list
      from nearest_kyc_date
      group by 1
      )

      select p.party_id as party_id, acc.account_no as account_no, p.client_id, ac.kyc_due_date, aua.aua_converted_to_cad as aua_converted_to_cad, p.rep_cd as rep_cd, ac.is_registered_to_client_portal, ac.party_type,
      p.nk_hk_dim_regstr_reprsnttv, ac.no_change_form_date, ac.last_kyc_update, ac.new_client_form_date, joint_acc_flag,client_integrity,
      case when client_integrity = "Complete" and ac.is_registered_to_client_portal = True and ac.party_type != "Organization" and ac.kyc_due_date >= "2019-01-01" then "Yes" else "No" end kyc_eligibility,
      ARRAY_AGG( distinct ARRAY_TO_STRING(client_list,",") ORDER BY ARRAY_TO_STRING(client_list,","))client_list
      from nearest_kyc_party_level p
      join party_integrity i on p.party_id = i.party_id and p.rep_cd=i.rep_cd
      LEFT JOIN aua_for_client_id as aua ON p.party_id=aua.party_id and  p.rep_cd=aua.rep_cd
      LEFT JOIN nearest_kyc_additional_cols as ac on ac.party_id=p.party_id
      INNER JOIN account_number_list as acc on p.party_id = acc.party_id and p.nk_hk_dim_regstr_reprsnttv = acc.nk_hk_dim_regstr_reprsnttv
      INNER JOIN joint_account_flag as jf on acc.account_no = jf.account_no
      INNER JOIN joint_account_client_list as jc on jf.account_no = jc.account_no
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15;;
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
    type: string
    sql: ${TABLE}.client_id ;;
  }


  dimension: rep_cd {
    type: string
    sql: ${TABLE}.rep_cd ;;
  }

  dimension: account_no {
    type: string
    sql: ${TABLE}.account_no ;;
  }

  dimension: kyc_due_date {
    type: date
    datatype: date
    sql: ${TABLE}.kyc_due_date ;;
  }

  dimension: new_client_form_date {
    type: date
    datatype: date
    sql: ${TABLE}.new_client_form_date ;;
  }

  dimension: aua_converted_to_cad_dim {
    type: number
    sql: ${TABLE}.aua_converted_to_cad ;;
  }

  dimension: client_integrity {
    type: string
    sql: ${TABLE}.client_integrity ;;
  }

  dimension: joint_acc_flag {
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

  dimension: party_type {
    type: string
    sql: ${TABLE}.party_type ;;
  }

  dimension: is_registered_to_client_portal {
    type: string
    sql: ${TABLE}.is_registered_to_client_portal ;;
  }

  dimension: kyc_eligibility{
    type: yesno
    sql: ${client_integrity} = "Complete" and ${is_registered_to_client_portal} = True and ${party_type} != "Organization" and ${kyc_due_date} >= "2019-01-01" ;;
  }

  dimension: kyc_eligibility_string_convert{
    type: string
    sql: case when ${kyc_eligibility} = True then "Yes" else "No" end ;;
  }

  dimension: joint_account_flag {
    type: string
    sql: ${TABLE}.joint_acc_flag ;;
  }

  measure: kyc_eligibility_string_array{
    type: string
    sql: string_agg(distinct ${kyc_eligibility_string_convert} order by ${kyc_eligibility_string_convert}) ;;
  }

  measure: kyc_eligibility_fin{
    type: string
    sql: case when BYTE_LENGTH(${kyc_eligibility_string_array}) > 3 then 'No' else ${kyc_eligibility_string_array} end;;
  }

  dimension: joint_account_client_list {
    type: string
    sql: ARRAY_TO_STRING(${TABLE}.client_list,",") ;;
    #sql: ARRAY_AGG(distinct ARRAY_TO_STRING(${TABLE}.client_list,",") ORDER BY ARRAY_TO_STRING(${TABLE}.client_list,",")) ;;
  }

  measure: joint_account_client_list_fin {
    type: string
    sql: STRING_AGG(distinct ${joint_account_client_list},",") ;;
  }

  measure: joint_account_client_list_fin1 {
    hidden: yes
    type: string
    sql: ARRAY_AGG( distinct ${joint_account_client_list_fin} ORDER BY ${joint_account_client_list_fin}) ;;
  }

  measure: aua_converted_to_cad {
    type: sum
    sql: ${TABLE}.aua_converted_to_cad ;;
  }

  measure: repcd_array {
    type: string
    sql: ARRAY_AGG( distinct ${rep_cd} ORDER BY ${rep_cd}) ;;
  }

  measure: acc_no_array {
    type: string
    sql: ARRAY_AGG( distinct ${account_no} ORDER BY ${account_no}) ;;
  }

  measure: client_integrity_array {
    hidden: yes
    type: string
    sql: ARRAY_AGG( distinct ${client_integrity} ORDER BY ${client_integrity}) ;;
  }

  measure: joint_flag_array {
    hidden: yes
    type: string
    sql: ARRAY_AGG( distinct ${joint_account_flag} ORDER BY ${joint_account_flag}) ;;
  }

  measure: joint_flag_array_fin {
    type: string
    sql: case when ARRAY_LENGTH(${joint_flag_array}) = 2 then 'Joint_account' else ARRAY_TO_STRING(${joint_flag_array},"") end;;
  }

  measure: client_integrity_array_fin {
    type: string
    sql: case when ARRAY_LENGTH(${client_integrity_array}) = 2 then 'Incomplete' else ARRAY_TO_STRING(${client_integrity_array},"") end;;
  }

  set: detail {
    fields: [
      party_id,
      rep_cd,
      kyc_due_date
    ]
  }
}
