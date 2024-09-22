view: dim_accnt_locale {
  derived_table: {
    datagroup_trigger: data_platform_load
    sql: select * from `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_LOCALE` ;;
  }

  drill_fields: [id]

fields_hidden_by_default: yes

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: lang_cd {
    type: string
    sql: ${TABLE}.LANG_CD ;;
  }

  dimension: accnt_designation__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.DESCRPTN ;;
    group_label: "Accnt Designation"
    group_item_label: "Descrptn"
  }

  dimension: accnt_designation__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.LONG_DESC ;;
    group_label: "Accnt Designation"
    group_item_label: "Long Desc"
  }

  dimension: accnt_designation__name {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.NAME ;;
    group_label: "Accnt Designation"
    group_item_label: "Name"
  }

  dimension: accnt_designation__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.SHRT_DESC ;;
    group_label: "Accnt Designation"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_designation__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.SHRT_NAME ;;
    group_label: "Accnt Designation"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_designation__value {
    type: string
    sql: ${TABLE}.ACCNT_DESIGNATION.VALUE ;;
    group_label: "Accnt Designation"
    group_item_label: "Value"
  }

  dimension: accnt_management_type__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.DESCRPTN ;;
    group_label: "Accnt Management Type"
    group_item_label: "Descrptn"
  }

  dimension: accnt_management_type__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.LONG_DESC ;;
    group_label: "Accnt Management Type"
    group_item_label: "Long Desc"
  }

  dimension: accnt_management_type__name {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.NAME ;;
    group_label: "Accnt Management Type"
    group_item_label: "Name"
  }

  dimension: accnt_management_type__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.SHRT_DESC ;;
    group_label: "Accnt Management Type"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_management_type__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.SHRT_NAME ;;
    group_label: "Accnt Management Type"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_management_type__value {
    type: string
    sql: ${TABLE}.ACCNT_MANAGEMENT_TYPE.VALUE ;;
    group_label: "Accnt Management Type"
    group_item_label: "Value"
  }

  dimension: accnt_ownrshp_tp__name {
    type: string
    sql: ${TABLE}.ACCNT_OWNRSHP_TP.NAME ;;
    group_label: "Accnt Ownrshp Tp"
    group_item_label: "Name"
  }

  dimension: accnt_phase__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.DESCRPTN ;;
    group_label: "Accnt Phase"
    group_item_label: "Descrptn"
  }

  dimension: accnt_phase__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.LONG_DESC ;;
    group_label: "Accnt Phase"
    group_item_label: "Long Desc"
  }

  dimension: accnt_phase__name {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.NAME ;;
    group_label: "Accnt Phase"
    group_item_label: "Name"
  }

  dimension: accnt_phase__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.SHRT_DESC ;;
    group_label: "Accnt Phase"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_phase__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.SHRT_NAME ;;
    group_label: "Accnt Phase"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_phase__value {
    type: string
    sql: ${TABLE}.ACCNT_PHASE.VALUE ;;
    group_label: "Accnt Phase"
    group_item_label: "Value"
  }

  dimension: accnt_progrm_tp__name {
    type: string
    sql: ${TABLE}.ACCNT_PROGRM_TP.NAME ;;
    group_label: "Accnt Progrm Tp"
    group_item_label: "Name"
  }

  dimension: accnt_progrm_tp__value {
    type: string
    sql: ${TABLE}.ACCNT_PROGRM_TP.VALUE ;;
    group_label: "Accnt Progrm Tp"
    group_item_label: "Value"
  }

  dimension: accnt_registration_type__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.DESCRPTN ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Descrptn"
  }

  dimension: accnt_registration_type__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.LONG_DESC ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Long Desc"
  }

  dimension: accnt_registration_type__name {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.NAME ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Name"
  }

  dimension: accnt_registration_type__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.SHRT_DESC ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_registration_type__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.SHRT_NAME ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_registration_type__value {
    type: string
    sql: ${TABLE}.ACCNT_REGISTRATION_TYPE.VALUE ;;
    group_label: "Accnt Registration Type"
    group_item_label: "Value"
  }

  dimension: account_status__name {
    type: string
    hidden: yes
    sql: ${TABLE}.ACCOUNT_STATUS.NAME ;;
    group_label: "Account Status"
    group_item_label: "Name"
  }

  dimension: accnt_time_horzn_kyc__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.DESCRPTN ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Descrptn"
  }

  dimension: accnt_time_horzn_kyc__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.LONG_DESC ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Long Desc"
  }

  dimension: accnt_time_horzn_kyc__name {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.NAME ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Name"
  }

  dimension: accnt_time_horzn_kyc__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.SHRT_DESC ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_time_horzn_kyc__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.SHRT_NAME ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_time_horzn_kyc__value {
    type: string
    sql: ${TABLE}.ACCNT_TIME_HORZN_KYC.VALUE ;;
    group_label: "Accnt Time Horzn Kyc"
    group_item_label: "Value"
  }

  dimension: accnt_tp__descrptn {
    type: string
    sql: ${TABLE}.ACCNT_TP.DESCRPTN ;;
    group_label: "Accnt Tp"
    group_item_label: "Descrptn"
  }

  dimension: accnt_tp__long_desc {
    type: string
    sql: ${TABLE}.ACCNT_TP.LONG_DESC ;;
    group_label: "Accnt Tp"
    group_item_label: "Long Desc"
  }

  dimension: accnt_tp__name {
    type: string
    sql: ${TABLE}.ACCNT_TP.NAME ;;
    group_label: "Accnt Tp"
    group_item_label: "Name"
  }

  dimension: accnt_tp__shrt_desc {
    type: string
    sql: ${TABLE}.ACCNT_TP.SHRT_DESC ;;
    group_label: "Accnt Tp"
    group_item_label: "Shrt Desc"
  }

  dimension: accnt_tp__shrt_name {
    type: string
    sql: ${TABLE}.ACCNT_TP.SHRT_NAME ;;
    group_label: "Accnt Tp"
    group_item_label: "Shrt Name"
  }

  dimension: accnt_tp__value {
    type: string
    sql: ${TABLE}.ACCNT_TP.VALUE ;;
    group_label: "Accnt Tp"
    group_item_label: "Value"
  }
  dimension: payment_frequency__descrptn {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.DESCRPTN ;;
    group_label: "Payment Frequency"
    group_item_label: "Descrptn"
  }

  dimension: payment_frequency__long_desc {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.LONG_DESC ;;
    group_label: "Payment Frequency"
    group_item_label: "Long Desc"
  }

  dimension: payment_frequency__name {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.NAME ;;
    group_label: "Payment Frequency"
    group_item_label: "Name"
  }

  dimension: payment_frequency__shrt_desc {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.SHRT_DESC ;;
    group_label: "Accnt Tp"
    group_item_label: "Shrt Desc"
  }

  dimension: payment_frequency__shrt_name {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.SHRT_NAME ;;
    group_label: "Payment Frequency"
    group_item_label: "Shrt Name"
  }

  dimension: payment_frequency__value {
    type: string
    sql: ${TABLE}.GEN_PYMT_PAYMENT_FREQUEN.VALUE ;;
    group_label: "Payment Frequency"
    group_item_label: "Value"
  }

  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  accnt_tp__name,
  accnt_phase__name,
  accnt_tp__shrt_name,
  accnt_progrm_tp__name,
  accnt_phase__shrt_name,
  accnt_ownrshp_tp__name,
  accnt_designation__name,
  #accnt_progrm_tp__shrt_name,
  accnt_time_horzn_kyc__name,
  accnt_management_type__name,
 # accnt_ownrshp_tp__shrt_name,
  accnt_designation__shrt_name,
  accnt_registration_type__name,
  accnt_time_horzn_kyc__shrt_name,
  accnt_management_type__shrt_name,
  accnt_registration_type__shrt_name
  ]
  }

}