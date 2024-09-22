view: dashboard {
  derived_table:  {
    sql:
     Select 1 as dummy;;
  }
############################ ACCENTURE CODE STARTS HERE ########################################

  dimension: party_primary_email {
    type: string
    label: "Party Primary Email"
    sql: ${dim_party.party_primary_email} ;;
  }

  dimension: party_primary_phone {
    type: string
    label: "Party Primary Phone"
    sql: ${dim_party.party_primary_phone}  ;;
  }

  dimension: nk_hk_dim_accnt {
    type: string
    hidden: yes
    value_format: "0"
    sql: ${dim_accnt.nk_hk_dim_accnt_str};;
  }


  dimension: accnt_currnc {
    type: string
    sql: ${dim_accnt.accnt_currnc} ;;
  }

  dimension: account_number {
    type: string
    sql: ${dim_accnt.account_number} ;;
  }

  dimension: account_number_link {
    type: string
    label: "account_number_link"
    sql: ${dim_accnt.account_number} ;;
    html:
      {% if accnt_currnc._value == 'USD'%}
      <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:14px; font-weight:600"><img alt="USD Currency Icon" src="@{icon_source_url}/Country%20-%20USA@2x.png" height=15 width=15>&ensp;<a href="{{link}}&redirect={{ nk_hk_dim_accnt._value }}">{{ account_number._value }}</a></p>
      {% else %}
      <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:14px; font-weight:600"><img alt="CAD Currency Icon" src="@{icon_source_url}/Country%20-%20CAD@2x.png" height=16 width=16>&ensp;<a href="{{link}}&redirect={{ nk_hk_dim_accnt._value }}">{{ account_number._value }}</a></p>
      {% endif %}
      ;;
  }

  dimension: accnt_holdr_name {
    type: string
    label: "accnt_holdr_name"
    sql: ${dim_accnt.accnt_holdr_name} ;;
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;

  }

  dimension: account_owner_link {
    label: "accnt_holdr_name"
    type: string
    sql: ${dim_accnt.accnt_holdr_name} ;;
    html:
    {% assign encodedURL = dim_accnt.accnt_holdr_name._value | replace: ' ','%20' %}
    <a href="{{link}}&redirect={{ encodedURL }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:14px; text-align:left; font-weight:600">{{ dim_accnt.accnt_holdr_name._value }}</p></a>;;
  }

  dimension: accnt_ownrshp_tp {
    type: string
    label: "accnt_ownrshp_tp__name"
    sql: ${dim_accnt.accnt_ownrshp_tp} ;;
    group_label: "Accnt Ownrshp Tp"
    group_item_label: "Name"
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;
  }

  dimension: accnt_tp_value {
    type: string
    label: "account_type"
    sql: ${dim_accnt.accnt_tp} ;;
    group_label: "Accnt Tp"
    group_item_label: "Value"
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{rendered_value}};;
  }

  dimension: accnt_progrm_tp {
    type: string
    label: "accnt_progrm_tp__name"
    sql: ${dim_accnt.accnt_progrm_tp} ;;
    group_label: "Accnt Progrm Tp"
    group_item_label: "Name"
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px; word-wrap">{{ value }}</div>;;
  }

  ## USED FOR TRANSACTION DASHBOARD
  dimension: symbol_desc_transactions {
    label: "Symbol & Description"
    type: string
    sql: CASE WHEN ${dim_prodct_tran.prodct_id} NOT IN ("USD","CAD") THEN
          concat(TRIM(${dim_prodct_tran.prodct_symbl})," ", TRIM(${dim_prodct_tran.prodct_desc}))
          ELSE concat(TRIM(${dim_prodct_tran.prodct_symbl})," ", TRIM(${fact_transctn_rr.transctn_not}))
          END;;
    html:
    <a style="color: #000000; font-weight: 600;" title={{dim_prodct_tran.prodct_symbl._value }}>{{ dim_prodct_tran.prodct_symbl._value }}</a><br/>
    {% if dim_prodct_tran.prodct_id._value != 'USD' and dim_prodct_tran.prodct_id._value != 'CAD' %}
    <span width=”100%” style=”word-wrap:break-word;”>{{ dim_prodct_tran.prodct_desc._value }}</span>
    {% else %}
    <span width=”100%” style=”word-wrap:break-word;”>{{ fact_transctn_rr.transctn_not._value }}</span>
    {% endif %}
    ;;
  }

  dimension: account_transaction {
    label: "Account"
    type: string
    sql: ${dim_accnt_locale.accnt_tp__name} ;;
    html:
    {% if accnt_currnc._value == 'CAD' %}
    <img src="@{icon_source_url}/Country%20-%20CAD@2x.png" height=16 width=16 >
    {% else %}
    <img src="@{icon_source_url}/Country%20-%20USA@2x.png" height=15 width=15>
    {% endif %}
    <a style="color: #000000; font-weight: 600;" title={{ account_transaction ._value }}>&nbsp;{{ account_transaction._value }}</a>
    <div style="word-wrap:break-word; padding-left:1.4rem">
    <p style="margin-bottom: 0;">{{ accnt_holdr_name._value }}</p>
    <p>{{ account_number._value }}</p></div>;;
  }

  dimension_group: process {
    type: time
    label: "Process Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${fact_transctn_rr.process_date} ;;
    html:
    {% if _user_attributes['locale'] == 'en' %}
    {{ value | date: "%y/%m/%d" }}
    {% else %}
    {{ value | date: "%d/%m/%y" }}
    {% endif %};;
  }

  dimension_group: settlmnt_dt {
    type: time
    label: "Settlement"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${fact_transctn_rr.settlmnt_dt_date} ;;
    html:
    {% if _user_attributes['locale'] == 'en' %}
    {{ value | date: "%y/%m/%d" }}
    {% else %}
    {{ value | date: "%d/%m/%y" }}
    {% endif %};;
  }

  dimension_group: trad_dt {
    type: time
    label: "Trade"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${fact_transctn_rr.trad_dt_date} ;;
    html:
    {% if _user_attributes['locale'] == 'en' %}
    {{ value | date: "%y/%m/%d" }}
    {% else %}
    {{ value | date: "%d/%m/%y" }}
    {% endif %};;
  }

  dimension: transaction_descr {
    type: string
    label: "Transaction"
    sql: ${dim_transctn_cd.transaction_descr} ;;
    html: <span width=”100%” style=”word-wrap:break-word;”>{{ value }}</span>;;
  }

  dimension: transctn_pric {
    type: number
    label: "Price ($)"
    sql: ${fact_transctn_rr.transctn_pric};;
    value_format: "[>=0]#,##0.000\"\";[<0](#,##0.000)\"\""
    html:
    {% if transctn_currnc._value == 'CAD' %}
    <p style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px; text-align:right">{{ rendered_value }} CAD</p>
    {% else %}
    <p style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px; text-align:right">{{ rendered_value }} USD</p>
    {% endif %};;
  }

  dimension: transctn_pric_str {
    type: string
    label: "Price ($)"
    sql: CASE WHEN  ${fact_transctn_rr.transctn_pric_str} = "-"
          THEN "-"
          WHEN ${fact_transctn_rr.transctn_pric} >= 0 AND ${fact_transctn_rr.transctn_currnc} = 'CAD'
            THEN CONCAT(CONCAT(FORMAT("%'d", CAST(FLOOR(${fact_transctn_rr.transctn_pric}) AS int64)), SUBSTR(FORMAT("%.3f", CAST(${fact_transctn_rr.transctn_pric_str} AS float64)), -4)), " CAD")
            WHEN ${fact_transctn_rr.transctn_pric} < 0 AND ${fact_transctn_rr.transctn_currnc} = 'CAD'
            THEN CONCAT("(", CONCAT(FORMAT("%'d", CAST(FLOOR(${fact_transctn_rr.transctn_pric}) AS int64)), SUBSTR(FORMAT("%.3f", CAST(${fact_transctn_rr.transctn_pric_str} AS float64)), -4)), ") CAD")
            WHEN ${fact_transctn_rr.transctn_pric} >= 0
            THEN CONCAT(CONCAT(FORMAT("%'d", CAST(FLOOR(${fact_transctn_rr.transctn_pric}) AS int64)), SUBSTR(FORMAT("%.3f", CAST(${fact_transctn_rr.transctn_pric_str} AS float64)), -4)), " USD")
            WHEN ${fact_transctn_rr.transctn_pric} < 0
            THEN CONCAT("(", CONCAT(FORMAT("%'d", CAST(FLOOR(${fact_transctn_rr.transctn_pric}) AS int64)), SUBSTR(FORMAT("%.3f", CAST(${fact_transctn_rr.transctn_pric_str} AS float64)), -4)), ") USD")
            END;;
    html: <span width=”100%” style=”word-wrap:break-word;”>{{ value }}</span> ;;
    order_by_field: transctn_pric
  }

  dimension: transctn_currnc {
    type: string
    sql: ${fact_transctn_rr.transctn_currnc} ;;
  }

  measure: transaction_amount {
    type: number
    label: "Amount ($)"
    sql: ${fact_transctn_rr.transctn_amnt} ;;
    value_format: "[>=0]#,###.00\"\";[<=0](#,###.00)\"\""
    html:
    {% if transctn_currnc._value == 'CAD' %}
    <span width=”100%” style=”word-wrap:break-word;”>{{ rendered_value }} CAD</span>
    {% else %}
    <span width=”100%” style=”word-wrap:break-word;”>{{ rendered_value }} USD</span>
    {% endif %};;
  }

  measure: whole_transctn_quantt {
    type: number
    sql: ${fact_transctn_rr.transctn_quantt} ;;
    value_format: "#,###;(#,###)"
    html: {{rendered_value}} ;;
  }

  measure: transctn_quantt {
    type: number
    label: "Quantity"
    sql: ${fact_transctn_rr.transctn_quantt} ;;
    value_format: "#,##0.000;(#,##0.000)"
    html:
    {% if dim_prodct_tran.prodct_altrnt_tp._value == '380'%}
    <span width=”100%” style=”word-wrap:break-word;”>{{ rendered_value }}</span>
    {% else %}
    <span width=”100%” style=”word-wrap:break-word;”>{{ whole_transctn_quantt._rendered_value }}</span>
    {% endif %};;
  }
  ## TRANSACTION DASHBOARD END --

  dimension: rep_cd {
    type: string
    label: "rep_cd"
    sql: ${dim_user_rep_cds.rep_cd} ;;
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;
  }

  dimension: rep_cd_with_rep_cd_name {
    type: string
    label: "rep_cd"
    sql: ${dim_user_rep_cds.rep_cd_with_rep_cd_name} ;;
    html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;
  }

  measure: aua_converted_to_cad{
    type: number
    label: "aua_converted_to_cad"
    value_format: "#,##0.00"
    sql: ROUND(${fact_holdng_rr.aua_converted_to_cad}, 2) ;;
    html: {{rendered_value}} ;;
  }

  measure: aua_converted_to_cad_one{
    type: number
    label: "Total Market Value (CAD$)"
    value_format: "#,##0.00"
    sql: ROUND(${fact_holdng_rr.aua_converted_to_cad}, 2) ;;
    html: {{rendered_value}} ;;
  }

  measure: aua_converted_to_cad_one_12_months {
    type: number
    label: "Total Market Value (CAD$)"
    value_format: "#,##0.00"
    sql: ROUND(${fact_holdng_rr_12_months_master_list.aua_converted_to_cad}, 2) ;;
    html: {{rendered_value}} ;;
  }

  measure: accounts {
    type: string
    label: "accounts"
    sql: ${dim_party.acct_type_and_number_list} ;;
  }

  dimension: houshld_id{
    type: string
    sql: ${houshlds.houshld_id} ;;
  }

  dimension: is_system_generated {
    type: yesno
    sql: ${houshlds.is_system_generated} ;;
  }

  dimension: houshld_list_name {
    case_sensitive: no
    label: "household_list_name"
    type: string
    sql: ${houshlds.houshld_name};;
    html:
    {% if is_system_generated._value == 'Yes' or is_system_generated._value == true  %}
    <img alt="System Generated Icon" src="@{icon_source_url}/icon%20-%20Auto-Mantained.svg" height=16 width=16>&ensp;<a href="{{link}}&redirect={{ houshld_id._value }}">{{ houshld_list_name._value }}</a>
    {% else %}
    &nbsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;<a href="{{link}}&redirect={{ houshld_id._value }}">{{ houshld_list_name._value }}</a>
    {% endif %}
    ;;
  }

  dimension: allocation_name {
    type: string
    sql: ${fact_allctn_holdng.allocation_name} ;;
    order_by_field: allocation_name_order
  }

  dimension: allocation_name_order {
    type: number
    sql:
          CASE
          WHEN ${fact_allctn_holdng.allocation_code} = 'CU' THEN 1
          WHEN ${fact_allctn_holdng.allocation_code} = 'FI' THEN 2
          WHEN ${fact_allctn_holdng.allocation_code} = 'EQ' THEN 3
          WHEN ${fact_allctn_holdng.allocation_code} = 'OT' THEN 4
          ELSE 5
          END;;
    hidden: yes
    description: "This dimension is used to force order of allocation name."
  }

  dimension: client_list_name {
    label: "Name"
    case_sensitive: no
    type: string
    sql: ${dim_party.party_name};;
    html: <a href="{{link}}&redirect={{dim_party.nk_hk_dim_party_str._value}}">{{ value }}</a>;;
  }

  dimension_group: party_date_of_birth {
    label: "client_list_birthday"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${dim_party.party_date_of_birth_date} ;;
    html:
    {% if _user_attributes['locale'] == 'en' %} {{ value | date: "%B %d, %Y" }}
    {% elsif value contains "-01-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d janvier %Y" }}
    {% elsif value contains "-02-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d février %Y" }}
    {% elsif value contains "-03-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d mars %Y" }}
    {% elsif value contains "-04-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d avril %Y" }}
    {% elsif value contains "-05-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d mai %Y" }}
    {% elsif value contains "-06-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d juin %Y" }}
    {% elsif value contains "-07-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d juillet %Y" }}
    {% elsif value contains "-08-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d août %Y" }}
    {% elsif value contains "-09-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d septembre %Y" }}
    {% elsif value contains "-10-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d octobre %Y" }}
    {% elsif value contains "-11-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d novembre %Y" }}
    {% elsif value contains "-12-" and _user_attributes['locale'] == 'fr_FR' %} {{ value | date: "%d décembre %Y" }}
    {%else%} {{ value | date: "%d %B %Y" }}
    {% endif %};;
  }

  dimension: party_address {
    type: string
    label: "Address"
    sql: ${dim_party.party_address} ;;
    html: <p style="color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
  }

  dimension: party_address_one_line {
    type: string
    label: "Address"
    sql: ${dim_party.party_address_one_line} ;;
  }

  dimension: holdng_currnc{
    type:  string
    hidden: yes
    sql:  ${dim_prodct_hld.price_currnc} ;;
  }

  measure: quantity_holdings_consolidated{
    label: "holdings_quantity"
    type: number
    sql: ${fact_holdng_rr.quantt_ttl} ;;
    value_format: "[>=0]#,##0.000\"\";[<0](#,##0.000)\"\""
    html: {{rendered_value}} ;;
  }

  measure: market_price_holdings_consolidated {
    label: "holdings_market_price"
    type: number
    value_format: "#,##0.000"
    sql: AVG(${fact_holdng_rr.markt_pric_holdng_currnc}) ;;
    html:
    {% if holdng_currnc._value == "USD" %}
    {{rendered_value}}&nbsp;{{holdng_currnc._value}}
    {% else %}
    {{rendered_value}}
    {% endif %}
    ;;
  }

  measure: total_accrued_interest {
    type: number
    sql: ${fact_holdng_rr.accrued_interest};;
    value_format: "[>=0]#,##0.00\"\";[<0](#,##0.00)\"\""
  }

  measure: market_value_holdings_consolidated {
    label: "holdings_market_value"
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad} ;;
    html:
    {% if  total_accrued_interest._value == 0  %}
    &nbsp;{{ rendered_value }}
    {% else %}
    &nbsp;{{ rendered_value }}*
    <div style="font-size:10px">&nbsp;Accrued Int. {{ total_accrued_interest._rendered_value }}</div>
    {% endif %} ;;
    value_format: "[>=0]#,##0.00\"\";[<0](#,##0.00)\"\""
  }

  dimension: symbol_desc_holding {
    label: "Symbol_Description_holdings"
    type: string
    sql: concat(${dim_prodct_hld.prodct_symbl}," ", ${dim_prodct_hld.prodct_desc});;
    html:
    <a style="color: #000000; font-weight: 600;" title={{dim_prodct_hld.prodct_symbl._value }}>{{ dim_prodct_hld.prodct_symbl._value }}</a>
    <td width=”100%” style=”word-wrap:break-word;”>{{ dim_prodct_hld.prodct_desc._value }}</td>
    ;;
  }

  measure: houshld_client_list {
    type: string
    label: "Clients"
    sql: ${houshlds.houshld_client_list} ;;
  }

  ##Aggregated Fields used in Global Search Household
  measure: phone_numbers {
    type: string
    label: "Party Primary Phone"
    sql: (STRING_AGG(DISTINCT ${dim_party.party_primary_phone}, ", " order by ${dim_party.party_primary_phone}))  ;;
  }

  measure: addresses {
    type: string
    label: "Address"
    sql: (STRING_AGG(DISTINCT ${dim_party.party_address_one_line}, ", " order by ${dim_party.party_address_one_line}))  ;;
  }

  measure: emails {
    type: string
    label: "Party Primary Email"
    sql: (STRING_AGG(DISTINCT ${dim_party.party_primary_email}, ", " order by ${dim_party.party_primary_email}))  ;;
  }

  measure: rep_cds {
    type: string
    label: "rep_cd"
    sql: (STRING_AGG(DISTINCT ${dim_user_rep_cds.rep_cd}, ", " order by ${dim_user_rep_cds.rep_cd}))  ;;
  }

  measure: pie_chart_allocation_aua {
    label: "Total Market Value (CAD$)"
    type: number
    value_format: "#,##0.00"
    sql: ROUND(${fact_allctn_holdng.allocation_aua}, 2) ;;
  }


  dimension: global_search_client_accounts {
    type: string
    sql: array_to_string([${dim_accnt.acct_type_and_number}], ", ");;
  }

  filter: multifilter_client {
    case_sensitive: no
    sql: {% condition %} ${dim_party.party_name} {% endcondition %}
          or {% condition %} ${dim_party.party_primary_email} {% endcondition %}
          or {% condition %} ${dim_party.party_address_one_line} {% endcondition %}
          or {% condition %} ${dim_party.party_primary_phone} {% endcondition %}
          or {% condition %} ${dim_user_rep_cds.rep_cd} {% endcondition %};;
  }

  filter: multifilter_household{
    case_sensitive: no
    sql: {% condition %} ${houshlds.houshld_name} {% endcondition %}
          or {% condition %} ${dim_user_rep_cds.rep_cd} {% endcondition %}
          or {% condition %} ${dim_party.party_address_one_line} {% endcondition %};;
  }

