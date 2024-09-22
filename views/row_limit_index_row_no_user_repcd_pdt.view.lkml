# This PDT is created for AX360 to provide rownumber as a index column for user - repcd - usertype combination.
view: row_limit_index_row_no_user_repcd_pdt {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: data_platform_load
    sql: SELECT
          dim_user_unnested.USERID  AS dim_user_unnested_user_id,
          dim_user_unnested.REP_CODE  AS dim_user_unnested_rep_cds,
          dim_user_unnested.USER_TYPE  AS dim_user_unnested_user_type,
          dim_houshld_accnt_pdt.nk_hk_dim_regstr_reprsnttv AS nk_hk_dim_regstr_reprsnttv,
          ROW_NUMBER() OVER(order by dim_user_unnested.USERID,dim_user_unnested.REP_CODE,dim_user_unnested.USER_TYPE) AS index_row_no
          -- Updated the view name from dim_houshld_accnt_pdt to dim_houshld_accnt_pdt_no_dim_user_api for 1276440-adjustment-to-firm-reporting
          FROM ${dim_houshld_accnt_pdt_no_dim_user_api.SQL_TABLE_NAME}  AS dim_houshld_accnt_pdt
          INNER JOIN ${dim_user_unnested.SQL_TABLE_NAME}  AS dim_user_unnested ON dim_houshld_accnt_pdt.NK_HK_DIM_REGSTR_REPRSNTTV = dim_user_unnested.NK_HK_DIM_REGSTR_REPRSNTTV
          GROUP BY
          1,
          2,
          3,
          4
          ORDER BY
          5 ;;
  }

  dimension: user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.dim_user_unnested_user_id ;;
  }

  dimension: rep_cds {
    type: string
    sql: ${TABLE}.dim_user_unnested_rep_cds ;;
  }

  dimension: user_type {
    type: string
    sql: case when ${TABLE}.dim_user_unnested_user_type = "Head Office" then "EMPLOYEE" else "ADVISOR" end ;;
  }

  dimension: nk_hk_dim_regstr_reprsnttv {
    type: string
    sql: ${TABLE}.nk_hk_dim_regstr_reprsnttv ;;
  }

  dimension: index_row_no {
    type: number
    sql: ${TABLE}.index_row_no ;;
  }
}
