view: fact_allctn_holdng {
  derived_table: {
    #datagroup_trigger: data_platform_load
    sql:
    WITH product_asset_allocation_percentage AS  -- All products get an asset allocation percentage per allocation code
           (  SELECT prd.MD_HASH_NAT_KEYS as ProductID,
                     PRODCT_DESC_EN  Product_Name,
                     PRODCT_DESC_FR  Product_Name_Fr,
                     PRODCT_SYMBL SYMBOL,
                     CASE
                    -- BEGIN: Addded code to fix Negative code bug: COALESCE(fap.ALLOCATION_PRODCT_PCT,1) < 0 and >=0 code
                       WHEN COALESCE(fap.ALLOCATION_PRODCT_PCT,1) < 0 THEN 'DBOI'
                       WHEN
                          COALESCE(fap.ALLOCATION_PRODCT_PCT,1) >=  0 AND
                          dallc.ALLOCATION_CODE is null THEN COALESCE(R.ATTRBT_VAL_DESTNTN.VALUE,R1.ATTRBT_VAL_DESTNTN.VALUE, 'OT')
                       ELSE COALESCE(dallc.ALLOCATION_CODE ,'OT')
                     END AS ALLOCATION_CODE,
                     COALESCE(fap.ALLOCATION_PRODCT_PCT,1) AS ASSET_ALLOCATION_CODE_PCTG
              FROM         `@{bq_project_id}.@{bq_dataset_name}.DIM_PRODCT_MV` AS prd
              left JOIN    `@{bq_project_id}.@{bq_dataset_name}.FACT_ALLCTN_PRODCT` AS fap ON fap.NK_HK_DIM_PRODCT = prd.MD_HASH_NAT_KEYS
              LEFT JOIN    `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R ON R.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
                                                   AND R.ATTRBT_NAME_SRC =  'TI_ALTERNATE_TI_TYPE,TI_ALTERNATE_TI_CLASS'
                                                   AND  CONCAT(TRIM(prd.PRODCT_ALTRNT_TP), ",", TRIM(prd.PRODCT_ALTRNT_CLASS)) = R.ATTRBT_VAL_SRC
              LEFT JOIN    `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R1 ON R1.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
                                                    AND R1.ATTRBT_NAME_SRC =  'TI_ALTERNATE_TI_TYPE,TI_ALTERNATE_TI_CLASS'
                                                    AND  CONCAT(prd.PRODCT_ALTRNT_TP, ",[Any]") = R1.ATTRBT_VAL_SRC
              LEFT JOIN    `@{bq_project_id}.@{bq_dataset_name}.DIM_ALLCTN` AS dallc ON dallc.MD_HASH_NAT_KEYS = fap.NK_HK_DIM_ALLCTN
                                                                                       AND dallc.MD_ACTIVE

      WHERE prd.MD_ACTIVE
      ),
      Totalpctg as   -- will use to calculate 'OT' percentage
      ( SELECT ProductID,
      Product_Name,
      Product_Name_Fr,
      SYMBOL,
      SUM(ASSET_ALLOCATION_CODE_PCTG) Total_pctg
      FROM   product_asset_allocation_percentage
      where  ALLOCATION_CODE != 'OT'
      GROUP BY 1,2,3,4),
      Asset_Allocation_final_pct as -- all products get an allocation code percentage with a total of 100% per product
      ( SELECT a.ProductID,
      a.Product_Name,
      a.Product_Name_Fr,
      a.SYMBOL,
      ALLOCATION_CODE,
      ASSET_ALLOCATION_CODE_PCTG - COALESCE((t.Total_pctg-1) / COUNT(1) OVER (PARTITION BY a.ProductID ),0) as ASSET_ALLOCATION_CODE_PCTG
      FROM   product_asset_allocation_percentage a
      LEFT JOIN Totalpctg t on a.ProductID = t.ProductID and a.SYMBOL = t.SYMBOL and t.Total_pctg > 1
      where  ALLOCATION_CODE != 'OT'
      UNION ALL
      SELECT ProductID,
      Product_Name,
      Product_Name_Fr,
      SYMBOL,
      'OT',
      1- Total_pctg
      FROM  Totalpctg
      where  Total_pctg <1
      UNION ALL --added to retrieve products only 'OT'
      SELECT ProductID,
      Product_Name,
      Product_Name_Fr,
      SYMBOL,
      ALLOCATION_CODE,
      1
      FROM   product_asset_allocation_percentage a
      where  ALLOCATION_CODE = 'OT'
      AND NOT EXISTS (SELECT 1 FROM product_asset_allocation_percentage b
      WHERE a.ProductID = b.ProductID and ALLOCATION_CODE != 'OT' )),
      ALLCTN_AUA as   -- calculate the AUA per allocation code and per holding (account/product)
      ( SELECT
      hld.NK_HK_DIM_ACCNT NK_HK_DIM_ACCNT,
      CASE hld.NK_HK_DIM_PRODCT
      WHEN -2 THEN 'CASH' --CASE WHEN AUA_CONVERTED_TO_CAD <0 THEN'Amount Owed' ELSE 'Cash Balance' END
      ELSE alloc.Product_name
      END As PRODCT_DESC,
      CASE hld.NK_HK_DIM_PRODCT
      WHEN -2 THEN 'ENCAISSE' --CASE WHEN AUA_CONVERTED_TO_CAD <0 THEN'Amount Owed' ELSE 'Cash Balance' END
      ELSE alloc.Product_name_Fr
      END As PRODCT_DESC_FR,
      CASE hld.NK_HK_DIM_PRODCT
      WHEN -2 THEN 'CASH'
      ELSE alloc.SYMBOL
      END AS PRODCT_SYMBL,
      CASE
      WHEN hld.NK_HK_DIM_PRODCT =-2 THEN 'CASH'-- CASE WHEN AUA_CONVERTED_TO_CAD < 0 THEN'DBOI' ELSE 'CU' END
      -- may need to add additional condition - 08/29/2023
      WHEN  AUA_CONVERTED_TO_CAD < 0 THEN'DBOI'
      -- end of change - 08/29/2023
      ELSE  COALESCE(alloc.ALLOCATION_CODE,'OT')
      END AS ALLOCATION_CODE,
      CASE
      WHEN hld.NK_HK_DIM_PRODCT =-2 THEN  CASE WHEN AUA_CONVERTED_TO_CAD<0 THEN r1.ATTRBT_VAL_DESTNTN.NAME ELSE r2.ATTRBT_VAL_DESTNTN.NAME END
      -- may need to add additional condition - 08/29/2023
      WHEN  AUA_CONVERTED_TO_CAD < 0 THEN'DBOI'
      ELSE  COALESCE(r.ATTRBT_VAL_DESTNTN.NAME,R3.ATTRBT_VAL_DESTNTN.NAME)
      END AS ALLOCATION_NAME,
      AUA_CONVERTED_TO_CAD * CASE hld.NK_HK_DIM_PRODCT
      WHEN -2 THEN 1
      ELSE COALESCE(alloc.ASSET_ALLOCATION_CODE_PCTG ,1)
      END AS ALLOCATION_AUA
      FROM   `@{bq_project_id}.@{bq_dataset_name}.FACT_HOLDNG_RR` AS hld
      left JOIN Asset_Allocation_final_pct alloc on alloc.ProductID = hld.NK_HK_DIM_PRODCT
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R ON R.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND R.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND alloc.ALLOCATION_CODE  = R.ATTRBT_VAL_SRC
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R1 ON R1.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND R1.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND R1.ATTRBT_VAL_SRC = 'DBOI'
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R2 ON R2.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND R2.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND R2.ATTRBT_VAL_SRC = 'CU'
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC` R3 ON R3.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND R3.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND R3.ATTRBT_VAL_SRC = 'OT'
      where hld.BALANCE_DT = "{{ _user_attributes['latest_holding_date_dev'] }}"),
      Allocation_Agg as
      (   SELECT FARM_FINGERPRINT(ARRAY_TO_STRING(['ID', CAST(fct.NK_HK_DIM_ACCNT AS STRING), fct.PRODCT_SYMBL,fct.PRODCT_DESC,fct.ALLOCATION_CODE,fct.ALLOCATION_NAME],'-','null')) AS ID,
      fct.NK_HK_DIM_ACCNT,
      fct.PRODCT_SYMBL,
      fct.PRODCT_DESC,
      fct.PRODCT_DESC_FR,
      fct.ALLOCATION_CODE,
      SUM(ALLOCATION_AUA) as ALLOCATION_AUA
      FROM
      ALLCTN_AUA fct
      group by 1,2,3,4,5,6),
      Allocation_fin as
      (SELECT ID,
      NK_HK_DIM_ACCNT,
      PRODCT_SYMBL,
      PRODCT_DESC,
      PRODCT_DESC_FR,
      --CASE WHEN PRODCT_DESC ='CASH' and ALLOCATION_AUA>0 then 'CU' else ALLOCATION_CODE end as
      ALLOCATION_CODE,
      ALLOCATION_AUA
      from Allocation_Agg
      )
      SELECT Allocation_fin.ID,
      NK_HK_DIM_ACCNT,
      PRODCT_SYMBL,
      PRODCT_DESC,
      ALLOCATION_CODE,
      RL.ATTRBT_VAL_DESTNTN.NAME as ALLOCATION_NAME,
      'en' as LANG_CD,
      ALLOCATION_AUA
      from Allocation_fin
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC_LOCALE` RL ON RL.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND RL.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND Allocation_fin.ALLOCATION_CODE  = RL.ATTRBT_VAL_SRC
      AND RL.LANG_CD ='en'

      UNION ALL
      SELECT Allocation_fin.ID,
      NK_HK_DIM_ACCNT,
      PRODCT_SYMBL,
      PRODCT_DESC_FR as PRODCT_DESC,
      ALLOCATION_CODE,
      RL.ATTRBT_VAL_DESTNTN.NAME as ALLOCATION_NAME,
      'fr_FR' as LANG_CD,
      ALLOCATION_AUA
      FROM
      Allocation_fin
      left join  `@{bq_project_id}.@{dv_dataset_name}.REF_DATA_DESC_LOCALE` RL ON RL.ATTRBT_NAME_DESTNTN = 'ALLOCATION_CODE'
      AND RL.ATTRBT_NAME_SRC =  'ASSET_ALLOCATION_CODE'
      AND Allocation_fin.ALLOCATION_CODE  = RL.ATTRBT_VAL_SRC
      AND RL.LANG_CD = 'fr_FR'
      ;;
  }


  # to be commented out
  dimension: prodct_desc {
    type: string
    sql: ${TABLE}.PRODCT_DESC ;;
  }

  measure: prodct_desc_msr {
    type: string
    sql: CASE WHEN ${TABLE}.PRODCT_SYMBL ='CASH' THEN
              CASE WHEN ${allocation_aua} >0 THEN
                    CASE WHEN ${TABLE}.LANG_CD ='en' THEN "Cash Balance" ELSE "Solde de l'encaisse" END
              ELSE
                    CASE WHEN ${TABLE}.LANG_CD ='en' THEN "Amount Owed" ELSE "Montant dû" END END
          ELSE ${TABLE}.PRODCT_DESC END;;
  }

  dimension: prodct_symbl {
    type: string
    sql: ${TABLE}.PRODCT_SYMBL ;;
  }

  dimension: allocation_aua_dim {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.ALLOCATION_AUA ;;
  }

  measure: allocation_aua {
    type: sum
    value_format: "#,##0.00"
    sql: ${TABLE}.ALLOCATION_AUA ;;
  }

#Lang translation added - Aug24
  dimension: lang_cd {
    type: string
    sql: ${TABLE}.LANG_CD ;;
  }


  measure: allocation_aua_pct {
    type: percent_of_total
    value_format: "##0.00"
    description: "Allocation AUA Pct"
    sql: ${allocation_aua} ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    value_format: "0"
    sql: ${TABLE}.ID ;;
  }

  dimension: allocation_code {
    type: string
    sql: ${TABLE}.ALLOCATION_CODE ;;
  }

  measure: allocation_code_msr {
    type: string
    sql: CASE WHEN ${allocation_code} ='CASH' THEN
              CASE WHEN ${allocation_aua}>0 THEN "CU" ELSE "DBOI" END
              ELSE ${allocation_code} END;;
  }

  dimension: allocation_name {
    type: string
    sql: ${TABLE}.ALLOCATION_NAME ;;
  }

  measure: allocation_name_msr {
    type: string
    sql: CASE WHEN ${allocation_code} ='CASH' THEN
              CASE WHEN ${allocation_aua}>0 THEN
                    CASE WHEN ${TABLE}.LANG_CD ='en' THEN "Cash and Equivalents" ELSE "Encaisse et quasi-espèces" END
              ELSE
                    CASE WHEN ${TABLE}.LANG_CD ='en' THEN "Debit Balance and Owed Investments" ELSE "Solde débiteur et investissements dûs" END END
              ELSE ${TABLE}.ALLOCATION_NAME END;;
  }




  dimension: nk_hk_dim_accnt {
    type: number
    value_format: "0"
    sql: ${TABLE}.NK_HK_DIM_ACCNT ;;
  }



  measure: count {
    type: count
    drill_fields: [allocation_name]
  }
}
