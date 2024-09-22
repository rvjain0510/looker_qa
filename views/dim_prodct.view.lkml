view: dim_prodct {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_PRODCT_MV` ;;

  dimension: prodct_symbl {
    type: string
    description: "Product Symbol"
    sql: ${TABLE}.PRODCT_SYMBL ;;
  }

  dimension: prodct_desc {  ## 1282444 - Localization is not working for Product Description in API Explores
    type: string
    description: "Product Description"
    sql:  case when ${language.is_lang_pref_fr}='Yes' then ${prodct_desc_fr}
          else ${prodct_desc_en}
          end ;;
  }

  dimension: price_currnc {
    type: string
    description: "Price Currency"
    sql: ${TABLE}.PRICE_CURRENCY ;;
  }

  dimension: cusip {
    type: string
    description: "CUSIP"
    sql: ${TABLE}.CUSIP ;;
  }


  dimension: issuer {
    type: string
    description: "Issuer"
    sql: ${TABLE}.ISSUER ;;
  }

  dimension: md_active {
    type: yesno
    description: "MD_ACTIVE"
    sql: ${TABLE}.MD_ACTIVE ;;
  }



  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: prodct_altrnt_class {
    type: string
    description: "Product Alternate Class"
    sql: ${TABLE}.PRODCT_ALTRNT_CLASS ;;
  }

  dimension: prodct_altrnt_symbl {
    type: string
    description: "Product Alternate Symbol"
    sql: ${TABLE}.PRODCT_ALTRNT_SYMBL ;;
  }

  dimension: prodct_altrnt_tp {
    type: string
    description: "Product Alternate Type"
    sql: ${TABLE}.PRODCT_ALTRNT_TP ;;
  }

  dimension: prodct_class {
    type: string
    description: "Product Class"
    sql: ${TABLE}.PRODCT_CLASS ;;
  }

  dimension: prodct_id {
    type: string
    description: "Product Id"
    sql: ${TABLE}.PRODCT_ID ;;
  }

  dimension: prodct_tp {
    type: string
    description: "Product Type"
    sql: ${TABLE}.PRODCT_TP ;;
  }

  dimension: prodct_tp_name {
    type: string
    description: "Product Type"
    sql: ${dim_prodct_locale.prodct_tp__name} ;;
  }

  dimension: product_long_description {
    type: string
    description: "Product Long Description"
    sql: ${TABLE}.PRODUCT_LONG_DESCRIPTION ;;
  }

###1118547 - Add Product Long Description to Looker Model(Added new dimension for french version)

  dimension: product_long_description_fr {
    type: string
    description: " French Product Long Description "
    sql: ${TABLE}.PRODUCT_LONG_DESCRIPTION_FR ;;
  }

  dimension_group: product_maturity {
    type: time
    description: "Account Close Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: cast(${TABLE}.PRODUCT_MATURITY as date) ;;
  }

  dimension: prodct_desc_fr {
    type: string
    sql: ${TABLE}.PRODCT_DESC_FR ;;
  }

  dimension: prodct_desc_en {
    type: string
    sql: ${TABLE}.PRODCT_DESC_EN ;;
  }

  dimension: traded_market {
    type: string
    sql: ${TABLE}.TRADED_MARKET ;;
  }

  dimension: traded_symbol {
    type: string
    sql: ${TABLE}.TRADED_SYMBOL ;;
  }

  measure: count {
    type: count
  }

######################### ACCENTURE CODE ENDS HERE ##########################################
  dimension: id {
    primary_key: yes
    type: number
    label: "ID"
    sql: ${TABLE}.ID ;;
  }

}