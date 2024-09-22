view: data_navigator {
  derived_table:  {
    sql:
     Select 1 as dummy

            ;;
  }

  dimension: nk_hk_dim_party {
    type: string
    description: "nk_hk_dim_party Link"
    value_format: "0"
    sql: ${dim_party.nk_hk_dim_party_str} ;;
    link: {
      label: "Client Info"
      url: "https://iapw.cloud.looker.com/dashboards/239?User+ID={{dim_user.user_id._value}}&Lang+Pref={{language.lang_pref._value}}&Nk+Hk+Dim+Party={{dim_party.nk_hk_dim_party_str._value}}"
    }
  }


  dimension: nk_hk_dim_accnt_str_link {
    type: string
    description: "nk_hk_dim_accnt_str Link"
    value_format: "0"
    sql: ${dim_accnt.nk_hk_dim_accnt_str} ;;
    link: {
      label: "Account Info"
      url: "https://iapw.cloud.looker.com/dashboards/242?User+ID={{dim_user.user_id._value}}&Lang+Pref={{language.lang_pref._value}}&Nk+Hk+Dim+Accnt={{dim_accnt.nk_hk_dim_accnt_str._value}}"
    }
  }

  dimension: houshold_id {
    type: string
    description: "houshld_id_str"
    value_format: "0"
    sql: ${houshlds.houshld_id_str} ;;
    link: {
      label: "Household Summary"
      url: "https://iapw.cloud.looker.com/dashboards/247?User+ID={{dim_user.user_id._value}}&Lang+Pref={{language.lang_pref._value}}&Househld+ID={{houshlds.houshld_id_str._value}}"
    }
  }

  parameter: search_filter {
  }

  dimension: search_data {
    type: string
    sql: {{ search_filter._parameter_value }};;
  }


 }