### Accenture code ends here
#### Quantiphi code starts here

################################### DIM_ACCNT ################################################

  dimension: accnt_holdr_name_locale {
    label: "client"                       #this label is localized
    type: string
    sql: ${dim_accnt.accnt_holdr_name} ;;
  }

  dimension: account_number_locale {
    label: "account_number_q"             #this label is localized
    type: string
    sql: ${dim_accnt.account_number} ;;
  }

  dimension: account_status_level_1 {
    label: "account_status"               #this label is localized
    type: string
    sql: ${dim_accnt.account_status_level_1};;
  }

  dimension: accnt_tp__name_merged {
    label: "account_type_q"              #this is localized
    hidden: yes
    type: string
    sql: trim(replace(replace(${dim_accnt_locale.accnt_tp__name},'CAD',''),'USD',''));;
  }

  dimension: accnt_progrm_tp__value {
    label:  "program_type"                #this is localized
    type: string
    sql: ${dim_accnt_locale.accnt_progrm_tp__name} ;;
  }

  dimension: filtered_accnt_tp__name_merged {
    label: "account_type_q"              #this is localized
    hidden: yes
    type: string
    sql: trim(replace(replace(${dim_accnt_locale.accnt_tp__name},'CAD',''),'USD',''));;
  }

  dimension: filtered_accnt_progrm_tp__value {
    label:  "program_type"                #this is localized
    type: string
    sql: ${dim_accnt_locale.accnt_progrm_tp__name} ;;
  }

  dimension: accnt_tp__name {
    label: "account_type_q"               #this is localized
    type: string
    sql: ${dim_accnt_locale.accnt_tp__name} ;;
  }

  measure: total_active_accounts {       #HTML formatting has been applied
    hidden: yes
    label: "Total Accounts"
    type: number
    sql: ${dim_accnt.total_accounts} ;;
    html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
  }

  measure: lost_account_count {       #HTML formatting has been applied
    hidden: yes
    label: "Total Lost Accounts"
    type: number
    sql: ${dim_accnt.lost_account_count} ;;
    html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
  }

  measure: new_account_count {       #HTML formatting has been applied
    hidden: yes
    label: "Total New Accounts"
    type: number
    sql: ${dim_accnt.new_account_count} ;;
    html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
  }



  measure: total_active_accounts_drill_accnt_tp {   # Added link for custom drill viz. This measure is been used in 'Account by Account Type' of look 'Accounts' dashboard
    hidden: yes
    type: number
    sql: ${dim_accnt.total_accounts} ;;
    link: {
      label: "account_details"  #this label is localized
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_active_accounts_drill_accnt_tp_sample._link }}&sorts=total_aua_current_month+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_active_accounts_drill_accnt_tp_sample {  # Referred it in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,account_number_locale,dashboard.accnt_tp__name,total_aua_current_month]
  }


  measure: total_active_accounts_drill_prgrm_tp {   # Added link for custom drill viz. This measure is been used in 'Account by Program Type' look of 'Accounts' dashboard
    hidden: yes
    type: number
    sql: ${dim_accnt.total_accounts} ;;
    link: {
      label: "account_details" #this label is localized
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{total_active_accounts_drill_prgrm_tp_sample._link }}&sorts=total_aua_current_month+desc,accnt_tp__name+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_active_accounts_drill_prgrm_tp_sample {   # Refered it in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,account_number_locale,accnt_tp__name,filtered_accnt_progrm_tp__value,total_aua_current_month]
  }

  measure: average_assets_per_active_accounts {       #Custom value format applied
    type: number
    sql: coalesce (${total_aua_current_month}/nullif(${total_active_accounts},0),0);;
    value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
  }

  measure: average_assets_per_active_accounts_wo_format {       #Custom value format applied
    type: number
    sql: round(coalesce (${total_aua_current_month}/nullif(${total_active_accounts},0),0),0);;
  }

  measure: average_assets_per_new_accounts {         #Custom value format applied
    type: number
    sql: coalesce (${total_aua_current_month}/nullif(${dim_accnt.new_account_count},0),0);;
    value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
  }

  measure: total_accounts_multi_value {             #HTML formatting has been applied. Used this measure in 'Total Accounts' and 'New Accounts' single value tile of Account dashboard
    hidden: no
    type: number
    sql: ${total_active_accounts} ;;
    html:<div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_active_accounts._rendered_value }}</span>
       </div>;;
  }

  measure: total_lost_accounts_multi_value {        #HTML formatting has been applied. Used this measure in 'Total Accounts' and 'New Accounts' single value tile of 'Account' dashboard
    hidden: no
    type: number
    sql: ${lost_account_count} ;;
    html:
       <div style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px;" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_lost_accounts._rendered_value }}</span>
       </div>;;
  }

  measure: total_new_accounts_multi_value {        #HTML formatting has been applied. Used this measure in 'Total Accounts' and 'New Accounts' single value tile of 'Account' dashboard
    hidden: no
    type: number
    sql: ${new_account_count} ;;
    html:<div style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px;" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_new_accounts._rendered_value }}</span>
       </div>;;
  }

  measure:  at_least_one_account_open{
    label: "open_account" #this_is_localized
    type: yesno
    hidden: no
    sql: case when max(${account_status_level_1}) = "{{ _localization['Open'] }}" then true
    else false end;;
  }


