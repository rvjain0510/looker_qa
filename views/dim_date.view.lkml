view: dim_date {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.DIM_DATE` ;;

  dimension: can_holiday_ind {
    type: yesno
    description: "Canada holiday Indicator"
    sql: ${TABLE}.CAN_HOLIDAY_IND ;;
  }

  dimension: can_holiday_name {
    type: string
    description: "Canada holiday name"
    sql: ${TABLE}.CAN_HOLIDAY_NAME ;;
  }

  dimension_group: date_id {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DATE_ID ;;
  }

  dimension: day_abbrev {
    type: string
    description: "Day abreviation ex: Thu"
    sql: ${TABLE}.DAY_ABBREV ;;
  }

  dimension: day_name {
    type: string
    description: "Day name ex: Thursday"
    sql: ${TABLE}.DAY_NAME ;;
  }

  dimension: day_num_in_month {
    type: number
    description: "Day number in a month (1 to 31)"
    sql: ${TABLE}.DAY_NUM_IN_MONTH ;;
  }

  measure: total_day_num_in_month {
    type: sum
    sql: ${day_num_in_month} ;;
    }

  measure: average_day_num_in_month {
    type: average
    sql: ${day_num_in_month} ;;
    }

  dimension: day_num_in_week {
    type: number
    description: "Day number in a week (Monday=1, Sunday=7)"
    sql: ${TABLE}.DAY_NUM_IN_WEEK ;;
  }

  dimension: day_num_in_year {
    type: number
    description: "Day number in a year (1 to 366)"
    sql: ${TABLE}.DAY_NUM_IN_YEAR ;;
  }

  dimension: fiscal_halfyear {
    type: number
    description: "Fiscal half year  (1 or 2)"
    sql: ${TABLE}.FISCAL_HALFYEAR ;;
  }

  dimension: fiscal_month_num {
    type: number
    description: "Fiscal month number (1 to 12)"
    sql: ${TABLE}.FISCAL_MONTH_NUM ;;
  }

  dimension: fiscal_quarter {
    type: number
    description: "Fiscal quarter number (1 to 4)"
    sql: ${TABLE}.FISCAL_QUARTER ;;
  }

  dimension: fiscal_week_num {
    type: number
    description: "Fiscal week number (1 to 53)"
    sql: ${TABLE}.FISCAL_WEEK_NUM ;;
  }

  dimension: fiscal_year {
    type: number
    description: "Fiscal year ex: 2021"
    sql: ${TABLE}.FISCAL_YEAR ;;
  }

  dimension: fiscal_yearmonth {
    type: string
    description: "Fiscal year and month ex: 2021-04"
    sql: ${TABLE}.FISCAL_YEARMONTH ;;
  }

  dimension: fiscal_yearquarter {
    type: string
    description: "Fiscal year and quarter ex: 2021-02"
    sql: ${TABLE}.FISCAL_YEARQUARTER ;;
  }

  dimension: full_date_desc {
    type: string
    description: "Full date description ex: Thursday, Apr 08, 2021"
    sql: ${TABLE}.FULL_DATE_DESC ;;
  }

  dimension: ia_holiday_ind {
    type: yesno
    description: "iA holiday Indicator"
    sql: ${TABLE}.IA_HOLIDAY_IND ;;
  }

  dimension: ia_holiday_name {
    type: string
    description: "iA holiday name"
    sql: ${TABLE}.IA_HOLIDAY_NAME ;;
  }

  dimension: month_abbrev {
    type: string
    description: "Month abreviation ex: Apr"
    sql: ${TABLE}.MONTH_ABBREV ;;
  }

  dimension: month_end_ind {
    type: yesno
    description: "Month end indicator (Not-Month-end, Month-end)"
    sql: ${TABLE}.MONTH_END_IND ;;
  }

  dimension: month_name {
    type: string
    description: "Month name ex: April"
    sql: ${TABLE}.MONTH_NAME ;;
  }

  dimension: month_name_year {
    type: string
    description: "Month name and year ex: April 2021"
    sql: ${TABLE}.MONTH_NAME_YEAR ;;
  }

  dimension: month_name_year_ord {
    type: number
    description: "Month name and year order ex:202104"
    sql: ${TABLE}.MONTH_NAME_YEAR_ORD ;;
  }

  dimension: month_num_in_year {
    type: number
    description: "Month number in a year (1 to 12)"
    sql: ${TABLE}.MONTH_NUM_IN_YEAR ;;
  }

  dimension: quarter {
    type: number
    description: "Quarter number (1 to 4)"
    sql: ${TABLE}.QUARTER ;;
  }

  dimension: us_holiday_ind {
    type: yesno
    description: "United States holiday Indicator"
    sql: ${TABLE}.US_HOLIDAY_IND ;;
  }

  dimension: us_holiday_name {
    type: string
    description: "United States holiday name"
    sql: ${TABLE}.US_HOLIDAY_NAME ;;
  }

  dimension_group: week_begin {
    type: time
    description: "Week begin date ex: 2021-04-05"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WEEK_BEGIN_DATE ;;
  }

  dimension: week_begin_date_nkey {
    type: number
    description: "Week begin date nkey ex: 20210405"
    sql: ${TABLE}.WEEK_BEGIN_DATE_NKEY ;;
  }

  dimension_group: week_end {
    type: time
    description: "Week end date ex: 2021-04-11"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.WEEK_END_DATE ;;
  }

  dimension: week_end_date_nkey {
    type: number
    description: "Week end date nkey ex: 20210411"
    sql: ${TABLE}.WEEK_END_DATE_NKEY ;;
  }

  dimension: week_num_in_year {
    type: number
    description: "Week number in a year (1 to 53)"
    sql: ${TABLE}.WEEK_NUM_IN_YEAR ;;
  }

  dimension: weekday_ind {
    type: yesno
    description: "Weekday indicator (Weekday, Not a weekday)"
    sql: ${TABLE}.WEEKDAY_IND ;;
  }

  dimension: year {
    type: number
    description: "Year ex: 2021"
    sql: ${TABLE}.YEAR ;;
  }

  dimension: yearmonth {
    type: string
    description: "Year and month ex: 2021-04"
    sql: ${TABLE}.YEARMONTH ;;
  }

  dimension: yearquarter {
    type: string
    description: "Year and Quarter ex: 2021-02"
    sql: ${TABLE}.YEARQUARTER ;;
  }
  measure: count {
    type: count
    drill_fields: [month_name, can_holiday_name, ia_holiday_name, day_name, us_holiday_name]
  }
}
