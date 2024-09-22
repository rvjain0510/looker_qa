# The name of this view in Looker is "Dim Accnt"
view: dim_accnt {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_MV` ;;


#  Modified Dimensions

  dimension: acct_type_and_number {
    type: string
    description: "Account Number"
    sql: CONCAT (${dim_accnt_locale.accnt_tp__name}," - ",${TABLE}.ACCOUNT_NUMBER) ;;
  }


  measure: beneficiary_name_list {
    type: string
    sql: (STRING_AGG(DISTINCT ${dim_accnt_benfcr.beneficiary_name},", " order by ${dim_accnt_benfcr.beneficiary_name})) ;;
  }

  dimension: accnt_ownrshp_tp {
    type: string
    description: "Account Ownership Type "
    sql: ${dim_accnt_locale.accnt_ownrshp_tp__name} ;;
  }

  dimension: accnt_ownrshp_tp_name {
    type: string
    description: "Account Ownership Type "
    sql: ${dim_accnt_locale.accnt_ownrshp_tp__name} ;;
  }
  dimension: accnt_time_horzn_kyc {
    type: string
    description: "Account Time Horzn KYC  "
    sql: ${dim_accnt_locale.accnt_time_horzn_kyc__value} ;;
  }

  dimension: time_horizon_code {
    type: string
    description: "Time Horizon Code"
    sql: ${TABLE}.TIME_HORIZON_CODE ;;
  }

  dimension: accnt_time_horzn_kyc_name {
    type: string
    description: "Account Time Horzn KYC  "
    sql: CASE WHEN ${TABLE}.TIME_HORIZON_CODE is null or TRIM(${TABLE}.TIME_HORIZON_CODE) ='' THEN null
            ELSE CASE WHEN ${dim_accnt_locale.accnt_time_horzn_kyc__name} is null THEN
               CASE WHEN lang_pref = 'en' THEN 'Unknown'
                    WHEN lang_pref = 'fr_FR' THEN 'Inconnu' END
                ELSE ${dim_accnt_locale.accnt_time_horzn_kyc__name} END END;;
  }


  dimension: accnt_tp_value {
    type: string
    label: "account_type"
    sql: ${dim_accnt_locale.accnt_tp__value} ;;
  }

  dimension: accnt_tp {
    type: string
    label: "account_tp"
    sql: ${dim_accnt_locale.accnt_tp__name} ;;
  }

  dimension: accnt_tp_name {
    type: string
    label: "account_tp Name"
    sql: ${dim_accnt_locale.accnt_tp__name} ;;
  }

  dimension: accnt_tp_long_desc {
    type: string
    label: "account_tp_long_desc"
    sql: ${dim_accnt_locale.accnt_tp__long_desc} ;;
  }

  dimension: accnt_progrm_tp {
    type: string
    label: "accnt_progrm_tp"
    sql: ${dim_accnt_locale.accnt_progrm_tp__name} ;;

  }

  dimension: accnt_progrm_tp_name {
    type: string
    label: "accnt_progrm_tp__name"
    sql: ${dim_accnt_locale.accnt_progrm_tp__name} ;;

  }

  dimension: accnt_management_tp {
    type: string
    description: "Account Management Type "
    sql: ${dim_accnt_locale.accnt_management_type__value} ;;
  }

  dimension: account_status_level_1 {
    type: string
    description: "Account Status Level 1"
    sql: ${dim_accnt_locale.account_status__name} ;;
  }

  dimension: account_status_level_1_name {
    type: string
    description: "Account Status Level 1"
    sql: ${dim_accnt_locale.account_status__name} ;;
  }

  dimension: account_registration_type {
    type: string
    description: "Account Registration Type"
    sql: ${dim_accnt_locale.accnt_registration_type__value} ;;
  }

  dimension: accnt_currnc {
    type: string
    description: "Account Currency"
    sql: ${TABLE}.ACCNT_CURRNC ;;
  }

  dimension: accnt_holdr_name {
    type: string
    description: "Account Holder Name"
    sql: ${TABLE}.ACCNT_HOLDR_NAME ;;

  }

  dimension: accnt_intrnl_cd4 {
    type: string
    description: "Account Internal Code 4"
    sql: ${TABLE}.ACCNT_INTRNL_CD4 ;;
  }

  dimension: accnt_rap_cd {
    type: string
    description: "Account Rap Code"
    sql: ${TABLE}.ACCNT_RAP_CD ;;
  }

  dimension: accnt_retl_pln {
    type: string
    description: "Account Retail Plan"
    sql: ${TABLE}.ACCNT_RETL_PLN ;;
  }

  dimension: accnt_tax_rcp_tp {
    type: string
    description: "Account Tax Recip Type"
    sql: ${TABLE}.ACCNT_TAX_RCP_TP ;;
  }

  dimension_group: account_close {
    type: time
    description: "Account Close Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ACCOUNT_CLOSE_DATE ;;
  }

  dimension_group: account_creation {
    type: time
    description: "Account Creation Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ACCOUNT_CREATION_DATE ;;
  }

  dimension: account_investment_objectives_kyc {
    type: string
    description: "Account Investment Objectives KYC"
    sql: ${TABLE}.ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: account_number {
    type: string
    description: "Account Number"
    sql: ${TABLE}.ACCOUNT_NUMBER ;;
  }

  dimension: account_risk_profile_kyc {
    type: string
    description: "Account Risk Profile KYC"
    sql: ${TABLE}.ACCOUNT_RISK_PROFILE_KYC ;;
  }



  dimension: asc3_mangd_tp {
    type: string
    description: "Account Asc3 Managed Type"
    sql: ${TABLE}.ASC3_MANGD_TP ;;
  }

  dimension: asc_1_resp_pln_tps {
    type: string
    description: "ASC_1_RESP_PLN_TPS"
    sql: ${TABLE}.ASC_1_RESP_PLN_TPS ;;
  }

  dimension: cash_and_equivalent_profile_account_investment_objectives_kyc {
    type: number
    description: "Cash and Equivalent Profile - Account Investment Objectives KYC"
    sql: ${TABLE}.CASH_AND_EQUIVALENT_PROFILE_ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: dap_account_account_number {
    type: string
    description: "DAP Account - Account Number"
    sql: ${TABLE}.DAP_ACCOUNT_ACCOUNT_NUMBER ;;
  }

  dimension: dap_account_agent_bank_id {
    type: string
    description: "DAP Account - Agent bank ID"
    sql: ${TABLE}.DAP_ACCOUNT_AGENT_BANK_ID ;;
  }

  dimension: dap_account_cuid_dtc {
    type: string
    description: "DAP Account - CUID/DTC"
    sql: ${TABLE}.DAP_ACCOUNT_CUID_DTC ;;
  }

  dimension: dap_account_institutional_id {
    type: string
    description: "DAP Account - Institutional ID"
    sql: ${TABLE}.DAP_ACCOUNT_INSTITUTIONAL_ID ;;
  }

  dimension: fixed_income_amount {
    type: number
    description: "FIXED_INCOME_AMOUNT"
    sql: ${TABLE}.FIXED_INCOME_AMOUNT ;;
  }

  dimension: gen_pymt_bank_account_nu {
    type: string
    description: "GEN_PYMT_BANK_ACCOUNT_NU"
    sql: ${TABLE}.GEN_PYMT_BANK_ACCOUNT_NU ;;
  }

  dimension: gen_pymt_bank_branch_num {
    type: string
    description: "GEN_PYMT_BANK_BRANCH_NUM"
    sql: ${TABLE}.GEN_PYMT_BANK_BRANCH_NUM ;;
  }

  dimension: gen_pymt_dadgp_desc_1 {
    type: string
    description: "GEN_PYMT_DADGP_DESC_1"
    sql: ${TABLE}.GEN_PYMT_DADGP_DESC_1 ;;
  }

  dimension: gen_pymt_dadgp_desc_2 {
    type: string
    description: "GEN_PYMT_DADGP_DESC_2"
    sql: ${TABLE}.GEN_PYMT_DADGP_DESC_2 ;;
  }

  dimension: gen_pymt_dadgp_funds {
    type: string
    description: "GEN_PYMT_DADGP_FUNDS"
    sql: ${TABLE}.GEN_PYMT_DADGP_FUNDS ;;
  }

  dimension_group: gen_pymt_effective {
    type: time
    description: "GEN_PYMT_EFFECTIVE_DATE"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GEN_PYMT_EFFECTIVE_DATE ;;
  }

  dimension_group: gen_pymt_effective_date_2 {
    type: time
    description: "GEN_PYMT_EFFECTIVE_DATE_2"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GEN_PYMT_EFFECTIVE_DATE_2 ;;
  }

  dimension: gen_pymt_elected_pymnt_a {
    type: number
    #type: string
    description: "GEN_PYMT_ELECTED_PYMNT_A"
    #sql: CASE WHEN ${TABLE}.GEN_PYMT_ELECTED_PYMNT_A = 0
    #THEN "Minimum"
    #ELSE ${TABLE}.GEN_PYMT_ELECTED_PYMNT_A
    #END;;
    sql: ${TABLE}.GEN_PYMT_ELECTED_PYMNT_A ;;
  }

  dimension: gen_pymt_fee_indicator {
    type: string
    description: "GEN_PYMT_FEE_INDICATOR"
    sql: ${TABLE}.GEN_PYMT_FEE_INDICATOR ;;
  }

  dimension: gen_pymt_fee_waiver_ind {
    type: yesno
    description: "GEN_PYMT_FEE_WAIVER_IND"
    sql: ${TABLE}.GEN_PYMT_FEE_WAIVER_IND ;;
  }

  dimension: gen_pymt_inst_num {
    type: string
    description: "GEN_PYMT_INST_NUM"
    sql: ${TABLE}.GEN_PYMT_INST_NUM ;;
  }

  dimension: gen_pymt_method_of_payme {
    type: string
    description: "GEN_PYMT_METHOD_OF_PAYME"
    sql: ${TABLE}.GEN_PYMT_METHOD_OF_PAYME ;;
  }

  dimension: gen_pymt_minimum_pymnt_a {
    type: number
    description: "GEN_PYMT_MINIMUM_PYMNT_A"
    sql: ${TABLE}.GEN_PYMT_MINIMUM_PYMNT_A ;;
  }

  dimension_group: gen_pymt_payment {
    type: time
    description: "GEN_PYMT_PAYMENT_DATE"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GEN_PYMT_PAYMENT_DATE ;;
  }

  dimension: gen_pymt_payment_frequen {
    type: string
    description: "GEN_PYMT_PAYMENT_FREQUEN"
    sql: ${dim_accnt_locale.payment_frequency__name} ;;
  }

  dimension: gen_pymt_payment_id {
    type: string
    description: "GEN_PYMT_PAYMENT_ID"
    sql: ${TABLE}.GEN_PYMT_PAYMENT_ID ;;
  }

  dimension: gen_pymt_payment_id_2 {
    type: string
    description: "GEN_PYMT_PAYMENT_ID_2"
    sql: ${TABLE}.GEN_PYMT_PAYMENT_ID_2 ;;
  }

  dimension: gen_pymt_max_pymnt {
    type: number
    description: "GEN_PYMT_MAX_PYMNT"
    sql: ${TABLE}.GEN_PYMT_MAX_PYMNT ;;
  }

  dimension: gen_pymt_tax_indicator {
    type: yesno
    description: "GEN_PYMT_TAX_INDICATOR"
    sql: ${TABLE}.GEN_PYMT_TAX_INDICATOR ;;
  }

  dimension_group: gen_pymt_termination_dat {
    type: time
    description: "GEN_PYMT_TERMINATION_DAT"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.GEN_PYMT_TERMINATION_DAT ;;
  }

  dimension: gen_pymt_trading_account {
    type: string
    description: "GEN_PYMT_TRADING_ACCOUNT"
    sql: ${TABLE}.GEN_PYMT_TRADING_ACCOUNT ;;
  }

  dimension: growth_profile_account_investment_objectives_kyc {
    type: number
    description: "Growth Profile - Account Investment Objectives KYC"
    sql: ${TABLE}.GROWTH_PROFILE_ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: high_risk_accnt_risk_profile_kyc {
    type: number
    description: "High Risk -Account Risk Tolerence KYC"
    sql: ${TABLE}.HIGH_RISK_ACCNT_RISK_PROFILE_KYC ;;
  }

  dimension: income_account_frequency {
    type: string
    description: "Income Account Frequency"
    sql: ${TABLE}.INCOME_ACCOUNT_FREQUENCY ;;
  }

  dimension_group: income_account_start {
    type: time
    description: "Income Account Start Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.INCOME_ACCOUNT_START_DATE ;;
  }

  dimension: income_profile_account_investment_objectives_kyc {
    type: number
    description: "Income Profile - Account Investment Objectives KYC"
    sql: ${TABLE}.INCOME_PROFILE_ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: itf_account_minor_s_name {
    type: string
    description: "ITF Account Minor's name"
    sql: ${TABLE}.ITF_ACCOUNT_MINOR_S_NAME ;;
  }

  dimension: j_account_bank_account_no {
    type: string
    description: "J Account - Bank Account No"
    sql: ${TABLE}.J_ACCOUNT_BANK_ACCOUNT_NO ;;
  }

  dimension: j_account_institutional_account {
    type: string
    description: "J Account - Institutional Account"
    sql: ${TABLE}.J_ACCOUNT_INSTITUTIONAL_ACCOUNT ;;
  }

  dimension: j_account_transit_number {
    type: string
    description: "J Account - Transit Number"
    sql: ${TABLE}.J_ACCOUNT_TRANSIT_NUMBER ;;
  }

  dimension_group: last_kyc_update {
    type: time
    description: "Last KYC Update"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.LAST_KYC_UPDATE ;;
  }

  dimension: low_risk_accnt_risk_profile_kyc {
    type: number
    description: "Low Risk -Account Risk Tolerence KYC"
    sql: ${TABLE}.LOW_RISK_ACCNT_RISK_PROFILE_KYC ;;
  }

  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }


  dimension: nk_hk_dim_accnt_str {
    type: string
    description: "MD_HASH_NAT_KEYS"
    value_format: "0"
    sql: CAST(${TABLE}.MD_HASH_NAT_KEYS AS STRING) ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS;;
  }



  dimension: medium_risk_accnt_risk_profile_kyc {
    type: number
    description: "Medium Risk -Account Risk Tolerence KYC"
    sql: ${TABLE}.MEDIUM_RISK_ACCNT_RISK_PROFILE_KYC ;;
  }

  dimension: nr_tax_percent {
    type: number
    hidden: yes
    description: "NR_TAX_PERCENT"
    sql: ${TABLE}.NR_TAX_PERCENT ;;
  }

  dimension: payment_amount {
    type: number
    description: "PAYMENT_AMOUNT"
    sql: ${TABLE}.PAYMENT_AMOUNT ;;
  }

  dimension: percentage {
    type: number
    description: "PERCENTAGE"
    sql: ${TABLE}.PERCENTAGE ;;
  }

  dimension: prort_ind {
    type: yesno
    description: "PRORT_IND"
    sql: ${TABLE}.PRORT_IND ;;
  }

  dimension: prv_tax_percent {
    type: number
    description: "PRV_TAX_PERCENT"
    sql: ${TABLE}.PRV_TAX_PERCENT ;;
  }

  dimension: root_account_number {
    type: string
    description: "ROOT_ACCOUNT_NUMBER"
    sql: ${TABLE}.ROOT_ACCOUNT_NUMBER ;;
  }

  dimension: account_jurisdiction {
    type: string
    description: "Account Jurisdiction"
    sql: ${TABLE}.ACCOUNT_JURISDICTION ;;
  }

  dimension: speculation_profile_account_investment_objectives_kyc {
    type: number
    description: "Speculation Profile - Account Investment Objectives KYC"
    sql: ${TABLE}.SPECULATION_PROFILE_ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: tax_percent {
    type: number
    description: "TAX_PERCENT"
    sql: ${TABLE}.TAX_PERCENT ;;
  }

  dimension: unknown_profile_account_investment_objectives_kyc {
    type: number
    description: "Unknown Profile - Account Investment Objectives KYC"
    sql: ${TABLE}.UNKNOWN_PROFILE_ACCOUNT_INVESTMENT_OBJECTIVES_KYC ;;
  }

  dimension: unknown_risk_accnt_risk_profile_kyc {
    type: number
    description: "Unknown Risk -Account Risk Tolerence KYC"
    sql: ${TABLE}.UNKNOWN_RISK_ACCNT_RISK_PROFILE_KYC ;;
  }

  dimension: account_spouse {
    type: string
    description: "Account Spouse"
    sql: ${TABLE}.ACCOUNT_SPOUSE ;;
  }

  dimension: e_delivery_confirms {
    type: yesno
    sql: ${TABLE}.E_DELIVERY_CONFIRMS ;;
  }

  dimension: e_delivery_tax_slips {
    type: yesno
    sql: ${TABLE}.E_DELIVERY_TAX_SLIPS ;;
  }

  dimension: e_delivery_portfolio_statements {
    type: yesno
    sql: ${TABLE}.E_DELIVERY_PORTFOLIO_STATEMENTS ;;
  }

  measure: count {
    type: count
    drill_fields: [ accnt_holdr_name, itf_account_minor_s_name]
  }

################################ ACCENTURE CODE ENDS HERE ###############################################


  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: account_status_level_1_without_locale { #this is been used in NDTs to work account_staus=Open filter in both the locale.
    hidden: yes
    type: string
    description: "Account Status Level 1"
    sql:  ${TABLE}.ACCOUNT_STATUS_LEVEL_1 ;;
  }

  dimension: new_account_ind {   # Yes/No field to check whether Account is created within 12 months of period or not.(New Account)
    label: "New Account Indicator"
    type: yesno
    sql: date_sub( ${last_holding_date.last_update_date}, INTERVAL 12 month)+1 <= ${dim_accnt.account_creation_date} ;;
  }

  dimension: lost_account_ind {   # Yes/No field to check whether Account is closed within 12 months of period or not.(Lost Account)
    label: "Lost Account Indicator"
    type: yesno
    sql: date_sub( ${last_holding_date.last_update_date}, INTERVAL 12 month)+1 <= ${dim_accnt.account_close_date} ;;
  }

  dimension: account_departure_start_date { #Account Departure Start Period
    type: date
    datatype: date
    sql: date_sub(${dim_accnt.account_close_date}, interval 12 month)+1 ;;
  }

  measure: lost_account_count {  #total number of lost accounts till now
    label: "Total Lost Accounts"
    type: count_distinct
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql: case when ${accnt_rap_cd}!='J' and ${lost_account_ind} then ${dim_accnt.account_number} end ;;
  }

  measure: new_account_count {  #total number of new accounts till now
    label: "Total New Accounts"
    type: count_distinct
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql: case when ${accnt_rap_cd}!='J' and ${new_account_ind} then ${dim_accnt.account_number} end ;;
  }

  measure: total_accounts {   #total number of active accounts till now
    type: count_distinct
    # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
    sql:  case when ${accnt_rap_cd}!='J' and ${account_status_level_1}="{{ _localization['Open'] }}" then ${dim_accnt.account_number} end ;;
  }

# Dimensions added for ADO 1090931 - Start
  dimension_group: new_client_form {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NEW_CLIENT_FORM_DATE ;;
  }

  dimension_group: kyc_update {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.KYC_UPDATE_DATE ;;
  }

  dimension_group: no_change_form {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NO_CHANGE_FORM_DATE ;;
  }

  dimension_group: kyc_due {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: CASE WHEN ${accnt_management_tp} ="Non-Managed" then
          DATE_ADD(${last_kyc_update_date}, INTERVAL 3 YEAR)
          ELSE DATE_ADD(${last_kyc_update_date}, INTERVAL 1 YEAR)
          END;;
  }

  # Dimensions added for ADO 1090931 - End

  dimension: account_orphan_status {
    type: string
    label: "account_orphan_status"
    sql: CASE WHEN ${accnts_orphan.hk_accnt_id} IS NOT NULL
          AND  ${houshld_accnts_orphan.hk_accnt_id} IS NULL
          THEN "orphan"
          WHEN ${accnts_orphan.hk_accnt_id} IS NOT NULL
          AND  ${houshld_accnts_orphan.hk_accnt_id} IS NOT NULL
          THEN "non-orphan"
          else "undefined"
          END ;;
  }

  dimension: accnt_genrt_trd_confrmtn {
    type: yesno
    sql: ${TABLE}.ACCNT_GENRT_TRD_CONFRMTN ;;
  }

  ### Quantiphi Area ends here

}
