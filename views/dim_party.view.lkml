# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view

# explore: dim_party {
#   hidden: yes
#   join: dim_party__struct_related_party {
#     view_label: "Dim Party: Struct Related Party"
#     sql: LEFT JOIN UNNEST(${dim_party.struct_related_party}) as dim_party__struct_related_party ;;
#     relationship: one_to_many
#   }
# }

view: dim_party {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY_MV` ;;

  dimension: party_name {
    type: string
    sql:  case when ${first_name_first.is_first_name_first}='Yes'
      then (CASE
          WHEN ${party_type} = '1' THEN ARRAY_TO_STRING([${TABLE}.PARTY_FIRST_PREFERRED_NAME ,${TABLE}.PARTY_MIDDLE_PREFERRED_NAME,
                                    ${TABLE}.PARTY_LAST_PREFERRED_NAME],' ')
          WHEN ${party_type}  = '2' THEN ${TABLE}.PARTY_ORGANIZATION_NAME
        ELSE
        'Unknown'
      END)
      else
      (CASE
          WHEN ${party_type} = '1' THEN ARRAY_TO_STRING([${TABLE}.PARTY_LAST_PREFERRED_NAME ,${TABLE}.PARTY_MIDDLE_PREFERRED_NAME,
                                    ${TABLE}.PARTY_FIRST_PREFERRED_NAME],' ')
          WHEN ${party_type}  = '2' THEN ${TABLE}.PARTY_ORGANIZATION_NAME
        ELSE
        'Unknown'
      END)
      end;;
  }


    dimension: party_name_first_name_first {
      type: string
      sql:

      case when ${first_name_first.is_first_name_first}='Yes'
      then
      (CASE WHEN ${party_type} = '1' THEN ARRAY_TO_STRING([${TABLE}.PARTY_FIRST_PREFERRED_NAME ,${TABLE}.PARTY_MIDDLE_PREFERRED_NAME, ${TABLE}.PARTY_LAST_PREFERRED_NAME],' ')
            WHEN ${party_type}  = '2' THEN ${TABLE}.PARTY_ORGANIZATION_NAME
            ELSE
            'Unknown'
      END)
      else
      (CASE WHEN ${party_type} = '1' THEN ARRAY_TO_STRING([${TABLE}.PARTY_LAST_PREFERRED_NAME ,${TABLE}.PARTY_MIDDLE_PREFERRED_NAME, ${TABLE}.PARTY_FIRST_PREFERRED_NAME],' ')
            WHEN ${party_type}  = '2' THEN ${TABLE}.PARTY_ORGANIZATION_NAME
            ELSE
            'Unknown'
      END)
      end;;
    }

  dimension: formatted_postal_code {
    type: string
    hidden: yes
    description: "Formatted Postal Code"
    sql: CASE WHEN (${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE IS NULL)
          THEN NULL
          WHEN LENGTH(${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE) = 6
          THEN CONCAT(SUBSTR(${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE, 1, 3), " ", SUBSTR(${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE, -3))
          ELSE ${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE
          END;;
  }

  dimension: party_address {
    type: string
    description: "Party Address"
    sql: CASE WHEN ${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER IS NULL AND
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NUMBER, "") = "" AND
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME), "") = "" AND
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_CITY), "") = "" AND
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE, "") = "" AND
          COALESCE(${formatted_postal_code},"") = "" AND
          COALESCE(${dim_party_locale.party_mailing_address_country__name}, "") = ""
          THEN ""
          ELSE
          CONCAT(
          CASE WHEN ((${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME IS NULL) OR (${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME = "")) THEN ""
          ELSE
          CONCAT(CASE WHEN ${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER IS NULL THEN "" ELSE CONCAT(${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER, "-") END,
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NUMBER, ""), " ",
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME), ""),
          CHR(13))
          END,
          CASE WHEN
          ((${TABLE}.PARTY_MAILING_ADDRESS_CITY IS NULL) OR (UPPER(${TABLE}.PARTY_MAILING_ADDRESS_CITY)) = "UNKNOWN")
          THEN ""
          ELSE CONCAT(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_CITY), " ")
          END,
          CASE WHEN
          ((${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE IS NULL) OR (UPPER(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE)) = "XIN")
          THEN ""
          ELSE CONCAT(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE, " ")
          END,
          CASE WHEN ((${formatted_postal_code} IS NULL) OR (${formatted_postal_code} = ""))
          THEN ""
          ELSE CONCAT(${formatted_postal_code},CHR(13))
          END,
          COALESCE(${dim_party_locale.party_mailing_address_country__name}, "")
          )
          END;;
  }

  dimension: party_address_for_filter {
    type: string
    description: "Party Address"
    sql: replace(${party_address}, CHR(13) , " ") ;;
  }

  dimension: party_address_one_line {
    type: string
    description: "One Line Party Address"
    sql: CASE WHEN ${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER IS NULL AND
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NUMBER, "") = "" AND
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME), "") = "" AND
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_CITY), "") = "" AND
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE, "") = "" AND
          COALESCE(${formatted_postal_code},"") = "" AND
          COALESCE(${dim_party_locale.party_mailing_address_country__name}, "") = ""
          THEN ""
          ELSE
          CONCAT(
          CASE WHEN ((${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME IS NULL) OR (${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME = ""))
          THEN ""
          ELSE
          CONCAT(CASE WHEN ${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER IS NULL THEN "" ELSE CONCAT(${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER, "-") END,
          COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NUMBER, ""), " ",
          COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME), ""),", ")
          END,
          CASE WHEN ((${TABLE}.PARTY_MAILING_ADDRESS_CITY IS NULL) OR (UPPER(${TABLE}.PARTY_MAILING_ADDRESS_CITY)) = "UNKNOWN") THEN ""
          ELSE
          CONCAT(COALESCE(INITCAP(${TABLE}.PARTY_MAILING_ADDRESS_CITY), ""), ", ")
          END,
          CASE WHEN ((${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE IS NULL) OR (UPPER(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE) = "XIN")) THEN ""
          ELSE
          CONCAT(COALESCE(${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE, ""), ", ")
          END,
          CASE WHEN ((${formatted_postal_code} IS NULL) OR (${formatted_postal_code} = "")) THEN ""
          ELSE CONCAT(${formatted_postal_code}," ")
          END,
          COALESCE(${dim_party_locale.party_mailing_address_country__name}, "")
          )
          END;;
  }


#  dimension: party_address_filter {
#    type: string
#    sql: ARRAY_TO_STRING([${TABLE}.PARTY_MAILING_ADDRESS_APT_NUMBER,${TABLE}.PARTY_MAILING_ADDRESS_STREET_NUMBER ,
#      ${TABLE}.PARTY_MAILING_ADDRESS_STREET_NAME,
#      ${TABLE}.PARTY_MAILING_ADDRESS_CITY,${TABLE}.PARTY_MAILING_ADDRESS_PROVINCE,${TABLE}.PARTY_MAILING_ADDRESS_POSTAL_CODE,
#      ${dim_party_locale.party_mailing_address_country__name}
#      ],' ') ;;
#  }
  measure: last_day_change_amt {
    type: number
    sql: (${fact_holdng_rr.aua_converted_to_cad} - ${fact_holdng_rr_prev_day.aua_converted_to_cad}) ;;
  }

  measure: last_day_change_amt_pct {
    type: number
    sql:  case when (${fact_holdng_rr.aua_converted_to_cad} - ${last_day_change_amt}) !=0
              then (${last_day_change_amt}/(${fact_holdng_rr.aua_converted_to_cad} - ${last_day_change_amt}))
              else 0
              end ;;
  }

  measure: acct_type_and_number_list {
    type: string
    description: "Account Type and Number List"
    sql: (STRING_AGG(DISTINCT ${dim_accnt.acct_type_and_number},", " order by ${dim_accnt.acct_type_and_number}) ) ;;
  }

  dimension: party_preferred_language {
    type: string
    description: "Party Preferred Language"
    sql: ${dim_party_locale.party_preferred_language__name} ;;
  }

  dimension: party_gender {
    type: string
    description: "Party Gender"
    sql: ${dim_party_locale.party_gender__name} ;;
  }

  dimension: party_citizenship {
    type: string
    description: "Party Citizenship"
    sql:  ${TABLE}.PARTY_CITIZENSHIP  ;;
  }

  dimension: party_citizenship_name {
    type: string
    description: "Party Citizenship"
    sql: ${dim_party_locale.party_citizenship__name} ;;
  }

  dimension: party_marital_status {
    type: string
    description: "Party Marital Status"
    sql: ${dim_party_locale.party_marital_status__name} ;;
  }

  dimension: party_investment_knowledge {
    type: string
    description: "Party Investment knowledge"
    sql: ${TABLE}.PARTY_INVESTMENT_KNOWLEDGE ;;
  }

  dimension: party_investment_knowledge_desc_name {
    type: string
    description: "Party Investment knowledge Name"
    sql: ${dim_party_locale.party_investment_knowledge_desc__name} ;;
  }

  dimension: party_type {
    type: string
    description: "1 = Individual, 2 = Organization"
    sql: ${TABLE}.PARTY_TYPE ;;
  }

  dimension: party_type_name {
    type: string
    description: "1 = Individual, 2 = Organization in Locale"
    sql: ${dim_party_locale.party_type__name} ;;
  }

  dimension: party_age {
    type:  number
    description: "Party Age"
    value_format: "###"
    #sql:CASE WHEN ${party_date_of_birth_date} IS NULL THEN 0
    #ELSE DATE_DIFF(CURRENT_DATE, ${party_date_of_birth_date}, YEAR)   END;;
    sql:CASE WHEN ${party_date_of_birth_date} IS NULL THEN 0
          ELSE DATE_DIFF(CURRENT_DATE,${party_date_of_birth_date}, YEAR) -
          IF(EXTRACT(MONTH FROM ${party_date_of_birth_date})*100 + EXTRACT(DAY FROM ${party_date_of_birth_date}) >
          EXTRACT(MONTH FROM CURRENT_DATE)*100 + EXTRACT(DAY FROM CURRENT_DATE),1,0) END;;
  }

  dimension: age {  # calculating age without replacing NULL with 0.
    type:  number
    description: "Party Age"
    value_format: "###"
    sql:DATE_DIFF(CURRENT_DATE,${party_date_of_birth_date}, YEAR) -
          IF(EXTRACT(MONTH FROM ${party_date_of_birth_date})*100 + EXTRACT(DAY FROM ${party_date_of_birth_date}) >
          EXTRACT(MONTH FROM CURRENT_DATE)*100 + EXTRACT(DAY FROM CURRENT_DATE),1,0) ;;
  }



  measure: party_age_asof_prev_year {
    type: max
    value_format: "#,##0"
    description: "Party Age as of Previous Year"
    sql: CASE WHEN ${fact_rel_accnt_party.rolenumber} in (11,21,31) THEN
          CASE WHEN ${party_age} = 0  OR ${party_date_of_birth_date} IS NULL THEN 0
            ELSE DATE_DIFF(LAST_DAY(DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR)), ${party_date_of_birth_date}, YEAR) END
            ELSE 0 END;;
  }

  dimension: power_of_attornet_name {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.POWER_OF_ATTORNET_FIRST_NAME,${TABLE}.POWER_OF_ATTORNET_LAST_NAME],' ') ;;
  }

  dimension: trusted_contact_name {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.TRUSTED_CONTACT_FIRST_NAME,${TABLE}.TRUSTED_CONTACT_LAST_NAME],' ');;
  }

  dimension: party_legal_name {
    type: string
    sql:  CASE
          WHEN ${party_type} = '1' THEN ARRAY_TO_STRING([${TABLE}.PARTY_FIRST_LEGAL_NAME ,${TABLE}.PARTY_MIDDLE_LEGAL_NAME,
                                    ${TABLE}.PARTY_LAST_LEGAL_NAME],' ')
          WHEN ${party_type}  = '2' THEN ${TABLE}.PARTY_ORGANIZATION_NAME
        ELSE
        'Unknown'
      END ;;
  }

  dimension: party_residential_address {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.PARTY_RESIDENTIAL_ADDRESS_APT_NUMBER,${TABLE}.PARTY_RESIDENTIAL_ADDRESS_STREET_NUMBER ,
      ${TABLE}.PARTY_RESIDENTIAL_ADDRESS_STREET_NAME,CHR(13),
      ${TABLE}.PARTY_RESIDENTIAL_ADDRESS_CITY,${TABLE}.PARTY_RESIDENTIAL_ADDRESS_PROVINCE,${TABLE}.PARTY_RESIDENTIAL_ADDRESS_POSTAL_CODE,CHR(13),
      ${dim_party_locale.party_residential_address_country__name}
      ],' ') ;;
  }

  dimension: party_trusted_contact_address {
    type: string
    sql: ARRAY_TO_STRING([${TABLE}.TRUSTED_CONTACT_ADDRESS_APT_NUMBER,${TABLE}.TRUSTED_CONTACT_ADDRESS_STREET_NUMBER ,
      ${TABLE}.TRUSTED_CONTACT_ADDRESS_STREET_NAME,CHR(13),
      ${TABLE}.TRUSTED_CONTACT_ADDRESS_CITY,${TABLE}.TRUSTED_CONTACT_ADDRESS_PROVINCE,${TABLE}.TRUSTED_CONTACT_ADDRESS_POSTAL_CODE,CHR(13),
      ${dim_party_locale.trusted_contact_address_country__name}
      ],' ') ;;
  }



  dimension: advisor_interest {
    type: string
    description: "Advisor Interest"
    sql: ${TABLE}.ADVISOR_INTEREST ;;
  }

  dimension: advisor_interest_details {
    type: string
    description: "(Advisor Interest) details"
    sql: ${TABLE}.ADVISOR_INTEREST_DETAILS ;;
  }

  dimension: amount_borrowed {
    type: string
    description: "Amount borrowed"
    sql: ${TABLE}.AMOUNT_BORROWED ;;
  }

  dimension: borrowed_to_invest {
    type: string
    description: "Borrowed to Invest"
    sql: ${TABLE}.BORROWED_TO_INVEST ;;
  }

  dimension: controlling_interest {
    type: string
    description: "Controlling Interest"
    sql: ${TABLE}.CONTROLLING_INTEREST ;;
  }

  dimension_group: consent_marketing_status_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONSENT_MARKETING_STATUS_DT ;;
  }

  dimension: consent_marketing_ind {
    type: yesno
    sql: ${TABLE}.CONSENT_MARKETING_IND ;;
  }

  dimension_group: consent_sollicitation_status_dt {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.CONSENT_SOLLICITATION_STATUS_DT ;;
  }

  dimension: consent_sollicitation_ind {
    type: yesno
    sql: ${TABLE}.CONSENT_SOLLICITATION_IND ;;
  }

  dimension: current_party_approx_annual_income {
    type: number
    description: "Current Party approx. annual income"
    sql: ${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME ;;
  }

  dimension: does_anyone_else_have_trading_authority {
    type: string
    description: "Does anyone else have trading authority"
    sql: ${TABLE}.DOES_ANYONE_ELSE_HAVE_TRADING_AUTHORITY ;;
  }

  dimension: domestic_pep {
    type: string
    description: "Domestic PEP"
    sql: ${TABLE}.DOMESTIC_PEP ;;
  }

  dimension: financial_interest_exists {
    type: yesno
    description: "Financial Interest exists?"
    sql: CASE WHEN coalesce(trim(${TABLE}.FINANCIAL_INTEREST),"") = ""  THEN false ELSE true END;;
  }

  dimension: financial_interest_name {
    type: string
    description: "Financial Interest Name"
    sql: ${TABLE}.FINANCIAL_INTEREST ;;
  }

  dimension: foreign_pep_politically_exposed_persons {
    type: string
    description: "Foreign PEP (Politically Exposed Persons)"
    sql: ${TABLE}.FOREIGN_PEP_POLITICALLY_EXPOSED_PERSONS ;;
  }

  dimension: head_of_international_organization_y_n {
    type: string
    description: "Head of International Organization (Y/N)"
    sql: ${TABLE}.HEAD_OF_INTERNATIONAL_ORGANIZATION_Y_N ;;
  }

  dimension: in_person_documents_reviewed {
    type: string
    description: "In Person - Documents Reviewed"
    sql: ${TABLE}.IN_PERSON_DOCUMENTS_REVIEWED ;;
  }

  dimension: is_party_pro {
    type: yesno
    description: "Is Party Pro"
    sql: ${TABLE}.IS_PARTY_PRO ;;
  }

  dimension: is_pep {
    type: yesno
    description: "Is Pep"
    sql: ${TABLE}.IS_PEP ;;
  }

  dimension: joint_with_the_right_of_survivorship {
    type: string
    description: "Joint with the right of survivorship"
    sql: ${TABLE}.JOINT_WITH_THE_RIGHT_OF_SURVIVORSHIP ;;
  }

  dimension: lending_institution {
    type: string
    description: "Lending institution"
    sql: ${TABLE}.LENDING_INSTITUTION ;;
  }

  dimension: md_active {
    type: yesno
    hidden: yes
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }

  dimension: nk_hk_dim_party_str {
    type: string
    description: "MD_HASH_NAT_KEYS"
    value_format: "0"
    sql: CAST(${TABLE}.MD_HASH_NAT_KEYS AS STRING) ;;
  }

  dimension: nk_hk_dim_party {
    type: number
    description: "MD_HASH_NAT_KEYS"
    value_format: "0"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }



  dimension: name_of_firms_where_other_accounts_are_held {
    type: string
    description: "Name of firms where other accounts are held"
    sql: ${TABLE}.NAME_OF_FIRMS_WHERE_OTHER_ACCOUNTS_ARE_HELD ;;
  }

  dimension: party_accounts_with_other_firms {
    type: string
    description: "Party Accounts with other firms"
    sql: ${TABLE}.PARTY_ACCOUNTS_WITH_OTHER_FIRMS ;;
  }

  dimension: party_assets_combined_with_spouse {
    type: string
    description: "Party Assets combined with spouse"
    sql: ${TABLE}.PARTY_ASSETS_COMBINED_WITH_SPOUSE ;;
  }

  dimension: party_bank_account_name {
    type: string
    description: "Party bank account Name"
    sql: ${TABLE}.PARTY_BANK_ACCOUNT_NAME ;;
  }

  dimension: party_bank_transit_no {
    type: string
    description: "Party Bank Transit No"
    sql: ${TABLE}.PARTY_BANK_TRANSIT_NO ;;
  }


  dimension_group: party_date_of_birth {
    type: time
    description: "Party Date of Birth"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PARTY_DATE_OF_BIRTH ;;
  }



  dimension: party_delivery_mode_code {
    type: string
    description: "PARTY_DELIVERY_MODE_CODE"
    sql: ${TABLE}.PARTY_DELIVERY_MODE_CODE ;;
  }

  dimension: party_employer_address {
    type: string
    description: "Party Employer Address"
    sql: ${TABLE}.PARTY_EMPLOYER_ADDRESS ;;
  }

  dimension: party_employer_name {
    type: string
    description: "Party Employer Name"
    sql: ${TABLE}.PARTY_EMPLOYER_NAME ;;
  }

  dimension: party_employment_status {
    type: string
    description: "Party Employment Status"
    sql: ${dim_party_locale.party_employment_status__name} ;;
  }

  dimension: party_employment_type {
    type: string
    description: "Party Employment Type"
    sql: ${TABLE}.PARTY_EMPLOYMENT_TYPE ;;
  }

  dimension: party_estimated_net_fixed_assets {
    type: string
    description: "Party Estimated Net Fixed Assets"
    sql: ${TABLE}.PARTY_ESTIMATED_NET_FIXED_ASSETS ;;
  }

  dimension: party_estimated_net_liquid_assets {
    type: string
    description: "Party Estimated Net Liquid Assets"
    sql: ${TABLE}.PARTY_ESTIMATED_NET_LIQUID_ASSETS ;;
  }

  dimension: party_estimated_total_net_worth {
    type: string
    description: "Party Estimated Total Net Worth"
    sql: ${TABLE}.PARTY_ESTIMATED_TOTAL_NET_WORTH ;;
  }



  dimension: party_id {
    type: string
    description: "Party ID"
    sql: ${TABLE}.PARTY_ID ;;
  }



  dimension: party_number_of_dependents {
    type: number
    description: "Party Number of Dependents"
    sql: ${TABLE}.PARTY_NUMBER_OF_DEPENDENTS ;;
  }


  measure: total_party_number_of_dependents {
    type: sum
    sql: ${party_number_of_dependents} ;;  }
  measure: average_party_number_of_dependents {
    type: average
    sql: ${party_number_of_dependents} ;;  }

  dimension: party_occupation {
    type: string
    description: "Party Occupation"
    sql: ${TABLE}.PARTY_OCCUPATION ;;
  }

  dimension: party_organization_can_entreprise_num {
    type: string
    description: "Party Organization CAN Entreprise Num"
    sql: ${TABLE}.PARTY_ORGANIZATION_CAN_ENTREPRISE_NUM ;;
  }



  dimension: party_organization_qc_entreprise_num {
    type: string
    description: "Party Organization QC Entreprise Num"
    sql: ${TABLE}.PARTY_ORGANIZATION_QC_ENTREPRISE_NUM ;;
  }

  dimension: party_organization_type {
    type: string
    description: "Party Organization Type"
    sql: ${TABLE}.PARTY_ORGANIZATION_TYPE ;;
  }

  dimension: party_phone_extension {
    type: string
    description: "Party Phone Extension"
    sql: ${TABLE}.PARTY_PHONE_EXTENSION ;;
  }

  dimension: party_phone_type {
    type: string
    description: "Party Phone Type"
    sql: ${TABLE}.PARTY_PHONE_TYPE ;;
  }



  dimension: party_primary_email {
    type: string
    description: "Party Primary Email"
    sql: ${TABLE}.PARTY_PRIMARY_EMAIL ;;
  }

  dimension: party_primary_phone {
    type: string
    description: "Party Primary Phone"
    sql: ${TABLE}.PARTY_PRIMARY_PHONE ;;
  }

  dimension: formatted_party_primary_phone {
    type: string
    description: "Party Primary Phone"
    sql: CASE WHEN LENGTH(${TABLE}.PARTY_PRIMARY_PHONE) = 10
          THEN CONCAT("(",SUBSTR(${TABLE}.PARTY_PRIMARY_PHONE,1,3), ") ", SUBSTR(${TABLE}.PARTY_PRIMARY_PHONE,4,3), "-", SUBSTR(${TABLE}.PARTY_PRIMARY_PHONE,7,4))
          ELSE
          ${TABLE}.PARTY_PRIMARY_PHONE
          END;;
  }

  dimension: party_secondary_phone {
    type: string
    description: "Party Secondary Phone"
    sql: ${TABLE}.PARTY_SECONDARY_PHONE ;;
  }

  dimension: formatted_party_secondary_phone {
    type: string
    description: "Party Secondary Phone"
    sql: CASE WHEN LENGTH(${TABLE}.PARTY_SECONDARY_PHONE) = 10
          THEN CONCAT("(",SUBSTR(${TABLE}.PARTY_SECONDARY_PHONE,1,3), ") ", SUBSTR(${TABLE}.PARTY_SECONDARY_PHONE,4,3), "-", SUBSTR(${TABLE}.PARTY_SECONDARY_PHONE,7,4))
          ELSE
          ${TABLE}.PARTY_SECONDARY_PHONE
          END;;
  }

  dimension: party_sin {
    type: number
    value_format: "###-###-###"
    description: "Party SIN"
    sql: ${TABLE}.PARTY_SIN ;;
  }

  dimension_group: party_spouse_date_of_birth {
    type: time
    description: "Party Spouse Date of Birth"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PARTY_SPOUSE_DATE_OF_BIRTH ;;
  }

  dimension: party_spouse_name {
    type: string
    description: "Party Spouse Name"
    sql: ${TABLE}.PARTY_SPOUSE_NAME ;;
  }

  dimension: party_spouse_sin {
    type: number
    value_format: "###-###-###"
    description: "Party Spouse SIN"
    sql: ${TABLE}.PARTY_SPOUSE_SIN ;;
  }

  dimension: party_title {
    type: string
    description: "Party Title"
    sql: ${TABLE}.PARTY_TITLE ;;
  }



  dimension: pep_details {
    type: string
    description: "PEP Details"
    sql: ${TABLE}.PEP_DETAILS ;;
  }



  dimension: receiving_security_holder_materials {
    type: string
    description: "Receiving Security Holder Materials"
    sql: ${TABLE}.RECEIVING_SECURITY_HOLDER_MATERIALS ;;
  }

  dimension: reporting_insider {
    type: string
    description: "Reporting Insider"
    sql: ${TABLE}.REPORTING_INSIDER ;;
  }

  dimension: struct_related_party {
    hidden: yes
    sql: ${TABLE}.STRUCT_RELATED_PARTY ;;
  }

  dimension: tenants_in_common {
    type: string
    description: "Tenants in Common"
    sql: ${TABLE}.TENANTS_IN_COMMON ;;
  }

  dimension: trading_authority_account_number {
    type: string
    description: "(trading authority) Account Number"
    sql: ${TABLE}.TRADING_AUTHORITY_ACCOUNT_NUMBER ;;
  }

  dimension: trading_authority_name {
    type: string
    description: "(trading authority) Name"
    sql: ${TABLE}.TRADING_AUTHORITY_NAME ;;
  }


  dimension: trusted_contact_email {
    type: string
    description: "Trusted Contact Email"
    sql: ${TABLE}.TRUSTED_CONTACT_EMAIL ;;
  }

  dimension: trusted_contact_extension {
    type: string
    description: "Trusted Contact Extension"
    sql: ${TABLE}.TRUSTED_CONTACT_EXTENSION ;;
  }



  dimension: trusted_contact_phone_type {
    type: string
    description: "Trusted Contact Phone Type"
    sql: ${TABLE}.TRUSTED_CONTACT_PHONE_TYPE ;;
  }

  dimension: trusted_contact_primary_phone {
    type: string
    description: "Trusted Contact Primary Phone"
    sql: ${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE ;;
  }

  dimension: formatted_trusted_contact_primary_phone {
    type: string
    description: "Trusted Contact Primary Phone"
    sql: CASE WHEN LENGTH(${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE) = 10
          THEN CONCAT("(",SUBSTR(${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE,1,3), ") ", SUBSTR(${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE,4,3), "-", SUBSTR(${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE,7,4))
          ELSE
          ${TABLE}.TRUSTED_CONTACT_PRIMARY_PHONE
          END;;
  }

  dimension: trusted_contact_relationship {
    type: string
    description: "Trusted Contact Relationship"
    sql: ${TABLE}.TRUSTED_CONTACT_RELATIONSHIP ;;
  }

  dimension: verification_type {
    type: string
    description: "Verification Type"
    sql: ${TABLE}.VERIFICATION_TYPE ;;
  }

  dimension: year_party_opened_first_account {
    type: number
    value_format: "0"
    description: "Year Party Opened First Account"
    sql: ${TABLE}.YEAR_PARTY_OPENED_FIRST_ACCOUNT ;;
  }

  dimension: years_of_investment_experience {
    type: string
    description: "Years of investment experience"
    sql: ${dim_party_locale.years_of_investment_experience__name} ;;
  }

  dimension: is_registered_to_client_portal {  ### new column added as its required for Ax360 development
    type: yesno
    sql: ${TABLE}.IS_REGISTERED_TO_CLIENT_PORTAL ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [

      # party_last_preferred_name,
      # party_first_preferred_name,
      party_employer_name,
      party_bank_account_name,
      trading_authority_name,
      # party_middle_preferred_name,
#  trusted_contact_first_name,
      #party_middle_legal_name,
#  party_last_legal_name,
      party_spouse_name,
      # party_mailing_address_street_name,
#  party_first_legal_name,
      # party_residential_address_street_name,
      #trusted_contact_address_street_name,
      # power_of_attornet_first_name,
      #trusted_contact_last_name,
      #party_organization_name,
      # power_of_attornet_last_name
    ]
  }

##################### ACCENTURE CODE ENDS HERE ############################################
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }
# Here's what a typical dimension looks like in LookML.
# A dimension is a groupable field that can be used to filter query results.
# This dimension will be called "Advisor Interest" in Explore.


### Quantiphi area starts here


  dimension: new_client_ind {  # Yes/No field to check whether client has created  his/her first account within the last 12 months from the latest business day or not.(i.e.New Client)
    label: "New Client Indicator"
    type: yesno
    sql: date_sub( ${last_holding_date.last_update_date}, INTERVAL 12 month)+1 <= ${new_clients.new_client_recruitment_dt};;
  }

  dimension: lost_client_ind {  # Yes/No field to check whether client has closed all of his/her accounts within the last 12 Months from the latest business day.(i.e.Lost Client)
    label: "Lost Client Indicator"
    type: yesno
    sql:  date_sub( ${last_holding_date.last_update_date}, INTERVAL 12 month)+1 <= ${lost_clients.lost_client_departure_dt};;
  }

measure: total_clients { #Total number of active clients
  type: number
  # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
  sql: count(distinct case when ${dim_accnt.account_status_level_1_without_locale} = "Open" then ${dim_party.party_id} end) ;;
}

measure: total_client_pct {
  type: percent_of_total
  sql: ${total_clients} ;;
  value_format: "0.00\%"
}

  measure: lost_client_count {  #Total number of lost clients
    label: "Total Lost Clients"
    type: count_distinct
    sql: ${dim_party.party_id} ;;
    filters: [lost_client_ind: "Yes"]
  }

measure: new_client_count { #Total number of new clients
  label: "Total New Clients"
  type: number
  # 1168403-changes-for-j-and-closed-accounts: Added the condition as per the requirement
  sql: count(distinct (case when ${new_client_ind} then ${dim_party.party_id} end)) ;;
}

  dimension: current_party_approx_annual_income_hidden {
    type: string
    hidden: yes
    description: "Handling special cases in format"
    sql: if(LEFT(if(CONTAINS_SUBSTR(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/'),if(safe_cast((split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(0)]) as float64) is null,${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(1)]),${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME), 1)='.',SUBSTR(REPLACE(REPLACE(REPLACE(REPLACE(if(CONTAINS_SUBSTR(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/'),if(safe_cast((split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(0)]) as float64) is null,${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(1)]),${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME),'EU',''),'E','K'),'L','K'),'F','K'), 2),REPLACE(REPLACE(REPLACE(REPLACE(if(CONTAINS_SUBSTR(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/'),if(safe_cast((split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(0)]) as float64) is null,${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,split(${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME,'/')[OFFSET(1)]),${TABLE}.CURRENT_PARTY_APPROX_ANNUAL_INCOME),'EU',''),'E','K'),'L','K'),'F','K'))  ;;
  }

  dimension: current_party_approx_annual_income_numeric {  #Income converted in numeric
    type: number
    description: "Current Party approx. annual income"
    sql: ${current_party_approx_annual_income};;
  }

#Revenue open account filter
  measure: avg_age {
    label: "Age"
    type: average
    sql: ${age} ;;
    value_format: "#,##0"
    filters: [dim_accnt.account_status_level_1_without_locale: "Open"]
  }

  measure: average_client_age {
    label: "average_client_age"
    type: string
    sql: coalesce(cast(round(${avg_age}) as string), "{{ _localization['not_available'] }}" );;
  }

#address related fields
  dimension: party_mailing_address_street_number {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_street_number, "") ;;
  }

  dimension: party_mailing_address_street_name {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_street_name, "") ;;
  }

  dimension: party_mailing_address_city {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_city, "") ;;
  }

  dimension: party_mailing_address_province {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_province, "") ;;
  }

  dimension: party_mailing_address_country {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_country, "") ;;
  }

  dimension: party_mailing_address_postal_code {
    type: string
    sql: COALESCE(${formatted_postal_code},"") ;;
  }

  dimension: party_mailing_address_apt_number {
    type: string
    sql: COALESCE(${TABLE}.party_mailing_address_apt_number, "") ;;
  }

  dimension: party_mailing_address_country_name {
    type: string
    sql: COALESCE(${dim_party_locale.party_mailing_address_country__name}, "") ;;
  }

  # 1154400 - added the following field to add multifilter client and household in the Access Portal API explore
  measure: addresses {
    type: string
    label: "Address"
    sql: (STRING_AGG(DISTINCT ${dim_party.party_address_one_line}, ", " order by ${dim_party.party_address_one_line}))  ;;
  }

  ## Quantiphi area ends here
}

# The name of this view in Looker is "Dim Party Struct Related Party"

view: dim_party__struct_related_party {

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Addresstype" in Explore.

  dimension: addresstype {
    type: string
    sql: ${TABLE}.ADDRESSTYPE ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.CITY ;;
  }

  dimension: civicnumber {
    type: string
    sql: ${TABLE}.CIVICNUMBER ;;
  }

  dimension: civicnumbersuffix {
    type: string
    sql: ${TABLE}.CIVICNUMBERSUFFIX ;;
  }

  dimension: countrycode {
    type: string
    sql: ${TABLE}.COUNTRYCODE ;;
  }
  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: dateofbirth {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATEOFBIRTH ;;
  }
  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: dim_party__struct_related_party {
    type: string
    description: "Related Party Information"
    hidden: yes
    sql: ${TABLE}.dim_party__struct_related_party ;;
  }

  dimension: doctype {
    type: number
    sql: ${TABLE}.DOCTYPE ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_doctype {
    type: sum
    sql: ${doctype} ;;  }
  measure: average_doctype {
    type: average
    sql: ${doctype} ;;  }

  dimension: emailaddress {
    type: string
    sql: ${TABLE}.EMAILADDRESS ;;
  }

  dimension: extension {
    type: string
    sql: ${TABLE}.EXTENSION ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.FIRSTNAME ;;
  }

  dimension: id_related_party {
    type: number
    sql: ${TABLE}.ID_RELATED_PARTY ;;
  }

  dimension: ispoasigning {
    type: yesno
    sql: ${TABLE}.ISPOASIGNING ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.LASTNAME ;;
  }

  dimension: power_of_attorney_name  {
    type: string
    sql: ARRAY_TO_STRING([${firstname}, ${lastname}],' ') ;;
  }

  dimension: majorsort {
    type: number
    sql: ${TABLE}.MAJORSORT ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.NAME ;;
  }

  dimension: otherrelationshipdesc {
    type: string
    sql: ${TABLE}.OTHERRELATIONSHIPDESC ;;
  }

  dimension: phonenumber {
    type: string
    sql: ${TABLE}.PHONENUMBER ;;
  }

  dimension: phonetype {
    type: string
    sql: ${TABLE}.PHONETYPE ;;
  }

  dimension: postalcode {
    type: string
    sql: ${TABLE}.POSTALCODE ;;
  }

  dimension: provincecode {
    type: string
    sql: ${TABLE}.PROVINCECODE ;;
  }

  dimension: related_party_role {
    type: string
    sql: ${TABLE}.RELATED_PARTY_ROLE ;;
  }

  dimension: sin {
    type: string
    sql: ${TABLE}.SIN ;;
  }

  dimension: stationname {
    type: string
    sql: ${TABLE}.STATIONNAME ;;
  }

  dimension: stationtype {
    type: string
    sql: ${TABLE}.STATIONTYPE ;;
  }

  dimension: streetname {
    type: string
    sql: ${TABLE}.STREETNAME ;;
  }

  dimension: streettype {
    type: string
    sql: ${TABLE}.STREETTYPE ;;
  }

  dimension: unitnumber {
    type: string
    sql: ${TABLE}.UNITNUMBER ;;
  }

  dimension: unittype {
    type: string
    sql: ${TABLE}.UNITTYPE ;;
  }

  dimension: cocantidname {
    type: string
    sql: concat(${dim_party.party_type}," - ",${dim_party.party_name}) ;;
  }

  dimension: arraylisttest {
    type: string
    sql: ARRAY_AGG( ${cocantidname} ORDER BY ${cocantidname}) ;;
  }

  ## Quantiphi area ends here
}