######################################### DIM_PARTY #####################################################

  dimension: client_name {
    label: "client"             #this label is localized
    type: string
    sql: ${dim_party.party_name} ;;
    html: <a href="{{link}}&redirect={{ dim_party.nk_hk_dim_party }}"><p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; text-align:left; font-weight:600">{{ value }}</p></a>;;
  }


  measure: total_active_clients {    #HTML formatting has been applied
    type: number
    sql: ${dim_party.total_clients} ;;
    html: <div style="color: #525870;
          text-align: center;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;">{{rendered_value}} </div> ;;
  }

  measure: total_new_clients {    #HTML formatting has been applied
    type: number
    sql: ${dim_party.new_client_count} ;;
    html: <div style="color: #525870;
          text-align: center;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;">{{rendered_value}} </div> ;;
  }

  measure: lost_client_count {    #HTML formatting has been applied
    type: number
    sql: ${dim_party.lost_client_count} ;;
    html: <div style="color: #525870;
          text-align: center;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;">{{rendered_value}} </div> ;;
  }

  measure: total_clients_pct_drill_for_segments {     # Added link for custom drill viz. This measure is been used in Clients segmentation looks of 'Clients' dashboard
    hidden: no
    type: percent_of_total
    # 1168403-changes-for-j-and-closed-accounts: Using total_active_clients instead of calculating total_active_clients here
    sql: ${dim_party.total_client_pct} ;;
    # sql:${total_active_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0);;
    # value_format_name: percent_2
    value_format: "0.00\%"
    link: {
      label: "client_details"   #this label is localized
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1,\"hidden_points_if_no\":[\"dashboard.at_least_one_account_open\"]
      }' %}
      {{ total_clients_pct_drill_for_segments_sample._link }}&sorts=total_aua_current_month_sample+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
  }

  measure: total_clients_pct_drill_for_segments_sample {  #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,total_aua_current_month_sample,at_least_one_account_open]
  }

  measure: total_clients_pct_drill_for_segments_nohtml {     # Added link for custom drill viz. This measure is been used in Clients segmentation looks of 'Clients' dashboard
    hidden: no
    type: number
    sql:${dim_party.total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0);;
    value_format_name: percent_2
    link: {
      label: "client_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_clients_pct_drill_for_segments_nohtml_sample._link }}&sorts=total_revenue_party_ndt.clients_total_12_month_revenue+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
    html: <p style="color:#003DA5"><u>{{rendered_value}}</u></p> ;;
  }

  measure: total_clients_pct_drill_for_segments_nohtml_sample {  #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [total_revenue_party_ndt.client_name,total_revenue_party_ndt.clients_total_12_month_revenue,total_revenue_party_ndt.clients_recurring_revenue_ratio,total_revenue_party_ndt.clients_revenue_on_assets_for_drill,total_revenue_party_ndt.ytd_revenue,total_aua_current_month_sample]

    # drill_fields: [client_name,fact_revn_rr.total_12_month_revenue,fact_revn_rr.recurring_revenue_ratio_12_month_wo_html,fact_revn_rr.revenue_on_assets_for_segment_drill,fact_revn_rr.ytd_revenue]
  }

  measure: average_assets_per_active_clients {       #added custom value format
    type: number
    # 1168403-changes-for-j-and-closed-accounts: Using total_active_clients instead of calculating total_active_clients here
    sql: coalesce(${total_aua_at_account_ndt.total_aua}/nullif(${total_active_clients},0),0) ;;
    # sql: coalesce (sum(case when ${fact_holdng_rr.balance_dt_date}=${last_holding_date.last_update_date} then ${fact_holdng_rr.aua_converted_to_cad_dim} end )/nullif(count(distinct ${dim_party.party_id}),0),0) ;;
    value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
  }

  measure: average_assets_per_new_clients {          #added custom value format
    type: number
    sql: coalesce(${total_aua_for_new_client_at_account_ndt.total_aua_new_clients}/nullif(${dim_party.new_client_count},0),0) ;;
    # sql: coalesce (${total_aua_current_month}/nullif(${dim_party.new_client_count},0),0);;
    value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
  }

  measure: total_client_multi_value {            #HTML formatting has been applied. Used this measure in 'Total Clients' and 'New Clients' single value tile of 'CLients' dashboard
    hidden: no
    type: number
    sql: ${total_active_clients} ;;
    html:
       <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_active_clients._rendered_value }}</span>
       </div>;;
  }

  measure: new_client_multi_value {            #HTML formatting has been applied. Used this measure in 'Total Clients' and 'New Clients' single value tile of 'CLients' dashboard
    hidden: no
    type: number
    sql: ${total_new_clients} ;;
    html:
       <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_new_clients._rendered_value }}</span>
       </div>;;
  }


  measure: total_client_multi_value_without_pct {            #HTML formatting has been applied. Used this measure in 'Total Clients' and 'New Clients' single value tile of 'CLients' dashboard
    hidden: no
    type: number
    sql: ${total_active_clients} ;;
    html:
       <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       </div>;;
  }

  measure: total_lost_client_multi_value {     #HTML formatting has been applied. Used this measure in 'Lost Clients' single value tile of 'Clients' dashboard
    hidden: no
    type: number
    sql: ${lost_client_count} ;;
    html:
       <div style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px;" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_lost_clients._rendered_value }}</span>
       </div>;;
  }


  measure: total_active_clients_drill_accnt_tp {   # Added link for custom drill viz. This measure is been used in 'Clients by Account Type' look of 'Clients' dashboard
    type: number
    sql: ${dim_party.total_clients} ;;
    link: {
      label: "client_details"   #this label is localized
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_active_clients_drill_accnt_tp_sample._link }}&sorts=dashboard.total_aua_current_month+desc,dashboard.accnt_tp__name+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_active_clients_drill_accnt_tp_sample {   #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,dashboard.accnt_tp__name,total_aua_current_month]
  }

  measure: total_active_clients_drill_prgrm_tp {        # Added link for custom drill viz. This measure is been used in 'Clients by Program Type' look of 'Clients' dashboard
    hidden: yes
    type: number
    sql: ${dim_party.total_clients} ;;
    link: {
      label: "client_details"
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_active_clients_drill_prgrm_tp_sample._link }}&sorts=dashboard.total_aua_current_month+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_active_clients_drill_prgrm_tp_sample {    #referred in above measure
    hidden: yes
    type: count_distinct
    sql: 0;;
    drill_fields: [client_name,total_aua_current_month]
  }

  dimension: income_tier {
    label: "income_segment"              #this label is localized
    type: string
    sql:  CASE
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  < 25000 THEN   '{{ _localization['below_25k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 25000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 50000 THEN '{{ _localization['25k_to_49k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 50000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 100000 THEN '{{ _localization['50k_to_99k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 100000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 250000 THEN '{{ _localization['100k_to_249k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 250000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 500000 THEN '{{ _localization['250k_to_499k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 500000 AND ${dim_party.current_party_approx_annual_income_numeric}  < 1000000 THEN '{{ _localization['500k_to_999k_income_seg'] }}'
          WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 1000000 THEN '{{ _localization['1m_or_above_income_seg'] }}'
          ELSE   '{{ _localization['not_available'] }}'
          END ;;
  }

  dimension: age_tier {
    label: "age_segment"                 #this label is localized
    type: string
    sql:  CASE
          WHEN ${dim_party.age}  < 18 AND ${dim_party.age}  > 0  THEN   '{{ _localization['below_18'] }}'
          WHEN ${dim_party.age}  >= 18 AND ${dim_party.age}  < 30 THEN '{{ _localization['18_to_29'] }}'
          WHEN ${dim_party.age}  >= 30 AND ${dim_party.age}  < 40 THEN '{{ _localization['30_to_39'] }}'
          WHEN ${dim_party.age}  >= 40 AND ${dim_party.age}  < 50 THEN '{{ _localization['40_to_49'] }}'
          WHEN ${dim_party.age}  >= 50 AND ${dim_party.age}  < 60 THEN '{{ _localization['50_to_59'] }}'
          WHEN ${dim_party.age}  >= 60 AND ${dim_party.age}  < 65 THEN '{{ _localization['60_to_64'] }}'
          WHEN ${dim_party.age}  >= 65 AND ${dim_party.age}  < 70 THEN '{{ _localization['65_to_69'] }}'
          WHEN ${dim_party.age}  >= 70 THEN '{{ _localization['70_or_above'] }}'
          ELSE '{{ _localization['not_available'] }}'
          END ;;
  }

