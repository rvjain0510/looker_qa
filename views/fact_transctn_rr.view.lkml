view: fact_transctn_rr {
  sql_table_name: `@{bq_project_id}.@{bq_dataset_name}.FACT_TRANSCTN_RR` ;;

# Calculations

#CNT: transctn_tp IN ( "CONTCJ","UACONT","TO-TFS","TO-ESP","TO-RSP","AU-CEL","AU-RER","AU-REE","TO-DSP","AU-REI","CONTNA","CONT")

#WIT: transctn_tp IN ("IRSNRT","RDAP","PMTAI","PAEEI","EAP","LDAP","PMTVI","DEREG","RESIL","CK","CK*","DR","TRFR","PSE","EXTX","RFCESG",
#                     "RBIQEE","AIP","RFQESI","RETCPS","PRA","RBEIQE","RT","PIE","AIRRSP","7AE1530","EFT","HBP","WTHCPS","RPA","REP",
#                     "BKTSF","TRSFBK","PAE","EFTAWD","RBSCEE","WIREDR")

#CTS: transctn_tp IN ( "SPCONT","CJCONT")

#PAY: transctn_tp IN ( "EAPEI","EPS","PAYMNT","PAYMT","PMT")

#WTF: transctn_tp IN ( "WHTFED","IMPFED","IMPFDE")

#WTP: transctn_tp IN ( "IMPPQ","WHTPQ","IMPPQE")

#GRT: transctn_tp IN ( "ESCEE","SCEE","CESG","CLB","BEC","CDSB","CDSG","EAPSK","EAPBC")

#RRSP
#Contribution: CNT
#Withdrawal: WIT


#RRSP_Spousal
#Contribution: CNT, CTS
#Withdrawal: WIT
#Spousall Contributions: CTS

#RIF/LIF/LRIF?/LIRA?/LRSP?
#Withdrawal:  PAY, WTF, WTP

#TFSA
#Contribution: CNT
#Withdrawal: WIT

#FHSA
#Contribution: CNT
#Withdrawal: WIT

#RESP
#Contribution: CNT
#Withdrawal: WIT,PAY
# Grants: GRT #Updated 8/30

#RDSP
#Contribution: CNT
# Grants: GRT #Updated 8/30
#Withdrawal: WIT

# these for all types
# Cumulative Taxes: WTF and WTP
# Cumulative Payments: PAY

#For the Deposit and Withdrawals section of the cashflow summary,
#we will need to Assign transaction in the following group to those 2 categories (DEP and WIT): "TRF","GRT","WIT","DEP".
#If it is a negative transaction, it will go to withdrawals, if it is positive it will go to Deposits.
#No RAP_CD filter is needed

#dim_acct.accnt_rap_cd
#Data Dictioanry:
#INDIVIDUAL / FAMILY RESP: dim_accnt_rap_cd = "Z"
#LIF / LRIF / PRIF Current & Prev Year:  dim_accnt_rap_cd = "P"
#LIRA / LRSP: dim_accnt_rap_cd IN ("N", "9")
#RIF / RRIF Current and PRevi Year: dim_accnt_rap_cd IN ("T", "4")
#RRSP: dim_accnt_rap_cd IN ("7", "S")
#SPOUSAL RIF Current and Prev Year: dim_accnt_rap_cd IN ("Y")
#SPOUSAL RRSP: dim_accnt_rap_cd IN ("8", "R")
#TFSA / RDSP: dim_accnt_rap_cd IN ("6", "W", "0")

# add following 3 floafs for each section in Ref account scren
#tran_filter_flag_ra_ind_fam_resp_cntr    : Registered account Family Resp COntributions
#tran_filter_flag_ra_ind_fam_resp_witd
#tran_filter_flag_ra_ind_fam_resp_cmtx

#add following flags fo cash flow summary
#tran_filter_flag_cfs_dept. : Cashflow summary deposits
#tran_filter_flag_cfs_witd: Cashflow summary withdrawel


  dimension: is_cnt {
    type: yesno
    description: "Is CNT Transaction Type?"
    hidden: yes
    sql: CASE WHEN ${transctn_tp} IN
                    ("CONTCJ","UACONT","TO-TFS","TO-ESP","TO-RSP","AU-CEL","AU-RER","AU-REE","TO-DSP","AU-REI","CONTNA","CONT")
                    THEN true ELSE false END
          ;;
  }
  dimension: is_wit {
    type: yesno
    description: "Is WIT Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ("IRSNRT","RDAP","PMTAI","PAEEI","EAP","LDAP","PMTVI","DEREG","RESIL","DR","TRFR","PSE","EXTX","RFCESG",
                     "RBIQEE","AIP","RFQESI","RETCPS","PRA","RBEIQE","RT","PIE","AIRRSP","7AE1530","EFT","HBP","WTHCPS","RPA","REP",
                     "BKTSF","TRSFBK","PAE","EFTAWD","RBSCEE","WIREDR") OR
                     ${transctn_tp} LIKE "CK%"
                    THEN true ELSE false END
          ;;
  }

  dimension: is_cts {
    type: yesno
    description: "Is CTS Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ( "SPCONT","CJCONT")
                    THEN true ELSE false END
          ;;
  }
  dimension: is_pay {
    type: yesno
    description: "Is PAY Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ( "EAPEI","EPS","PAYMNT","PAYMT","PMT")
                    THEN true ELSE false END
          ;;
  }
  dimension: is_wtf {
    type: yesno
    description: "Is WTF Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ( "WHTFED","IMPFED","IMPFDE")
                    THEN true ELSE false END
          ;;
  }
  dimension: is_wtp {
    type: yesno
    description: "Is WTP Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ( "IMPPQ","WHTPQ","IMPPQE")
                    THEN true ELSE false END
          ;;
  }
  dimension: is_grt {
    type: yesno
    description: "Is GRT Transaction Type?"
    hidden: yes
    sql: CASE WHEN  ${transctn_tp} IN ( "ESCEE","SCEE","CESG","CLB","BEC","CDSB","CDSG","EAPSK","EAPBC")
                    THEN true ELSE false END
          ;;
  }

  dimension: reg_acct_type {
    type: string
    description: "reg_acct_type"
    sql:
    CASE WHEN ${dim_accnt.accnt_rap_cd} IN ("Z") THEN "IND_FAMILY_RESP"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("P") THEN "LIF_LRIF_PRIF"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("N","9") THEN "LIRA_LRSPF"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("T","4") THEN "RIF_RRIF"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("7","S") THEN "RRSP"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("Y") THEN "SP_RIF"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("8","R") THEN "SP_RRSP"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("6", "W") THEN "TFSA"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("0") THEN "RDSP"
     WHEN ${dim_accnt.accnt_rap_cd} IN ("Q") THEN "FHSA"

      ELSE "OTHERS"
      END
      ;;
  }

