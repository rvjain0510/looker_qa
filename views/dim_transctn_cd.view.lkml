view: dim_transctn_cd {

# Code    ENG                   FRA
# CONTR    Contribution          Cotisation
# SP_CONTR  Spousal Contribution  Cotisation conjoint
# CPAY     Payment               Paiement
# WITD     Withdrawal            Retrait
# GRNT     Grant                 Subvention
  derived_table:  {
    datagroup_trigger: data_platform_load
    sql:
WITH
Tran_Group_Codes AS(
    SELECT "CONTR" as GROUP_CODE, "Contribution" as GROUP_NAME_ENG, "Cotisation" as GROUP_NAME_FRA
    UNION ALL
    SELECT "SP_CONTR" as GROUP_CODE, "Spousal Contribution" as GROUP_NAME_ENG, "Cotisation conjoint" as GROUP_NAME_FRA
    UNION ALL
    SELECT "CPAY" as GROUP_CODE, "Payment" as GROUP_NAME_ENG, "Paiement" as GROUP_NAME_FRA
    UNION ALL
    SELECT "WITD" as GROUP_CODE, "Withdrawal" as GROUP_NAME_ENG, "Retrait" as GROUP_NAME_FRA
    UNION ALL
    SELECT "GRNT" as GROUP_CODE, "Grant" as GROUP_NAME_ENG, "Subvention" as GROUP_NAME_FRA
    UNION ALL
    SELECT "OTHERS" as GROUP_CODE, "Others" as GROUP_NAME_ENG, "Autres" as GROUP_NAME_FRA
),
Transaction_Codes AS (
SELECT
  B.ID,
  B.MD_HASH_NAT_KEYS,
  B.TRANSACTION_CODE,
  B.TRANSACTION_LEVEL,
  B.TRANSACTION_DESCR_ENG,
  B.TRANSACTION_DESCR_FRA,
  CASE
    WHEN B.TRANSACTION_CODE IN ("CONTCJ","UACONT","TO-TFS","TO-ESP","TO-RSP","AU-CEL","AU-RER","AU-REE","TO-DSP","AU-REI","CONTNA","CONT")
                                                                    THEN "CONTR"
    WHEN B.TRANSACTION_CODE IN ("SPCONT","CJCONT")
                                                                    THEN "SP_CONTR"
    WHEN B.TRANSACTION_CODE IN ("EAPEI","EPS","PAYMNT","PAYMT","PMT",
                                 "WHTFED","IMPFED","IMPFDE",
                                "IMPPQ","WHTPQ","IMPPQE")
                                                                    THEN "CPAY"
    WHEN (B.TRANSACTION_CODE IN ("IRSNRT","RDAP","PMTAI","PAEEI","EAP","LDAP","PMTVI","DEREG","RESIL","DR","TRFR","PSE","EXTX","RFCESG",
                     "RBIQEE","AIP","RFQESI","RETCPS","PRA","RBEIQE","RT","PIE","AIRRSP","7AE1530","EFT","HBP","WTHCPS","RPA","REP",
                     "BKTSF","TRSFBK","PAE","EFTAWD","RBSCEE","WIREDR")
        OR B.TRANSACTION_CODE LIKE "CK%")
                                                                    THEN "WITD"
    WHEN B.TRANSACTION_CODE IN ("ESCEE","SCEE","CESG","CLB","BEC","CDSB","CDSG","EAPSK","EAPBC")
                                                                    THEN "GRNT"
  ELSE
    "OTHERS"
  END AS TRANSACTION_REG_GROUP,
  B.OPERATION_TYPE,
  ot.ATTRBT_VAL_DESTNTN.NAME_EN AS OPERATION_TYPE_DESCR_EN,
  ot.ATTRBT_VAL_DESTNTN.NAME_FR AS OPERATION_TYPE_DESCR_FR,
  B.TRANSACTION_DISPLAY,
  B.TRANSACTION_SUMMARY,
  B.TRANSACTION_SUMMARY_CODE,
  B.TRANSACTION_SUMMARY_GROUP,
  B.CASHFLOW_ORGANIC_GROWTH
FROM
  `@{bq_project_id}.@{bq_dataset_name}.DIM_TRANSCTN_CD` AS B
LEFT JOIN
  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` AS ot --operation type
ON
  ot.ATTRBT_NAME_SRC = 'OPERATION_TYPE'
  AND ot.ATTRBT_NAME_DESTNTN_SYSTM = 'GCP'
  AND ot.ATTRBT_NAME_DESTNTN = 'OPERATION_TYPE'
  AND ot.ATTRBT_VAL_SRC = B.OPERATION_TYPE
WHERE
  MD_ACTIVE)
SELECT
  B.ID,
  'en' AS LANG_CD,
  B.MD_HASH_NAT_KEYS,
  B.TRANSACTION_CODE,
  B.TRANSACTION_LEVEL,
  B.TRANSACTION_DESCR_ENG AS TRANSACTION_DESCR,
  B.TRANSACTION_REG_GROUP,
  tgc.GROUP_NAME_ENG AS TRANSACTION_REG_GROUP_DESCR,
  B.OPERATION_TYPE,
  B.OPERATION_TYPE_DESCR_EN AS OPERATION_TYPE_DESCR,
  B.TRANSACTION_DISPLAY,
  B.TRANSACTION_SUMMARY,
  B.TRANSACTION_SUMMARY_CODE,
  B.TRANSACTION_SUMMARY_GROUP,
  B.CASHFLOW_ORGANIC_GROWTH
FROM Transaction_Codes AS B
JOIN Tran_Group_Codes AS tgc
ON B.TRANSACTION_REG_GROUP = tgc.GROUP_CODE
UNION ALL
SELECT
  B.ID,
  'fr_FR' AS LANG_CD,
  B.MD_HASH_NAT_KEYS,
  B.TRANSACTION_CODE,
  B.TRANSACTION_LEVEL,
  B.TRANSACTION_DESCR_FRA AS TRANSACTION_DESCR,
  B.TRANSACTION_REG_GROUP,
  tgc.GROUP_NAME_FRA AS TRANSACTION_REG_GROUP_DESCR,
  B.OPERATION_TYPE,
  B.OPERATION_TYPE_DESCR_FR AS OPERATION_TYPE_DESCR,
  B.TRANSACTION_DISPLAY,
  B.TRANSACTION_SUMMARY,
  B.TRANSACTION_SUMMARY_CODE,
  B.TRANSACTION_SUMMARY_GROUP,
  B.CASHFLOW_ORGANIC_GROWTH
FROM Transaction_Codes AS B
JOIN Tran_Group_Codes AS tgc
ON B.TRANSACTION_REG_GROUP = tgc.GROUP_CODE

      ;;
  }

  dimension: transaction_descr {
    type: string
    description: "Description"
    sql: ${TABLE}.TRANSACTION_DESCR ;;
  }

  dimension: transaction_reg_group {
    type: string
    description: "Transaction Regisration Group"
    sql: ${TABLE}.TRANSACTION_REG_GROUP ;;
  }

  dimension: transaction_reg_group_descr {
    type: string
    description: "Transaction Regisration Group Description"
    sql: ${TABLE}.TRANSACTION_REG_GROUP_DESCR ;;
  }



  dimension: lang_cd {
    type: string
    description: "Laguage Code"
    sql: ${TABLE}.LANG_CD ;;
  }


 dimension: cashflow_organic_growth {
    type: yesno
    description: "CashFlow Organic Growth"
    sql: ${TABLE}.CASHFLOW_ORGANIC_GROWTH ;;
  }

  dimension: nk_hk_dim_transctn_cd {
    type: number
    value_format: "0"
    description: "MD_HASH_NAT_KEYS"
    sql: ${TABLE}.MD_HASH_NAT_KEYS ;;
  }


  dimension: operation_type {
    type: string
    description: "Operation Type"
    sql: ${TABLE}.OPERATION_TYPE ;;
  }

  dimension: operation_type_descr_sort {
    type: string
    description: "Operation Type"
    sql: TRANSLATE(${TABLE}.OPERATION_TYPE_DESCR,
    'ÁÀÂÃÄÅàáâãäåĀāąĄæÆÇçćĆčČ¢©đĐďĎÈÉÊËèéêëěĚĒēęĘÌÍÎÏìíîïĪīłŁ£ÑñňŇńŃÒÓÔÕÖòóôõöøŌōřŘ®ŠšśŚßťŤÙÚÛÜùúûüůŮŪūµ×¥ŸÿýÝŽžżŻźŹ',
    'AAAAAAaaaaaaAaaAaACccCcCcCdDdDEEEEeeeeeEEeeEIIIIiiiiIilLLNnnNnNOOOOOooooooOorRRSssSStTUUUUuuuuuUUuuxYYyyYZzzZzZ') ;;
  }

  dimension: operation_type_descr {
    type: string
    description: "Operation Type"
    sql: ${TABLE}.OPERATION_TYPE_DESCR ;;
    order_by_field: operation_type_descr_sort
  }

  dimension: transaction_code {
    type: string
    description: "Transaction Code"
    sql: ${TABLE}.TRANSACTION_CODE ;;
  }



  dimension: transaction_display {
    type: yesno
    description: "Transaction Display"
    sql: ${TABLE}.TRANSACTION_DISPLAY ;;
  }

  dimension: transaction_level {
    type: string
    description: "Transaction Level"
    sql: ${TABLE}.TRANSACTION_LEVEL ;;
  }

  dimension: transaction_summary {
    type: yesno
    description: "Transaction Summary"
    sql: ${TABLE}.TRANSACTION_SUMMARY ;;
  }

  dimension: transaction_summary_code {
    type: string
    description: "Transaction Summary Code"
    sql: ${TABLE}.TRANSACTION_SUMMARY_CODE ;;
  }

  dimension: transaction_summary_group {
    type: string
    description: "Transaction Summary Group"
    sql: ${TABLE}.TRANSACTION_SUMMARY_GROUP ;;
  }
  measure: count {
    type: count
  }
}