######################################  HOUSEHLD #######################################

  measure: active_household_count {     #HTML formatting is been applied
    label: "Total Active Household"      #this label is localized
    type: number
    sql: ${houshlds.total_household_count} ;;
    html: <div style="color: #525870;
          text-align: left;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-left: 0px;">{{rendered_value}} </div> ;;
  }

  measure: average_assets_per_active_houshold {   #added custom value format
    type: number
    sql: coalesce (${total_aua_current_month}/nullif(${active_household_count},0),0);;
    value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
  }

  measure: total_household_multi_value {           #HTML formatting is been applied
    hidden: no
    description: "Total Household (Multi value)"
    type: number
    sql: ${active_household_count} ;;
    html:
       <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       {{average_assets_title._rendered_value}}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ average_assets_per_active_houshold._rendered_value }}</span>
       </div>;;

  }

  measure: total_household_multi_value_without_pct {           #HTML formatting is been applied
    hidden: no
    description: "Total Household (Multi value)"
    type: number
    sql: ${active_household_count} ;;
    html:
       <div  id="removeclass" style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px; padding-left: 0px;" class="multiple_value__DataPointGroup" >
       <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
       </div>;;

  }



################################# DIM_PRODUCT ##############################################

  dimension: prodct_tp {
    type: string
    label: "product_type" #this is localized
    sql: ${dim_prodct_hld.prodct_tp} ;;
  }

  # added the following dimension for dashboard_enhancement story [1272922]-Modify Top 10 List to Show More Products
  dimension: prodct_id {
    label: "prodct_id"
    type: string
    sql: ${dim_prodct_hld.prodct_id} ;;
  }

