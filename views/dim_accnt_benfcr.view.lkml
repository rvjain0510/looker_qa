view: dim_accnt_benfcr {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_ACCNT_BENFCR_MV` ;;

  dimension: beneficiary_address {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.BENEFICIARY_ADDRESS_LINE,${TABLE}.BENEFICIARY_ADDRESS_LINE_2,
      ${TABLE}.BENEFICIARY_CITY,${TABLE}.BENEFICIARY_PROVINCE_CODE, ${TABLE}.BENEFICIARY_POSTAL_CODE,
      ${TABLE}.BENEFICIARY_COUNTRY ],' ') ;;
  }

  dimension: beneficiary_name {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.BENEFICIARY_GIVEN_NAME,${TABLE}.BENEFICIARY_SURNAME, ${TABLE}.RETAIL_PLAN_BENEF_NAME],' ') ;;
  }

  dimension: benef_academic_year_leng {
    type: string
    description: "BENEF_ACADEMIC_YEAR_LENG"
    sql: ${TABLE}.BENEF_ACADEMIC_YEAR_LENG ;;
  }

  dimension_group: benef_academic_year_star {
    type: time
    description: "BENEF_ACADEMIC_YEAR_STAR"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BENEF_ACADEMIC_YEAR_STAR ;;
  }

  dimension: benef_ass_unass_contribu {
    type: string
    description: "BENEF_ASS_UNASS_CONTRIBU"
    sql: ${TABLE}.BENEF_ASS_UNASS_CONTRIBU ;;
  }

  dimension: benef_contrib_percent {
    type: number
    description: "BENEF_CONTRIB_PERCENT"
    sql: CAST(${TABLE}.BENEF_CONTRIB_PERCENT as INT64)/100 ;;
    value_format: "0.00%"
  }

  dimension: benef_last_hrdc_trans_i {
    type: string
    description: "BENEF_LAST_HRDC_TRANS_I"
    sql: ${TABLE}.BENEF_LAST_HRDC_TRANS_I ;;
  }

  dimension: benef_pse_prog_length {
    type: string
    description: "BENEF_PSE_PROG_LENGTH"
    sql: ${TABLE}.BENEF_PSE_PROG_LENGTH ;;
  }

  dimension: benef_pse_prog_type {
    type: string
    description: "BENEF_PSE_PROG_TYPE"
    sql: ${TABLE}.BENEF_PSE_PROG_TYPE ;;
  }

  dimension: benef_pse_prog_year {
    type: string
    description: "BENEF_PSE_PROG_YEAR"
    sql: ${TABLE}.BENEF_PSE_PROG_YEAR ;;
  }

  dimension: benef_regd_with_hrcd {
    type: string
    description: "BENEF_REGD_WITH_HRCD"
    sql: ${TABLE}.BENEF_REGD_WITH_HRCD ;;
  }

  dimension: benefic_educt_inst_pos {
    type: string
    description: "BENEFIC_EDUCT_INST_POS"
    sql: ${TABLE}.BENEFIC_EDUCT_INST_POS ;;
  }

  dimension: benefic_relen_to_subscri {
    type: string
    description: "BENEFIC_RELEN_TO_SUBSCRI"
    sql: ${TABLE}.BENEFIC_RELEN_TO_SUBSCRI ;;
  }

  dimension: benefic_relen_to_subscri_name {
    type: string
    description: "BENEFIC_RELEN_TO_SUBSCRI Name"
    sql: CASE WHEN ${TABLE}.BENEFIC_RELEN_TO_SUBSCRI IS NULL OR TRIM(${TABLE}.BENEFIC_RELEN_TO_SUBSCRI) = '' THEN
               CASE WHEN lang_pref = 'en' THEN 'Unknown'
                    WHEN lang_pref = 'fr_FR' THEN 'Inconnu' END
                ELSE ${dim_accnt_benfcr_relation.attrbt_val_destntn__name} END ;;
  }

  dimension: beneficiary_activate_ind {
    type: yesno
    description: "BENEFICIARY_ACTIVATE_IND"
    sql: ${TABLE}.BENEFICIARY_ACTIVATE_IND ;;
  }

  dimension_group: beneficiary_birth {
    type: time
    description: "BENEFICIARY_BIRTH_DATE"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BENEFICIARY_BIRTH_DATE ;;
  }

  dimension_group: beneficiary_close {
    type: time
    description: "BENEFICIARY_CLOSE_DATE"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BENEFICIARY_CLOSE_DATE ;;
  }

  dimension: beneficiary_close_date_2 {
    type: string
    description: "BENEFICIARY_CLOSE_DATE_2"
    sql: ${TABLE}.BENEFICIARY_CLOSE_DATE_2 ;;
  }

  dimension: beneficiary_custody_name {
    type: string
    description: "BENEFICIARY_CUSTODY_NAME"
    sql: ${TABLE}.BENEFICIARY_CUSTODY_NAME ;;
  }

  dimension: beneficiary_gender {
    type: string
    description: "BENEFICIARY_GENDER"
    sql: ${TABLE}.BENEFICIARY_GENDER ;;
  }


  dimension: beneficiary_language_code {
    type: string
    description: "BENEFICIARY_LANGUAGE_CODE"
    sql: ${TABLE}.BENEFICIARY_LANGUAGE_CODE ;;
  }

  dimension_group: beneficiary_open {
    type: time
    description: "BENEFICIARY_OPEN_DATE"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.BENEFICIARY_OPEN_DATE ;;
  }

  dimension: beneficiary_residence_cod {
    type: string
    description: "BENEFICIARY_RESIDENCE_COD"
    sql: ${TABLE}.BENEFICIARY_RESIDENCE_COD ;;
  }

  dimension: beneficiary_sequence_no {
    type: string
    description: "BENEFICIARY_SEQUENCE_NO"
    sql: ${TABLE}.BENEFICIARY_SEQUENCE_NO ;;
  }

  dimension: beneficiary_sin {
    type: string
    value_format: "###-###-###"
    description: "BENEFICIARY_SIN"
    sql: ${TABLE}.BENEFICIARY_SIN ;;
  }

  dimension: benfcr_id {
    type: string
    description: "BENFCR_ID"
    sql: ${TABLE}.BENFCR_ID ;;
  }

  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: nk_hk_dim_benfcr {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }

  measure: count {
    type: count
    drill_fields: [beneficiary_custody_name
     # , beneficiary_surname, beneficiary_given_name
      ]
  }
}