#RESP
#Contribution: CNT
#Withdrawal: WIT,PAY
# Cumulative Taxes: WTF and WTP
# Cumulative Payments: PAY
  dimension: reg_acct_type_field {
    type: string
    # hidden: yes
    description: "reg_acct_type_fields="
    sql:
    CASE
      WHEN ${reg_acct_type} = "IND_FAMILY_RESP" THEN
        CASE
          WHEN ${is_cnt} = true THEN "CONTR"
          WHEN ${is_wit} = true  OR ${is_pay} = true  THEN "WITD"
          ELSE "IGNORE"
        END
      WHEN ${reg_acct_type} = "LIF_LRIF_PRIF"  THEN
        CASE

      WHEN (${transctn_tax_indctr} is not true and  ${is_wtf} = true)   THEN "FTAX"
      WHEN ${transctn_tax_indctr} is not true and ${is_wtp} = true   THEN "PTAX"
      WHEN ${is_pay} = true  THEN "CPAY"
      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "LIRA_LRSPF" THEN
      CASE

      WHEN ${transctn_tax_indctr} is not true and ${is_wtf} = true   THEN "FTAX"
      WHEN ${transctn_tax_indctr} is not true and ${is_wtp} = true   THEN "PTAX"
      WHEN ${is_pay} = true  THEN "CPAY"
      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "RIF_RRIF" THEN
      CASE

      WHEN ${transctn_tax_indctr} is not true and ${is_wtf} = true   THEN "FTAX"
      WHEN ${transctn_tax_indctr} is not true and ${is_wtp} = true   THEN "PTAX"
      WHEN ${is_pay} = true  THEN "CPAY"
      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "RRSP" THEN
      CASE
      WHEN ${is_cnt} = true  THEN "CONTR"
      WHEN ${is_wit} = true  THEN "WITD"

      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "SP_RRSP" THEN
      CASE
      WHEN ${is_cnt} = true  THEN "CONTR"
      WHEN ${is_cts} = true  THEN "SP_CONTR"
      WHEN ${is_wit} = true  THEN "WITD"

      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "SP_RIF" THEN
      CASE

      WHEN ${transctn_tax_indctr} is not true and ${is_wtf} = true   THEN "FTAX"
      WHEN ${transctn_tax_indctr} is not true and ${is_wtp} = true   THEN "PTAX"
      WHEN ${is_pay} = true   THEN "CPAY"
      ELSE "IGNORE"
      END
      WHEN ${reg_acct_type} = "TFSA" THEN
      CASE
      WHEN ${is_cnt} = true  THEN "CONTR"
      WHEN ${is_wit} = true  THEN "WITD"
      ELSE "IGNORE"
      END

      WHEN ${reg_acct_type} = "FHSA" THEN
      CASE
      WHEN ${is_cnt} = true  THEN "CONTR"
      WHEN ${is_wit} = true  THEN "WITD"
      ELSE "IGNORE"
      END

      WHEN ${reg_acct_type} = "RDSP" THEN
      CASE
      WHEN ${is_grt} = true THEN "GRNT"
      WHEN ${is_cnt} = true THEN "CONTR"
      WHEN ${is_wit} = true THEN "WITD"
      ELSE "IGNORE"
      END
      END

      ;;
  }

  dimension: transaction_reg_group_en {
    type: string
    sql: CASE WHEN ${reg_acct_type_field} = "CONTR" THEN  "Contribution"
          WHEN ${reg_acct_type_field} = "SP_CONTR" THEN  "Spousal Contribution"
          WHEN ${reg_acct_type_field} = "CPAY" THEN  "Payment"
          WHEN ${reg_acct_type_field} = "FTAX" THEN
            CASE WHEN ${transctn_tax_indctr}  THEN  "Federal Withholding Tax" ELSE "Payment" END
          WHEN ${reg_acct_type_field} = "PTAX" THEN
          CASE WHEN ${transctn_tax_indctr}  THEN  "Quebec Witholding Tax" ELSE "Payment" END
          WHEN ${reg_acct_type_field} = "WITD" THEN  "Withdrawal"
          WHEN ${reg_acct_type_field} = "GRNT" THEN  "Grant"
          WHEN ${reg_acct_type_field} = "IGNORE" THEN  "Others"
          ELSE "Others"
          END
          ;;
  }

  dimension: transaction_reg_group_fr {
    type: string
    sql: CASE WHEN ${reg_acct_type_field} = "CONTR" THEN  "Cotisation"
          WHEN ${reg_acct_type_field} = "SP_CONTR" THEN  "Cotisation conjoint"
          WHEN ${reg_acct_type_field} = "CPAY" THEN  "Paiement"
          WHEN ${reg_acct_type_field} = "FTAX" THEN
            CASE WHEN ${transctn_tax_indctr}  THEN  "Impôt federal retenu" ELSE "Paiement" END
          WHEN ${reg_acct_type_field} = "PTAX" THEN
          CASE WHEN ${transctn_tax_indctr}  THEN  "Impôt Québec" ELSE "Paiement" END
          WHEN ${reg_acct_type_field} = "WITD" THEN  "Retrait"
          WHEN ${reg_acct_type_field} = "GRNT" THEN  "Subvention"
          WHEN ${reg_acct_type_field} = "IGNORE" THEN  "Autres"
          ELSE "Autres"
          END
          ;;
  }

  dimension: transaction_reg_group {
    type: string
    sql: CASE WHEN lang_pref = 'fr_FR' THEN ${transaction_reg_group_fr} ELSE ${transaction_reg_group_en} END;;
  }

  dimension: transaction_descr_reg_accounts {
    type: string
    sql:
    CASE
    WHEN ${reg_acct_type_field} IN ('FTAX', 'PTAX') THEN
        CASE WHEN lang_pref = 'fr_FR' THEN "Paiement" ELSE "Payment" END
    ELSE ${dim_transctn_cd.transaction_descr}
    END;;
  }

  measure: reg_act_grant {
    type: sum
    value_format: "#,##0.00"
    description: "Grant Amount"
    sql: CASE WHEN ${reg_acct_type_field} = "GRNT" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  measure: reg_act_contribution {
    type: sum
    value_format: "#,##0.00"
    description: "Contribution Amount"
    sql: CASE WHEN ${reg_acct_type_field} = "CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  measure: reg_act_spousal_contribution {
    type: sum
    value_format: "#,##0.00"
    description: "Spousal Contribution Amount"
    sql: CASE WHEN ${reg_acct_type_field} = "SP_CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  measure: reg_act_withdrawal {
    type: sum
    value_format: "#,##0.00"
    description: "Withdrwal Amount"
    sql: CASE WHEN  (${reg_acct_type_field} = "WITD" OR ${is_wtf} = TRUE OR ${is_wtp} = TRUE) THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  # First 60 days and rest of the year measures

  dimension: is_first_60_days {
    type: yesno
    description: "Is First 60 Days?"
    hidden: yes
    sql: CASE WHEN  EXTRACT(DAYOFYEAR FROM ${trad_dt_date}) <= 60
                    THEN true ELSE false END
          ;;
  }

  measure: reg_act_contribution_1st_60days {
    type: sum
    value_format: "#,##0.00"
    description: "Contribution Amount 1st 60 days"
    sql: CASE WHEN ${is_first_60_days} = true AND ${reg_acct_type_field} = "CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0  END;;
  }
  measure: reg_act_spousal_contribution_1st_60days {
    type: sum
    value_format: "#,##0.00"
    description: "Sposal Contribution Amount 1st 60 days"
    sql: CASE WHEN ${is_first_60_days} = true AND ${reg_acct_type_field} = "SP_CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }
  measure: reg_act_withdrawal_1st_60days {
    type: sum
    value_format: "#,##0.00"
    description: "Withdrwal Amount 1st 60 days"
    sql: CASE WHEN ${is_first_60_days} = true AND  (${reg_acct_type_field} = "WITD" OR ${is_wtf} = TRUE OR ${is_wtp} = TRUE) THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  measure: reg_act_contribution_rest_of_the_year {
    type: sum
    value_format: "#,##0.00"
    description: "Contribution Amount rest of the year"
    sql: CASE WHEN ${is_first_60_days} = false AND ${reg_acct_type_field} = "CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
   ELSE 0  END;;
  }

  measure: reg_act_spousal_contribution_rest_of_the_year {
    type: sum
    value_format: "#,##0.00"
    description: "Sposal Contribution Amount rest of the year"
    sql: CASE WHEN ${is_first_60_days} = false AND ${reg_acct_type_field} = "SP_CONTR" THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }

  measure: reg_act_withdrawal_rest_of_the_year {
    type: sum
    value_format: "#,##0.00"
    description: "Withdrwal Amount rest of the year"
    sql: CASE WHEN ${is_first_60_days} = false AND  (${reg_acct_type_field} = "WITD" OR ${is_wtf} = TRUE OR ${is_wtp} = TRUE) THEN
    CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
    ELSE 0 END;;
  }


  #End of First 60 days and rest of the year measures

  measure: reg_act_fed_tax {
    type: sum
    value_format: "#,##0.00"
    description: "Federal Taxes"
    sql: CASE WHEN ${reg_acct_type_field} IN ("FTAX") THEN
          ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY
          WHEN ${reg_acct_type_field} IN ("CPAY","WITD","GRNT") THEN ${fed_tax_amount}
          ELSE 0 END;;
  }



  measure: reg_act_prov_tax {
    type: sum
    value_format: "#,##0.00"
    description: "Province Taxes"
    sql: CASE WHEN ${reg_acct_type_field} IN ("PTAX") THEN ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY
          WHEN ${reg_acct_type_field} IN ("CPAY","WITD","GRNT") THEN ${prov_tax_amount}
          ELSE 0 END;;
  }

  measure: reg_act_gross_amt {
    type: number
    value_format: "#,##0.00"
    description: "Gross Amount"
    # sql: ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY
    sql: ${reg_act_net_amt}+${reg_act_fed_tax}+${reg_act_prov_tax} ;;

  }

  measure: reg_act_net_amt {
    type: sum
    value_format: "#,##0.00"
    description: "Gross Amount"
    sql: CASE WHEN ${reg_acct_type_field} IN ("FTAX", "PTAX") THEN 0
         WHEN ${reg_acct_type_field} IN ("CPAY","CONTR","SP_CONTR","WITD","GRNT") THEN
            CASE WHEN ${transctn_value_amount_account_currency} != 0 THEN ${transctn_value_amount_account_currency}
            ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY  END
          END
            ;;
  }

  measure: reg_act_cum_tax {
    type: sum
    value_format: "#,##0.00"
    description: "Cumulative Taxes"
    sql: CASE WHEN ${reg_acct_type_field} IN ("FTAX", "PTAX") THEN
         ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY
        WHEN ${reg_acct_type_field} IN ("CPAY") THEN
        ${fed_tax_amount} + ${prov_tax_amount} ELSE 0 END;;
  }

  measure: reg_act_cum_pay {
    type: sum
    value_format: "#,##0.00"
    description: "Cumulative Pay"
    sql: CASE WHEN ${reg_acct_type_field} IN ("FTAX", "PTAX", "CPAY") THEN
            CASE WHEN ${transctn_value_amount_account_currency} !=0 THEN ${transctn_value_amount_account_currency}+${fed_tax_amount} + ${prov_tax_amount}
               ELSE ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY + ${fed_tax_amount} + ${prov_tax_amount} END
            ELSE 0 END;;
  }

# Cash FLow summary Flags
  dimension: is_cf_dept {
    type: yesno
    hidden: yes
    description: "Is Cash Flow Summary Deposit"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("TRF","GRT","WIT","DEP") AND
      ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD >= 0 THEN true ELSE false END
    ;;
  }

  dimension: is_cf_witd {
    type: yesno
    hidden: yes
    description: "Is Cash Flow Summary Withdrawal"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("TRF","GRT","WIT","DEP") AND
      ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD < 0 THEN true ELSE false END
    ;;
  }

  measure: cash_flow_dept {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow deposit "
    sql: CASE WHEN ${is_cf_dept}  THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

  measure: cash_flow_witd {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Withdrawal "
    sql: CASE WHEN ${is_cf_witd}  THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

# Interest
  measure: cash_flow_int {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Intrest "
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("INT") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

# Reinvested dividents
  measure: cash_flow_drip {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Reinvested Dividends "
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("DRIP") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

# Cash dividents
  measure: cash_flow_div {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Dividend "
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("DIV") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Income distribution
  measure: cash_flow_dist {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Income distribution "
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("DIST") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Admin  Fees
  measure: cash_flow_admin_fee {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Admin Fee"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("ADF") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Management  Fees
  measure: cash_flow_fee_based_service {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Fee Based Service"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("MFE") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Taxes
  measure: cash_flow_tax {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Tax"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("TAX") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Investment Income
  measure: cash_flow_inv_income {
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Investment Income"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("INT", "DRIP", "DIV","DIST") THEN
      ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;
  }

#  Fee based services and charges
  measure: cash_flow_fee_and_charge{
    type: sum
    value_format: "#,##0.00"
    description: "Cash Flow Fee Based Service and Charge"
    sql: CASE WHEN ${dim_transctn_cd.transaction_summary_code} IN ("ADF", "MFE") THEN ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD  ELSE 0 END;;

  }


  dimension_group: as_of_dt {
    type: time
    description: "As Of Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.AS_OF_DT ;;
  }

  dimension: canclld_indctr {
    type: yesno
    description: "Cancelled Indicator"
    sql: ${TABLE}.CANCLLD_INDCTR ;;
  }

  dimension: canclld_transctn {
    type: number
    description: "Cancelled Transaction"
    sql: ${TABLE}.CANCLLD_TRANSCTN ;;
  }

  dimension: exchng_rate_to_accnt_currnc {
    type: number
    description: "Exchange Rate To Account Currency"
    sql: ${TABLE}.EXCHNG_RATE_TO_ACCNT_CURRNC ;;
  }

  dimension: exchng_rate_to_cad {
    type: number
    description: "Exchange Rate To CAD"
    sql: ${TABLE}.EXCHNG_RATE_TO_CAD ;;
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

  dimension: nk_hk_dim_transctn_cd {
    type: number
    value_format: "0"
    description: "Hash Natural Key of Dim"
    sql: ${TABLE}.NK_HK_DIM_TRANSCTN_CD ;;
  }

  dimension_group: process {
    type: time
    description: "Process Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PROCESS_DATE ;;
  }

  dimension_group: settlmnt_dt {
    type: time
    description: "Settlement date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.SETTLMNT_DT ;;
  }

  dimension_group: trad_dt {
    label: "trade_date"
    type: time
    description: "Trade Date"
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.TRAD_DT ;;
  }

  dimension: transaction_id {
    type: number
    description: "Transaction ID"
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  dimension: transctn_currnc {
    type: string
    description: "Transaction Currency"
    sql: ${TABLE}.TRANSCTN_CURRNC ;;
  }

  dimension: transctn_not {
    type: string
    description: "Transaction Note"
    sql: ${TABLE}.TRANSCTN_NOT ;;
  }

  dimension: transctn_pric {
    type: number
    value_format: "#,##0.00"
    description: "Transaction Price"
    sql: ${TABLE}.TRANSCTN_PRIC ;;
  }

  dimension: transctn_pric_str {
    type: string
    description: "Transaction Price"
    sql: CASE WHEN ${TABLE}.TRANSCTN_PRIC IS NULL
      THEN "-"
      ELSE
      CAST(${TABLE}.TRANSCTN_PRIC AS STRING)
      END;;
  }

  dimension: transctn_tp {
    type: string
    description: "Transaction Type"
    sql: ${TABLE}.TRANSCTN_TP ;;
  }

#Fix this field not to add taxes
  measure: transaction_amount_account_currency {
    type: sum
    value_format: "#,##0.00"
    description: "Transaction Amount Account Currency"
    sql: ${TABLE}.TRANSACTION_AMOUNT_ACCOUNT_CURRENCY ;;
  }


  measure: transaction_amount_cad {
    type: sum
    value_format: "#,##0.00"
    description: "Transaction Amount CAD"
    sql: ${TABLE}.TRANSACTION_AMOUNT_CAD ;;
  }

  #Added Nov 7
  measure: transaction_amount_cashflow_cad {
    type: sum
    value_format: "#,##0.00"
    description: "Transaction Amount Cashflow CAD"
    sql: ${TABLE}.TRANSACTION_AMOUNT_CASHFLOW_CAD ;;
  }


  measure: transctn_amnt {
    type: sum
    value_format: "#,##0.00"
    description: "Transaction Amount"
    sql: ${TABLE}.TRANSCTN_AMNT ;;
  }

  measure: transctn_quantt {
    type: sum
    value_format: "#,##0.000"
    description: "Transaction Quantity"
    sql: ${TABLE}.TRANSCTN_QUANTT ;;
  }


######################### ACCENTURE CODE ENDS HERE #############################################

  dimension: transaction_amount_cad_dim {
    type: number
    sql: ${TABLE}.TRANSACTION_AMOUNT_CAD ;;
  }

  # added the following dimension for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  dimension: transaction_amount_cad_dim_in_last_12_months {
    type: number
    sql: (CASE WHEN (${trad_dt_date} >= DATE_TRUNC(DATE_SUB(CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date),INTERVAL 11 Month),Month)
      and ${trad_dt_date}<= CAST("{{ _user_attributes['latest_holding_date_dev'] }}" AS date) ) THEN ${TABLE}.TRANSACTION_AMOUNT_CAD  ELSE 0 END) ;;
  }

  dimension: new_client_ind { # Indicator to check transactions occur in the recruitment period for a client will be considered as cash flow from new clients
    hidden: yes
    type: string
    sql: case when --${trad_dt_date} >= ${new_client_recruitment_period.recruitment_start_dt} and
          ${trad_dt_date} < ${new_client_recruitment_period.recruitment_end_dt} then "Yes" else "No"
          end;;
  }

  dimension: new_client_ind_for_drill { # Indicator to check transactions occur in the recruitment period for a client will be considered as cash flow from new clients
    hidden: yes
    type: string
    sql: case when --${trad_dt_date} >= ${new_clients.new_client_recruitment_dt} and
          ${trad_dt_date} < ${new_clients.recruitment_end_dt} then "Yes" else "No"
          end;;
  }

  dimension: lost_client_ind { #Indicator to check transactions that occur in the departed period for a client will be considered as cash flow from lost clients
    hidden: yes
    type: string
    sql: case when ${trad_dt_date} >= ${lost_client_departure_period.departure_start_dt} and ${transaction_amount_cad_dim}<0
          --and ${trad_dt_date} <= ${lost_client_departure_period.departure_end_dt}
          then "Yes" else "No"
          end;;
  }

  dimension: lost_client_ind_drill { #Indicator to check transactions that occur in the departed period for a client will be considered as cash flow from lost clients
    hidden: yes
    type: string
    sql: case when ${trad_dt_date} >= ${lost_client_departure_period.departure_start_dt} and ${transaction_amount_cad_dim}<0
         -- and ${trad_dt_date} <= ${lost_client_departure_period.departure_end_dt}
          and ${lost_clients.is_lost_client} then "Yes" else "No"
          end;;
  }

  dimension: ytd_flag { #Year to date flag
    hidden: yes
    type: yesno
    sql: DATE_DIFF( ${last_holding_date.last_update_date}, ${trad_dt_date},year)=0;;
  }

  measure: new_clients_cashflow_ytd { #YearToDate New Client's Cashflows
    hidden: yes
    type: sum
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}   and ${ytd_flag} then
             case when ${new_client_ind}='Yes'  and  ${lost_client_ind} ='No'
                       then ${transaction_amount_cad_dim}
                 when ${new_client_ind}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim}>0 then ${transaction_amount_cad_dim}
                         else 0
                     end
               end
         end;;
    value_format_name: usd_0
  }

  measure: lost_clients_cashflow_ytd {  #YearToDate Lost Client's Cashflows
    hidden: yes
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind: "Yes", ytd_flag: "Yes" ]
    value_format_name: usd_0
  }

  measure: net_transaction_cashflow_ytd {  #YearToDate total Net Transaction Cashflows
    hidden: yes
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes", ytd_flag: "Yes"]
    value_format_name: usd_0
  }

  measure: existing_clients_cashflow_ytd {   #YearToDate Existing Client's Cashflows
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",new_client_ind: "No", lost_client_ind: "No", ytd_flag: "Yes"]
    value_format_name: usd_0
  }


  measure: total_new_clients_inflow {
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [new_client_ind: "Yes", transaction_amount_cad_dim: ">0"]
    value_format_name: usd_0
  }

  measure: total_new_clients_outflow {
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [new_client_ind: "Yes", transaction_amount_cad_dim: "<0"]
    value_format_name: usd_0
  }

  # Updated the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  measure: total_new_clients_cashflow {   # New client cashflows
    type: sum
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  then
             case when ${new_client_ind}='Yes'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                 when ${new_client_ind}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                    end
              end
        end;;
    value_format_name: usd_0
  }

  # Updated the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  measure: total_new_clients_cashflow_drill {   # New client cashflows
    type: sum
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  then
             case when ${new_client_ind_for_drill}='Yes'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                 when ${new_client_ind_for_drill}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                    end
              end
        end;;
    value_format_name: usd_0
  }


  # Updated the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  measure: total_lost_clients_cashflow {  # Lost client cashflows
    type: sum
    sql: ${transaction_amount_cad_dim_in_last_12_months} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind: "Yes" ]
    value_format_name: usd_0
  }

  # Updated the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  measure: total_lost_clients_cashflow_drill {  # Lost client cashflows
    type: sum
    sql: ${transaction_amount_cad_dim_in_last_12_months} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind_drill: "Yes"]

    # filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind: "Yes", transaction_amount_cad_dim: "<0", lost_clients.is_lost_client: "yes" ]
    value_format_name: usd_0
  }


  # Updated the following measure for dashboard_enhancement story [1272931]-Add Total Row For Asset Change Table
  measure: total_existing_clients_cashflow { # existing client cashflows
    type: sum
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}   then
              case when ${new_client_ind}='No'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                   when ${new_client_ind}='No'  and ${lost_client_ind}='Yes' then
                 case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                 end
             end
         end;;
  }


  dimension: is_existing_client_cashflows {
    label: "Is Existing Client?"
    type: string
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}   then
              case when ${fact_transctn_rr.new_client_ind}='No'  and  ${lost_client_ind} ='No'
                    then "Yes"
                   when ${new_client_ind}='No'  and ${lost_client_ind}='Yes' and ${transaction_amount_cad_dim}>0 then "Yes"
                       else "No"
                 end
         end;;
  }

  dimension: is_new_client_cashflows {
    label: "Is New Client?"
    type: string
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  then
             case when ${new_client_ind_for_drill}='Yes'  and  ${lost_client_ind} ='No'then "Yes"
                 when ${new_client_ind_for_drill}='Yes'  and ${lost_client_ind}='Yes' and ${transaction_amount_cad_dim}>0 then "Yes"
                       else "No"
             end
        end ;;
  }

  dimension: is_lost_client_cashflows {
    label: "Is Lost Client?"
    type: string
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  and ${lost_client_ind_drill}='Yes' then "Yes"
      else "No"  end ;;
  }

  dimension: is_lost_account_cashflow { #Created lost account cashflow indicator
    label: "Is Lost Account Cashflows?"
    type: string
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  and ${dim_accnt.lost_account_ind}
        and  ${trad_dt_date} >= ${dim_accnt.account_departure_start_date} and ${transaction_amount_cad_dim}<0 then "Yes"
      else "No"  end ;;
  }

  measure: lost_account_cashflows { #lost account AUA
    type: sum
    sql: ${transaction_amount_cad_dim} ;;
    filters: [is_lost_account_cashflow: "Yes"]
  }
### Registered account change - start

### Registered account change - end
  dimension: transaction_amount_value {
    type: number
    sql: ${TABLE}.TRANSACTION_AMOUNT_VALUE ;;
  }
  dimension: prov_tax_amount {
    type: number
    sql: ${TABLE}.PROV_TAX_AMOUNT ;;
  }
  dimension: fed_tax_amount {
    type: number
    sql: ${TABLE}.FED_TAX_AMOUNT ;;
  }
  dimension: transctn_tax_indctr {
    type: yesno
    sql: ${TABLE}.TRANSCTN_TAX_INDCTR ;;
  }
  dimension: test {
    sql: CASE WHEN ${reg_acct_type} = "SP_RIF" THEN
               CASE

      WHEN ${transctn_tax_indctr} is not true and ${is_wtf} = true

      THEN "FTAX"
      else "IGNORE" END
      end
      ;;
    # --and ${is_wtf} = true
  }

  dimension: transctn_value_amount_account_currency  {
    type: number
    sql: ${TABLE}.TRANSCTN_VALUE_AMOUNT_ACCOUNT_CURRENCY ;;
  }

  #### Added the following measure for dashboard_enhancement story [1272927]-Add Summary Card for Asset Change: START ####
  measure: existing_clients_cashflow_ytd_scorecard {   #YearToDate Existing Client's Cashflows
    type: sum
    label: "existing_client_cash_flow" #this is localized
    sql: ${transaction_amount_cad_dim} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",new_client_ind: "No", lost_client_ind: "No", ytd_flag: "Yes"]
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

  measure: new_clients_cashflow_ytd_scorecard { #YearToDate New Client's Cashflows
    hidden: no
    type: sum
    label: "new_client_cash_flow" #this is localized
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}   and ${ytd_flag} then
             case when ${new_client_ind}='Yes'  and  ${lost_client_ind} ='No'
                       then ${transaction_amount_cad_dim}
                 when ${new_client_ind}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim}>0 then ${transaction_amount_cad_dim}
                         else 0
                     end
               end
         end;;
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

  measure: lost_clients_cashflow_ytd_scorecard {  #YearToDate Lost Client's Cashflows
    hidden: no
    type: sum
    label: "lost_client_cash_flow" #this is localized
    sql: ${transaction_amount_cad_dim} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind: "Yes", ytd_flag: "Yes" ]
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

  measure: net_client_growth_ytd_scorecard {   #YearToDate Existing Client's Cashflows
    type: number
    label: "net_client_growth_cad" #this is localized
    sql: ${existing_clients_cashflow_ytd_scorecard} + ${new_clients_cashflow_ytd_scorecard} + ${lost_clients_cashflow_ytd_scorecard} ;;
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

  measure: total_ytd {
    type: number
    sql: ${existing_clients_cashflow_ytd_scorecard}+${new_clients_cashflow_ytd_scorecard}+${lost_clients_cashflow_ytd_scorecard} ;;
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

  measure: total_existing_clients_cashflow_round_off { # existing client cashflows
    type: sum
    label: "existing_clients_cad"
    value_format: "#,##0"
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}   then
              case when ${new_client_ind}='No'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                   when ${new_client_ind}='No'  and ${lost_client_ind}='Yes' then
                 case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                 end
             end
         end;;
  }

  measure: total_new_clients_cashflow_round_off {   # New client cashflows
    type: sum
    label: "new_clients_cad"
    value_format: "#,##0"
    sql: case when ${dim_transctn_cd.cashflow_organic_growth}  then
             case when ${new_client_ind}='Yes'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                 when ${new_client_ind}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                    end
              end
        end;;
  }

  measure: total_lost_clients_cashflow_round_off {  # Lost client cashflows
    type: sum
    label: "lost_clients_cad"
    value_format: "#,##0"
    sql: ${transaction_amount_cad_dim_in_last_12_months} ;;
    filters: [dim_transctn_cd.cashflow_organic_growth: "Yes",lost_client_ind: "Yes" ]
  }

############################The following metrics created for 12 months scorecard in BOB##############################################

  measure: total_existing_clients_cashflow_round_off_last_12_months { # existing client cashflows
    type: sum
    label: "existing_clients_cad"
    value_format: "#,##0"
    sql: case when ${dim_transctn_cd_12_months_master_list.cashflow_organic_growth}   then
              case when ${new_client_ind}='No'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                   when ${new_client_ind}='No'  and ${lost_client_ind}='Yes' then
                 case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                 end
             end
         end;;
  }

  measure: total_new_clients_cashflow_round_off_last_12_months {   # New client cashflows
    type: sum
    label: "new_clients_cad"
    value_format: "#,##0"
    sql: case when ${dim_transctn_cd_12_months_master_list.cashflow_organic_growth}  then
             case when ${new_client_ind}='Yes'  and  ${lost_client_ind} ='No'
                    then ${transaction_amount_cad_dim_in_last_12_months}
                 when ${new_client_ind}='Yes'  and ${lost_client_ind}='Yes' then
                    case when ${transaction_amount_cad_dim_in_last_12_months}>0 then ${transaction_amount_cad_dim_in_last_12_months}
                       else 0
                    end
              end
        end;;
  }

  measure: total_lost_clients_cashflow_round_off_last_12_months {  # Lost client cashflows
    type: sum
    label: "lost_clients_cad"
    value_format: "#,##0"
    sql: ${transaction_amount_cad_dim_in_last_12_months} ;;
    filters: [dim_transctn_cd_12_months_master_list.cashflow_organic_growth: "Yes",lost_client_ind: "Yes" ]
  }

  #### Added the above measure for dashboard_enhancement story [1272927]-Add Summary Card for Asset Change: END ####
  ### Quantiphi area ends here
}