###1118547 - Add Product Long Description to Looker Model(Changed condition for french version)

  dimension: product_description {
    type: string
    label: "description" #this is localized
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${dim_prodct_hld.prodct_desc_fr}
          {% else %}
          ${dim_prodct_hld.prodct_desc_en}
          {% endif %};;
  }

### Product Long Description not to be used anywhere. ###
  dimension: product_long_description {
    type: string
    label: "description" #this is localized
    sql:  {% if _user_attributes['locale'] == 'fr_FR' %}
         ${dim_prodct_hld.product_long_description_fr}
          {% else %}
          ${dim_prodct_hld.product_long_description}
          {% endif %};;
  }

####################### DIM_REGSTR_REPRSNTTV ################################################
# commenting for now and using accenture's existing rep_cd dim from dashboard.view
  # dimension: rep_cd {
  #   label: "ia_code" #this label is localized
  #   type: string
  #   sql: ${dim_regstr_reprsnttv.rep_cd} ;;
  # }
  dimension: rep_cd_hist {
    type: string
    label: "rep_cd"
    sql: ${dim_user_rep_cds.rep_cd} ;;
  }

####################### FACT_HOLDNG_RR ################################################
  dimension: last_12_month_with_mtd { # used this measure in 'AUA Trend' look to show last 12 months and current month as 'Month to Date'
    hidden: yes
    label: "month" #this is localized
    sql: CASE WHEN ${fact_holdng_rr.last_12_months_trend_month}= (FORMAT_DATE('%Y-%m', ${last_holding_date.last_update_date} ))  THEN '{{ _localization['month_to_date'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="January" THEN '{{ _localization['january'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="February" THEN '{{ _localization['february'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="March" THEN '{{ _localization['march'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="April" THEN '{{ _localization['april'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="May" THEN '{{ _localization['may'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="June" THEN '{{ _localization['june'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="July" THEN '{{ _localization['july'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="August" THEN '{{ _localization['august'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="September" THEN '{{ _localization['september'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="October" THEN '{{ _localization['october'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="November" THEN '{{ _localization['november'] }}'
              WHEN cast(format_date('%B',${fact_holdng_rr.last_12_months_trend_date}) as string) ="December" THEN '{{ _localization['december'] }}'
              END ;;
    order_by_field: fact_holdng_rr.last_12_months_trend_month
  }

  measure: total_aua_current_month {   #Latest AUA
    hidden: no
    label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;

  }

  measure: total_aua_current_month_for_segments {    #Created for revenue client segmentation
    hidden: no
    # label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${fact_holdng_rr.total_aua_current_month} ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;

  }

  measure: total_aua_12_month_including_current_for_segments {   #Created for revenue client segmentation
    hidden: no
    # label: "total_market_value_cad" #this label is localized
    type: number
    sql: ${fact_holdng_rr.total_aua_last_12_month_including_current} ;;
    value_format_name: decimal_0
    html:
    {% if value < 0 %}
    <span style="color:#B5252A;">{{rendered_value}}</span>
    {% else %}
    {{rendered_value}}
    {% endif %};;
    }

  measure: total_aua_pct_for_revenue_segments {
    label: "Total AUA% (Segments)"
    type: number
    sql:coalesce( ${total_aua_12_month_including_current_for_segments} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0);;
    value_format_name: percent_2
  }

  measure: total_aua_current_month_with_font { #created for Summary dashboard
    hidden: yes
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0
    html: <div style="color: #525870;
          font-family:Open Sans
          text-align: center;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          white-space:normal; word-wrap:normal;">{{rendered_value}} </div> ;;

  }

  measure: average_assets_title {
    type: string
    sql: '{{ _localization['average_asset_title'] }}' ;;
  }

  measure: ytd_change_title {
    type: string
    sql: '{{ _localization['ytd_change_title'] }}' ;;
  }

  measure: total_aua_multi_value {
    hidden: no
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0

    html:<div style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px;" >
          <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
          {% if aua_pct_change_from_ly._value > 0 %}
          {{ _localization['ytd_change_title'] }}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#11654E;">{{ aua_pct_change_from_ly._rendered_value }}</span>
          {% elsif aua_pct_change_from_ly._value <0 %}
          {{ _localization['ytd_change_title'] }}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#B5252A;">{{ aua_pct_change_from_ly._rendered_value }}</span>
          {% else %}
          {{ _localization['ytd_change_title'] }}: <span style=" font-size: 16px; font-style: normal; font-weight: 600;color:#003DA5;">{{ aua_pct_change_from_ly._rendered_value }}</span>
          {% endif %}
          </div>;;
  }

  measure: total_aua_multi_value_without_pct {
    hidden: no
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0

    html:<div style="text-align:left; font-size: 16px; font-style: normal; font-weight: 600;color:#525870; padding-top: 0px;" >
          <p style="font-size: 21px; font-style: normal; font-weight: 700;color:#525870;" >{{rendered_value}}<p>
          </div>;;
  }


  measure: total_aua_current_month_with_format {  #created for BoB dashboard
    hidden: yes
    label: "total_market_value_cad" #this is localized
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0
    html: <div style="color: #525870;
          text-align: center;
          font-size: 24px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;">@{value_format_liquid_currency} </div> ;;

  }

  measure: total_aua_last_12_month {
    hidden: yes
    label: "total_market_value_cad" #this is localized
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_last_business_day_of_months} ;;
  }

  measure: total_aua_last_12_month_master_list {
    hidden: no
    label: "total_market_value_cad" #this is localized
    type: number
    value_format_name: decimal_0
    sql: coalesce(${fact_holdng_rr_12_months_master_list.aua_converted_to_cad_last_business_day_of_months},0) ;;
  }

  measure: total_aua_current_month_drill_top_10 {
    hidden: yes
    #label: "total_aua_current_month_drill_top_10"
    type: number
    sql: ${fact_holdng_rr.aua_converted_to_cad_current_month} ;;
    value_format_name: decimal_0
    link: {
      label: "client_details" #or your label of choice
      url: "
      {% assign vis_config = '{
      \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
      }' %}
      {{ total_aua_current_month_drill_top_10_sample._link }}&sorts=total_aua_current_month+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }

    html:
    {% if value < 0 %}
    <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
    {% else %}
    <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
    {% endif %};;
    # f[total_aua_current_month]=not+0&



    }

    measure: total_aua_current_month_drill_top_10_sample {
      hidden: yes
      type: count_distinct
      sql: 0;;
      drill_fields: [client_name,total_aua_current_month]
    }

    measure: total_aua_current_month_drill_prgrm_tp {
      hidden: yes
      #label: "total_aua_current_month_drill_prgrm_tp"
      type: number
      sql: ${fact_holdng_rr_12_months_master_list.aua_converted_to_cad_current_month} ;;
      value_format_name: decimal_0
      link: {
        label: "asset_details" #or your label of choice
        url: "
        {% assign vis_config = '{
        \"x_axis_gridlines\":false,\"y_axis_gridlines\":true,\"show_view_names\":false,\"show_y_axis_labels\":true,\"show_y_axis_ticks\":true,\"y_axis_tick_density\":\"default\",\"y_axis_tick_density_custom\":5,\"show_x_axis_label\":false,\"x_axis_label\":\"____________________________\",\"show_x_axis_ticks\":true,\"y_axis_scale_mode\":\"linear\",\"x_axis_reversed\":false,\"y_axis_reversed\":false,\"plot_size_by_field\":false,\"trellis\":\"\",\"stacking\":\"\",\"limit_displayed_rows\":false,\"legend_position\":\"center\",\"point_style\":\"circle\",\"show_value_labels\":true,\"label_density\":25,\"x_axis_scale\":\"auto\",\"y_axis_combined\":true,\"show_null_points\":true,\"interpolation\":\"linear\",\"show_totals_labels\":false,\"show_silhouette\":false,\"totals_color\":\"#808080\",\"x_axis_zoom\":true,\"y_axis_zoom\":true,\"series_types\":{},\"series_labels\":{},\"x_axis_label_rotation\":0,\"type\":\"looker_area\",\"ordering\":\"none\",\"show_null_labels\":false,\"defaults_version\":1,\"hidden_pivots\":{}
        }' %}
        {{ total_aua_12_month_drill_prgrm_tp_sample._link }}&f[last_12_months_master_list.last_12_month_with_mtd_wo_13th_month]=-NULL&sorts=last_12_months_master_list.last_12_month_with_mtd_wo_13th_month+asc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      }
      html:
                   {% if value < 0 %}
                   <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
                   {% else %}
                   <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
                   {% endif %};;
    }



    measure: total_aua_current_month_drill_prgrm_tp_sample {
      hidden: yes
      type: number
      sql: 1 ;;
      drill_fields: [last_12_month_with_mtd,total_aua_without_format]
    }

    measure: total_aua_12_month_drill_prgrm_tp_sample {
      hidden: yes
      type: number
      sql: 1 ;;
      drill_fields: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month,total_aua_12_month_master_list]
    }

    measure: total_aua_current_month_sample {
      label: "total_market_value_cad" #this label is localized
      hidden: yes
      type: number
      sql: coalesce(${fact_holdng_rr.total_aua_for_clients},0) ;;
      value_format_name: decimal_0
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;


    }

    measure: total_aua_pct_for_segments {
      label: "Total AUA% (Segments)"
      type: number
      sql:coalesce( ${total_aua_current_month_sample} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0);;
      value_format_name: percent_2
    }

    measure: total_aua {
      hidden: yes
      label: "total_market_value_cad" #this is localized
      type: number
      sql: ${total_aua_last_12_month} ;;
      value_format_name: decimal_0
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    measure: total_aua_12_month_master_list {
      hidden: yes
      label: "total_market_value_cad" #this is localized
      type: number
      sql: ${total_aua_last_12_month_master_list} ;;
      value_format_name: decimal_0
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }


    measure: total_aua_without_format {
      hidden: yes
      label: "total_market_value_cad" #this is localized
      type: number
      sql: ${total_aua_last_12_month} ;;
      value_format_name: decimal_0
    }

    measure: aua_ytd {
      hidden: yes
      type: number
      sql: ${fact_holdng_rr.aua_converted_to_cad_current_month};;
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    measure: aua_end_ly {
      hidden: yes
      type: number
      sql: ${fact_holdng_rr.aua_converted_to_cad_last_year} ;;
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    measure: aua_ly_same_day {
      hidden: yes
      label: "AUA Last Year (Same Day as Current Latest Business Day)"
      type: number
      sql:${fact_holdng_rr.aua_converted_to_cad_same_day_last_year} ;;
      html:
          {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
         {{rendered_value}}
          {% endif %};;
    }

    measure: aua_change_of_same_day {
      hidden: yes
      type: number
      sql: ${total_aua}-${aua_ly_same_day} ;;
    }

    measure: aua_change_ytd {
      label: "AUA Change (YTD)"
      #description: "AUA change of Latest Business day from 31st Dec Last Year"
      type: number
      sql: ${aua_ytd} - ${aua_end_ly} ;;
    }

    measure: aua_pct_change_from_ly {
      label: "AUA %Change from Last Year"
      #description: "AUA change of Latest Business day from Same Day Last Year"
      type: number
      sql: coalesce((${aua_ytd}-${aua_end_ly})/nullif(${aua_end_ly},0),0)  ;;
      value_format_name: percent_2
      html:
          {% if value > 0 %}
          <span style="color:#11654E;">{{ rendered_value }}</span>
          {% elsif value <0 %}
          <span style="color:#B5252A;">{{ rendered_value }}</span>
          {% else %}
          <span style="color:#003DA5;">{{ rendered_value }}</span>
          {% endif %};;
    }



################################  FACT_TRANSACTN_RR   ########################################################

    dimension: trad_dt_month_with_mtd{ #used in Advisor Changed Look
      hidden: yes
      label: "month" #this is localized
      type: string
      # sql: CASE WHEN ${fact_transctn_rr.trad_dt_month}= (FORMAT_DATE('%Y-%m', ${last_holding_date.last_update_date} )) then 'Month to date' else cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) END ;;

      sql: CASE WHEN ${fact_transctn_rr.trad_dt_month}= (FORMAT_DATE('%Y-%m', ${last_holding_date.last_update_date} ))  THEN '{{ _localization['month_to_date'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="January" THEN '{{ _localization['january'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="February" THEN '{{ _localization['february'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="March" THEN '{{ _localization['march'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="April" THEN '{{ _localization['april'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="May" THEN '{{ _localization['may'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="June" THEN '{{ _localization['june'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="July" THEN '{{ _localization['july'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="August" THEN '{{ _localization['august'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="September" THEN '{{ _localization['september'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="October" THEN '{{ _localization['october'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="November" THEN '{{ _localization['november'] }}'
              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) ="December" THEN '{{ _localization['december'] }}'
              END ;;
    }

    measure: organic_growth_ytd {
      type: number
      sql: ${fact_transctn_rr.net_transaction_cashflow_ytd} -(${fact_transctn_rr.new_clients_cashflow_ytd}+${fact_transctn_rr.lost_clients_cashflow_ytd}) ;;
      value_format_name: decimal_0
      html:
           {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
    }

    measure: total_transaction_amount_cad {
      label: "Transaction Amount (CAD)"
      type: number
      sql: ${fact_transctn_rr.transaction_amount_cad} ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    dimension: is_existing_client_cashflows {
      label: "is_existing_client"
      type: string
      sql: ${fact_transctn_rr.is_existing_client_cashflows};;
    }

    dimension: is_new_client_cashflows {
      label: "is_new_client"
      type: string
      sql: ${fact_transctn_rr.is_new_client_cashflows} ;;
    }

    dimension: is_lost_client_cashflows {
      label: "is_lost_client"
      type: string
      sql: ${fact_transctn_rr.is_lost_client_cashflows} ;;
    }

    measure: new_clients_cashflow {
      label: "new_client_cash_flow_cad" #this is localized
      type: number
      sql: coalesce(${fact_transctn_rr.total_new_clients_cashflow},0) ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    # added the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    measure: new_clients_cashflow_scorecard {
      label: "new_client_cash_flow" #this is localized
      type: number
      sql: ${new_clients_cashflow} ;;
      value_format_name: decimal_0
      html: {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %};;
    }


    measure: total_new_clients_cashflow_drill {  # added this for asset change breakdown to avoid existing client with joined account.
      label: "new_client_cash_flow_cad" #this is localized
      type: number
      sql: coalesce(round(${fact_transctn_rr.total_new_clients_cashflow_drill},0),0) ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }


    measure: new_clients_cashflow_drill {
      #label:"new clients cashflow drill"
      type: number
      sql: ${fact_transctn_rr.total_new_clients_cashflow} ;;
      value_format_name: decimal_0
      link: {
        label: "client_details" #or your label of choice
        url: "
        {% assign vis_config = '{
        \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
        }' %}
        {{ new_client_cashflow_drill_sample._link }}&f[dashboard.is_new_client_cashflows]=Yes&sorts=dashboard.total_new_clients_cashflow_drill+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      }
      html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;

    }

    measure: new_client_cashflow_drill_sample {
      hidden: yes
      type: number
      sql: 0;;
      drill_fields: [client_name,total_new_clients_cashflow_drill]
      # drill_fields: [client_name,new_clients_cashflow]
    }


    measure: lost_clients_cashflow {
      label: "lost_client_cash_flow_cad" #this is localized
      type: number
      sql: coalesce(${fact_transctn_rr.total_lost_clients_cashflow},0) ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    measure: total_lost_clients_cashflow_drill {  # added this for asset change breakdown to avoid existing client with joined account.
      label: "lost_client_cash_flow_cad" #this is localized
      type: number
      sql: coalesce(round(${fact_transctn_rr.total_lost_clients_cashflow_drill},0),0) ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    # added the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    measure: lost_clients_cashflow_scorecard {
      label: "lost_client_cash_flow" #this is localized
      type: number
      sql: ${lost_clients_cashflow} ;;
      value_format_name: decimal_0
      html: {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %};;
    }

    measure: lost_clients_cashflow_drill {
      hidden: yes
      #label: "lost clients cashflow drill"
      type: number
      sql: ${fact_transctn_rr.total_lost_clients_cashflow} ;;
      value_format_name: decimal_0
      link: {
        label: "client_details" #or your label of choice
        url: "
        {% assign vis_config = '{
        \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
        }' %}
        {{ lost_client_cashflow_drill_sample._link }}&f[dashboard.is_lost_client_cashflows]=Yes&sorts=dashboard.total_lost_clients_cashflow_drill+asc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      }
      html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;
    }


    measure: lost_client_cashflow_drill_sample {
      hidden: yes
      type: number
      sql: 0;;
      drill_fields: [client_name,total_lost_clients_cashflow_drill]
      # drill_fields: [client_name,lost_clients_cashflow]
    }

    measure: existing_client_cashflow {
      label: "existing_client_cash_flow_cad" #this is localized
      type: number
      sql: coalesce(${fact_transctn_rr.total_existing_clients_cashflow},0) ;;
      value_format_name: decimal_0
      html: {% if value < 0 %}
          <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    # added the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    measure: existing_client_cashflow_scorecard {
      label: "existing_client_cash_flow" #this is localized
      type: number
      sql: ${existing_client_cashflow} ;;
      value_format_name: decimal_0
      html: {% if value > 0 %}
        <div style="color: #11654E;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;">{{rendered_value}} </div>
        {% elsif value <0 %}
        <div style="color: #B5252A;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;"> {{rendered_value}} </div>
        {% else %}
        <div style="color: #525870;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;"> {{rendered_value}} </div>
        {% endif %};;
    }

    measure: existing_client_cashflow_drill {
      #label: "existing client cashflow drill"
      hidden: yes
      type: number
      sql: ${fact_transctn_rr.total_existing_clients_cashflow} ;;
      value_format_name: decimal_0
      link: {
        label: "client_details" #or your label of choice
        url: "
        {% assign vis_config = '{
        \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
        }' %}
        {{ existing_client_cashflow_drill_sample._link }}&f[dashboard.is_existing_client_cashflows]=Yes&sorts=dashboard.existing_client_cashflow+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      }
      html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;
    }


    measure: existing_client_cashflow_drill_sample {
      hidden: yes
      type: number
      sql: 0;;
      drill_fields: [client_name,existing_client_cashflow]
    }

    # added the following measures net_client_growth_scorecard and market_variation for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    measure: net_client_growth_scorecard {
      label: "net_client_growth_cad" #this is localized
      type: number
      sql: coalesce(round(${existing_client_cashflow_scorecard} + ${new_clients_cashflow_scorecard} + ${lost_clients_cashflow_scorecard},0),0) ;;
      value_format_name: decimal_0
      html: {% if value > 0 %}
        <div style="color: #11654E;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;">{{rendered_value}} </div>
        {% elsif value <0 %}
        <div style="color: #B5252A;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;"> {{rendered_value}} </div>
        {% else %}
        <div style="color: #525870;
        text-align: left;
        font-size: 21px;
        font-style: normal;
        font-weight: 700;
        line-height: 26px;
        padding-top: 0px;"> {{rendered_value}} </div>
        {% endif %};;
    }

    measure: market_variation {
      type: number
      sql: ${asset_change_ndt_tran.sum_aua_change} - ${net_client_growth_scorecard} ;;
      value_format_name: decimal_0
      html: {% if value > 0 %}
                <div style="color: #11654E;
                text-align: left;
                font-size: 21px;
                font-style: normal;
                font-weight: 700;
                line-height: 26px;
                padding-top: 0px;">{{rendered_value}} </div>
                {% elsif value <0 %}
                <div style="color: #B5252A;
                text-align: left;
                font-size: 21px;
                font-style: normal;
                font-weight: 700;
                line-height: 26px;
                padding-top: 0px;"> {{rendered_value}} </div>
                {% else %}
                <div style="color: #525870;
                text-align: left;
                font-size: 21px;
                font-style: normal;
                font-weight: 700;
                line-height: 26px;
                padding-top: 0px;"> {{rendered_value}} </div>
                {% endif %};;
    }

    measure: average_assets_per_lost_clients {
      hidden: no
      type: number
      sql: ABS(coalesce (${fact_transctn_rr.total_lost_clients_cashflow}/nullif(${dim_party.lost_client_count},0),0));;
      value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
    }

    measure: average_assets_per_lost_accounts {
      hidden: no
      type: number
      sql: ABS(coalesce (${fact_transctn_rr.lost_account_cashflows}/nullif(${dim_accnt.lost_account_count},0),0));;
      value_format:"[>=1000000]#,##0,,\"M\";[>=1000]#,##0,\"K\";#0"
    }

###########  fact_allctn_holdng ###########

    dimension: prodct_desc {
      hidden: no
      label: "description" #this label is localized
      type: string
      sql: ${fact_allctn_holdng.prodct_desc} ;;
    }

    dimension: allocation_name_locale {
      label: "asset_type" #this lable is localized
      hidden: no
      type: string
      sql: CASE WHEN ${fact_allctn_holdng.allocation_code} ='CASH' THEN
              CASE WHEN ${fact_allctn_holdng.allocation_aua_dim}>0 THEN
              CASE WHEN ${fact_allctn_holdng.lang_cd} ='en' THEN "Cash and Equivalents" ELSE "Encaisse et quasi-espèces" END
              ELSE
              CASE WHEN ${fact_allctn_holdng.lang_cd}='en' THEN "Debit Balance and Owed Investments" ELSE "Solde débiteur et investissements dûs" END END
              ELSE ${fact_allctn_holdng.allocation_name} END;;
    }

    measure: total_aua_no_drill {
      hidden: no
      label: "total_market_value_cad" #this is localized
      type: number
      sql: ${fact_allctn_holdng.allocation_aua} ;;
      value_format_name: decimal_0
      html:
          {% if value < 0 %}
           <span style="color:#B5252A;">{{rendered_value}}</span>
          {% else %}
          {{rendered_value}}
          {% endif %};;
    }

    measure: total_aua_allctn {
      hidden: no
      label: "total_market_value_cad" #this is localized
      type: number
      sql: ${fact_allctn_holdng.allocation_aua} ;;
      value_format_name: decimal_0
      link: {
        label: "asset_details" #this is localized
        url: "
        {% assign vis_config = '{
        \"show_view_names\":false,\"show_row_numbers\":true,\"transpose\":false,\"truncate_text\":true,\"hide_totals\":false,\"hide_row_totals\":false,\"size_to_fit\":true,\"table_theme\":\"white\",\"limit_displayed_rows\":false,\"enable_conditional_formatting\":false,\"header_text_alignment\":\"left\",\"header_font_size\":\"12\",\"rows_font_size\":\"12\",\"conditional_formatting_include_totals\":false,\"conditional_formatting_include_nulls\":false,\"show_sql_query_menu_options\":false,\"show_totals\":true,\"show_row_totals\":true,\"truncate_header\":false,\"minimum_column_width\":75,\"series_cell_visualizations\":{\"fact_holdng_rr.total_aua_current_month\":{\"is_active\":false}},\"header_font_color\":\"#000548\",\"header_background_color\":\"#EDEFF8\",\"type\":\"looker_grid\",\"defaults_version\":1
        }' %}
        {{ dashboard.total_aua_drill_sample._link }}&sorts=dashboard.total_aua_no_drill+desc&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
      }
      html:
          {% if value < 0 %}
          <u style="color:#003DA5;"> <span style="color:#B5252A;"><u>{{rendered_value}}</u></span></u>
          {% else %}
          <u style="color:#003DA5;"> <span style="color:#003DA5;"><u>{{rendered_value}}</u></span></u>
          {% endif %};;
    }

    measure: total_aua_drill_sample {
      hidden: yes
      type: count_distinct
      sql: 0;;
      drill_fields: [dashboard.prodct_desc, dashboard.total_aua_no_drill, dashboard.aua_by_product_pct]
    }


    measure: aua_by_product_pct {
      label: "percentage_of_asset_type" #this is localized
      type: number
      sql: ${total_aua_allctn}/nullif(${total_aua_for_asset_allocation_ndt.total_aua},0) ;;
      value_format_name: percent_2
    }

      measure: existing_client_cashflow_bob {
        label: "existing_client_cash_flow_cad" #this is localized
        type: number
        sql: coalesce(round(${fact_transctn_rr.total_existing_clients_cashflow},0),0) ;;
        value_format_name: decimal_0
        html: {% if value > 0 %}
              <div style="color: #11654E;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;">{{rendered_value}} </div>
              {% elsif value <0 %}
              <div style="color: #B5252A;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% else %}
              <div style="color: #525870;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% endif %}
              ;;
      }

      measure: new_clients_cashflow_bob {
        label: "new_client_cash_flow_cad" #this is localized
        type: number
        sql: coalesce(${fact_transctn_rr.total_new_clients_cashflow},0) ;;
        value_format_name: decimal_0
        html: {% if value > 0 %}
              <div style="color: #11654E;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;">{{rendered_value}} </div>
              {% elsif value <0 %}
              <div style="color: #B5252A;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% else %}
              <div style="color: #525870;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% endif %}
              ;;
      }

      measure: lost_clients_cashflow_bob {
        label: "lost_client_cash_flow_cad" #this is localized
        type: number
        sql: coalesce(${fact_transctn_rr.total_lost_clients_cashflow},0) ;;
        value_format_name: decimal_0
        html: {% if value > 0 %}
              <div style="color: #11654E;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;">{{rendered_value}} </div>
              {% elsif value <0 %}
              <div style="color: #B5252A;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% else %}
              <div style="color: #525870;
              text-align: left;
              font-size: 21px;
              font-style: normal;
              font-weight: 700;
              line-height: 26px;
              padding-top: 0px;"> {{rendered_value}} </div>
              {% endif %}
              ;;
      }

      measure: aua_change_ytd_bob {
        label: "AUA Change (YTD)"
        #description: "AUA change of Latest Business day from 31st Dec Last Year"
        type: number
        sql: ${aua_ytd} - ${aua_end_ly} ;;
        value_format_name: decimal_0
        html: {% if value > 0 %}
          <div style="color: #11654E;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;">{{rendered_value}} </div>
          {% elsif value <0 %}
          <div style="color: #B5252A;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% else %}
          <div style="color: #525870;
          text-align: left;
          font-size: 21px;
          font-style: normal;
          font-weight: 700;
          line-height: 26px;
          padding-top: 0px;"> {{rendered_value}} </div>
          {% endif %}
          ;;
    }

    # added the following dimension for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    dimension: bob_ytd_net_change_title {
      hidden: yes
      sql: "{{ _localization['ytd_net_change'] }}" ;;
      html: <div style="color: #00054B;font-family: Open Sans;font-size: 18px;font-style: normal;font-weight: 400;text-align:left;">{{rendered_value}}</div> ;;
    }

    # added the following dimension for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    dimension: bob_ytd_net_change_formula {
      hidden: yes
      sql: "{{ _localization['ytd_net_change_formula'] }}" ;;
      html: <div style="color: #00054B;font-family: Open Sans;font-size: 15px;font-style: normal;font-weight: 400;text-align:left;line-height:1.5;">{{rendered_value}} <br> {{bob_ytd_net_change_formula_line_2._rendered_value}}</div> ;;
    }

    # added the following dimension for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    dimension: bob_ytd_net_change_formula_line_2 {
      # hidden: yes
      sql: "{{ _localization['ytd_net_change_formula_line_2'] }}" ;;
    }

    # added the following dimension for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
    dimension: bob_12_month_net_change_title {
      hidden: yes
      sql: "{{ _localization['12_month_net_change'] }}" ;;
      html: <div style="color: #00054B;font-family: Open Sans;font-size: 18px;font-style: normal;font-weight: 400;text-align:left;">{{rendered_value}}</div> ;;
    }
#### Quantiphi code ends here

}