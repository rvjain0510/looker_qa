view: dim_party_locale {

  derived_table: {
    datagroup_trigger: data_platform_load
    sql: select * from `@{bq_project_id}.@{bq_dataset_name}.DIM_PARTY_LOCALE` ;;
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

  dimension: nk_hk_dim_party {
    type: number
    value_format: "0"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: party_citizenship__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_CITIZENSHIP.NAME ;;
    group_label: "Party Citizenship"
    group_item_label: "Name"
  }


  dimension: party_gender__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_GENDER.NAME ;;
    group_label: "Party Gender"
    group_item_label: "Name"
  }


  dimension: party_investment_knowledge_desc__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_INVESTMENT_KNOWLEDGE_DESC.NAME ;;
    group_label: "Party Investment Knowledge Desc"
    group_item_label: "Name"
  }



  dimension: party_mailing_address_country__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_MAILING_ADDRESS_COUNTRY.NAME ;;
    group_label: "Party Mailing Address Country"
    group_item_label: "Name"
  }



  dimension: party_marital_status__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_MARITAL_STATUS.NAME ;;
    group_label: "Party Marital Status"
    group_item_label: "Name"
  }


  dimension: party_preferred_language__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_PREFERRED_LANGUAGE.NAME ;;
    group_label: "Party Preferred Language"
    group_item_label: "Name"
  }



  dimension: party_residential_address_country__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_RESIDENTIAL_ADDRESS_COUNTRY.NAME ;;
    group_label: "Party Residential Address Country"
    group_item_label: "Name"
  }


  dimension: party_type__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_TYPE.NAME ;;
    group_label: "Party Type"
    group_item_label: "Name"
  }

  dimension: trusted_contact_address_country__name {
    type: string
    hidden: yes
    sql: ${TABLE}.TRUSTED_CONTACT_ADDRESS_COUNTRY.NAME ;;
    group_label: "Trusted Contact Address Country"
    group_item_label: "Name"
  }


  dimension: party_employment_status__name {
    type: string
    hidden: yes
    sql: ${TABLE}.PARTY_EMPLOYMENT_STATUS.NAME ;;
    group_label: "Party Employment Status"
    group_item_label: "Name"
  }

  dimension: years_of_investment_experience__name {
    type: string
    hidden: yes
    sql: ${TABLE}.YEARS_OF_INVESTMENT_EXPERIENCE.NAME ;;
    group_label: "Years of Investment Experience"
    group_item_label: "Name"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  party_type__name,
  party_gender__name,
  #party_type__shrt_name,
  #party_gender__shrt_name,
  #party_investment_knowledge_desc__name,
  #party_investment_knowledge_desc__shrt_name
  ]
  }

}
