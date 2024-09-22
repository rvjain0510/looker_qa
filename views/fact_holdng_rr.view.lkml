view: fact_holdng_rr {

  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR` ;;


  parameter: year_filter {
    type: number
    description: "Year Filter"
    default_value: "2022"

  }

  dimension: balance_dt {
    type: date
    datatype: date
    description: "BALANCE_DT"
    sql: ${TABLE}.BALANCE_DT ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    description: "ID"
    sql: ${TABLE}.ID ;;
  }

  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }

  dimension: nk_hk_dim_prodct {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_PRODCT ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_REGSTR_REPRSNTTV ;;
  }

  dimension: seq_num {
    type: string
    description: "Sequence Number"
    sql: ${TABLE}.SEQ_NUM ;;
  }


  dimension: markt_pric {
    type: number
    value_format: "#,##0.000"
    description: "Market Price"
    sql: ${TABLE}.MARKT_PRIC ;;
  }

  dimension: markt_pric_holdng_currnc {
    type: number
    value_format: "#,##0.000"
    description: "Market Price in Holding Currency"
    sql: ${TABLE}.MARKT_PRIC_HOLDNG_CURRNC ;;
  }

  dimension: holdng_currnc {
    type: string
    description: "Holding Currency"
    sql: ${TABLE}.HOLDNG_CURRNC ;;
  }


  measure: accrued_interest {
    type: sum
    value_format: "#,##0.00"
    description: "Accrued Interest"
    sql: ${TABLE}.ACCRUED_INTEREST ;;
  }


  measure: aum {
    type: sum
    value_format: "#,##0.00"
    description: "AUM"
    sql: ${TABLE}.AUM ;;
  }


  measure: aum_ia {
    type: sum
    value_format: "#,##0.00"
    description: "AUM IA"
    sql: ${TABLE}.AUM_IA ;;
  }


  measure: book_cost {
    type: sum
    value_format: "#,##0.00"
    description: "Book Cost"
    sql: ${TABLE}.BOOK_COST ;;
  }


  measure: quantt_ttl {
    type: sum
    value_format: "#,##0.00"
    description: "Total Quantity"
    sql: ${TABLE}.QUANTT_TTL ;;
  }


  measure: book_cost_converted_cad {
    type: sum
    value_format: "#,##0.00"
    description: "Book Cost Converted CAD"
    sql: ${TABLE}.BOOK_COST_CONVERTED_CAD ;;
  }


  measure: cash_balnc {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Balance"
    sql: ${TABLE}.CASH_BALNC ;;
  }


  measure: cash_balnc_convrtd_cad {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Balance Converted CAD"
    sql: ${TABLE}.CASH_BALNC_CONVRTD_CAD ;;
  }


  measure: margin_converted_cad {
    type: sum
    value_format: "#,##0.00"
    description: "Margin Converted CAD"
    sql: ${TABLE}.MARGIN_CONVERTED_CAD ;;
  }


  measure: margn {
    type: sum
    value_format: "#,##0.00"
    description: "Margin"
    sql: ${TABLE}.MARGN ;;
  }


  measure: markt_val {
    type: sum
    value_format: "#,##0.00"
    description: "Total Market Value"
    sql: ${TABLE}.MARKT_VAL;;
  }

  measure: markt_val_convrtd_cad {
    type: sum
    description: "Total Market Value Converted CAD"
    value_format: "#,##0.00"

    sql: ${TABLE}.MARKT_VAL_CONVRTD_CAD;;
  }



  measure: quantity_sfk {
    type: sum
    value_format: "#,##0.000"
    description: "Quantity Safe Keeping "
    sql: ${TABLE}.QUANTITY_SFK ;;
  }


  measure: quantity_trd {
    type: sum
    value_format: "#,##0.000"
    description: "Quantity TRD"
    sql: ${TABLE}.QUANTITY_TRD ;;
  }


  measure: settlement_amount {
    type: sum
    value_format: "#,##0.00"
    description: "Settlement Amount"
    sql: ${TABLE}.SETTLEMENT_AMOUNT ;;
  }


  measure: aua_converted_to_cad{
    type: sum
    value_format: "#,##0.00"
    description: "AUA Converted to CAD"
    sql: ${TABLE}.AUA_CONVERTED_TO_CAD ;;
  }

  measure: aua_converted_to_cad_rounded_off{
    type: sum
    value_format: "#,##0.00"
    description: "AUA Converted to CAD"
    sql: ROUND(${TABLE}.AUA_CONVERTED_TO_CAD, 2) ;;
  }


  measure: aua_acct_curr{
    type: sum_distinct
    value_format: "#,##0.00"
    description: "AUA"
    sql_distinct_key: ${id};;
    sql: ${TABLE}.MARKT_VAL + ${TABLE}.CASH_BALNC + ${TABLE}.ACCRUED_INTEREST ;;
  }


  measure: avrg_unt_cost {
    type: number
    value_format: "#,##0.00"
    description: "Average Unit Cost"
    sql: CASE WHEN COALESCE(${quantt_ttl},0) = 0 THEN 0 ELSE (${book_cost} / ${quantt_ttl}) END ;;
  }


  measure: unrealized_gain_loss {
    type: number
    value_format: "#,##0.00"
    description: "Unrealized Gain Loss"
    sql: ${markt_val} - ${book_cost} ;;
  }


  measure: unrealized_gain_loss_pct {
    type: number
    value_format: "0.00%"
    description: "Unrealized Gain Loss Percentage"
    sql: CASE WHEN COALESCE(${book_cost},0) = 0 THEN 0 ELSE (${markt_val} - ${book_cost})/${book_cost} END;;
  }




####################### ACCENTURE CODE ENDS HERE  #######################################


 dimension_group: balance_dt {
  type: time
  timeframes: [raw, date, week, month, quarter, year,month_num,month_name]
  convert_tz: no
  datatype: date
  sql: ${TABLE}.BALANCE_DT ;;
  drill_fields: []
}

  dimension: aua_converted_to_cad_dim{
    type: number
    sql: ${TABLE}.AUA_CONVERTED_TO_CAD ;;
  }


dimension_group: last_12_months_trend { # used this measure in 'AUA Trend' look to show last 12 months including current month('Month to Date')
  type: time
  #description: "BALANCE_DT"
  timeframes: [raw, date, week, month, quarter, year,month_num,month_name]
  convert_tz: no
  datatype: date
  hidden: yes
  sql:  case when ${balance_dt} >=   DATE_SUB( ${last_holding_date.last_update_date}, INTERVAL 11 month) then ${balance_dt} end ;;
}


dimension: current_month_latest_business_day_flag {  # Yes/No field to check is latest business day of the Current Month or not
  label: "Is Latest Business day of the Current Month(Yes/No)"
  type: yesno
  sql: ${balance_dt} = ${last_holding_date.last_update_date} ;;
}

dimension: last_yr_latest_business_day_flag {   # Yes/No field to check is latest business day of this year the Current Month or not
  label: "Is Latest Business day of the Current Month (Last Year) (Yes/No)"
  type: yesno
  sql: ${balance_dt} = date_sub(${last_holding_date.last_update_date}, interval 1 year) ;;
}

measure: aua_converted_to_cad_current_month{  #Latest AUA
  type: sum
  sql: ${aua_converted_to_cad_dim} ;;
  filters: [current_month_latest_business_day_flag: "Yes"]
}

measure: aua_converted_to_cad_current_month_new_clients{  #total AUA for latest business day for accounts having new clients
    type: sum
    sql: ${aua_converted_to_cad_dim} ;;
    filters: [current_month_latest_business_day_flag: "Yes",new_client_recruitment_period.accnt_with_new_client_ind: "Yes"]
}

dimension: last_business_day_last_year {          #this will give the 31st dec of last year
  # hidden: yes
  type: date
  sql:  case when (extract(month from ${balance_dt})=12 and
    extract(year from ${balance_dt})= extract(year from date_sub(${last_holding_date.last_update_date},interval 1 year))) then ${balance_dt} end;;
}

dimension: is_last_business_day_last_year_flag { # Yes/No field to check latest business day of the Current Month in the last year
  type: yesno
  sql: ${last_business_day_last_year}=${balance_dt} ;;
}

  dimension: is_same_day_ly {
    label: "Is Same Day in Last Year"
    hidden: yes
    type: yesno
    sql: date_sub( ${last_holding_date.last_update_date},interval 1 year)= ${balance_dt}  ;;
  }

measure: aua_converted_to_cad_last_year{ # AUA of last year i.e. 31st dec
  type: sum
  sql: ${aua_converted_to_cad_dim} ;;
  filters: [is_last_business_day_last_year_flag: "Yes"]
}

measure: aua_converted_to_cad_same_day_last_year{  # AUA of same day in last year
  type: sum
  sql: ${aua_converted_to_cad_dim} ;;
  filters: [is_same_day_ly: "Yes"]
}

measure: aua_converted_to_cad_last_business_day_of_months{ #Overall AUA
  type: number
  sql: sum(${aua_converted_to_cad_dim}) ;;
}

measure: total_aua_for_clients {  #Total AUA. Created separately since we need it without symmetric aggregation in client segmentation looks.
  type: number
  sql: sum(case when ${fact_holdng_rr.balance_dt_date}=${last_holding_date.last_update_date} then ${fact_holdng_rr.aua_converted_to_cad_dim} end );;
  value_format_name: decimal_0
}

measure: ranking {  #Created this for Top 10 looks present in the BoB dashboard
  type: number
  sql: rank() over (order by ${aua_converted_to_cad_current_month}  desc)  ;;
}

  # added the following measure for dashboard_enhancement stories
  measure: total_aua_last_12_month_including_current{ # Added for client segmentation look
    type: number
    sql: sum(case when ${balance_dt_date}  IN({{ _user_attributes['last_business_date_12_months_dev'] | split:"," | sql_quote | join:"," }}) OR ${balance_dt_date} ="{{ _user_attributes['latest_holding_date_dev'] }}" then ${aua_converted_to_cad_dim}  end) ;;
  }

  measure: total_aua_current_month { # Added for client segmentation look
    type: number
    sql: sum(case when ${balance_dt_date} ="{{ _user_attributes['latest_holding_date_dev'] }}" then ${aua_converted_to_cad_dim}  end) ;;
  }



### Quantiphi area ends here
}
