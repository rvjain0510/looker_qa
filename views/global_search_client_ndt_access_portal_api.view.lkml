# This NDT view is specifically created for AX360 team.
# 1154400 - Created the view to add multifilter client and household in the Access Portal API explore
view: global_search_client_ndt_access_portal_api {
  derived_table: {
    explore_source: access_portal_api {
      column: client_list_name { field: dim_party.party_name }
      column: party_date_of_birth_date { field: dim_party.party_date_of_birth_date }
      column: party_primary_email { field: dim_party.party_primary_email }
      column: party_primary_phone { field: dim_party.party_primary_phone }
      column: formatted_party_primary_phone {field: dim_party.formatted_party_primary_phone}
      column: accounts { field: dim_party.acct_type_and_number_list }
      column: party_address { field: dim_party.party_address_one_line }
      column: aua_converted_to_cad { field: fact_holdng_rr.aua_converted_to_cad }
      column: dim_party_nk_hk_dim_party_str { field: dim_party.nk_hk_dim_party_str }
      column: rep_cd {field: dim_user.dim_user_rep_cds}
      bind_filters: {
        to_field: dim_user.user_id
        from_field: dim_user.user_id
      }
    }
  }


  dimension:  rep_cd{
    label: "rep_cd"
  }

  dimension: dim_party_nk_hk_dim_party_str {
    type: string
    sql: ${TABLE}.dim_party_nk_hk_dim_party_str ;;
    primary_key: yes
  }

  dimension: client_list_name {
    label: "Client"
    html: <a href="{{link}}&redirect={{dim_party_nk_hk_dim_party_str._value}}">{{ value }}</a>;;
  }


  dimension: party_date_of_birth_date {
    label: "client_list_birthday"
    type: date
    html:
      {% if _user_attributes['locale'] == 'en' %}{{ value | date: "%B %d, %Y" }}
      {% elsif value contains "-01-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d janvier %Y" }}
      {% elsif value contains "-02-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d février %Y" }}
      {% elsif value contains "-03-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d mars %Y" }}
      {% elsif value contains "-04-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d avril %Y" }}
      {% elsif value contains "-05-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d mai %Y" }}
      {% elsif value contains "-06-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d juin %Y" }}
      {% elsif value contains "-07-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d juillet %Y" }}
      {% elsif value contains "-08-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d août %Y" }}
      {% elsif value contains "-09-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d septembre %Y" }}
      {% elsif value contains "-10-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d octobre %Y" }}
      {% elsif value contains "-11-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d novembre %Y" }}
      {% elsif value contains "-12-" and _user_attributes['locale'] == 'fr_FR' %}{{ value | date: "%d décembre %Y" }}
      {%else%}{{ value | date: "%d %B %Y" }}
      {% endif %}
      ;;
  }

  dimension: party_primary_email {
    label: "Party Primary Email"
  }

  dimension: party_primary_phone {
    label: "Party Primary Phone"
  }

  dimension: formatted_party_primary_phone {
    label: "Party Primary Phone"
  }

  dimension: accounts {
    label: "accounts"
  }

  dimension: party_address {
    label: "Address"
  }

  measure: aua_converted_to_cad {
    type: sum
    label: "aua_converted_to_cad"
    value_format: "#,##0.00"
  }

  filter: multifilter {
    case_sensitive: no
    sql: {% condition %} ${client_list_name} {% endcondition %}
      or {% condition %} ${party_primary_email} {% endcondition %}
      or {% condition %} ${party_address} {% endcondition %}
      or {% condition %} ${accounts} {% endcondition %}
      or {% condition %} ${rep_cd} {% endcondition %}
      or ${party_primary_phone} LIKE CONCAT("%",${cleaned_ph_number},"%") ;;
  }

  dimension: cleaned_ph_number {
    case_sensitive: no
    sql: REGEXP_REPLACE({% parameter multifilter %}, r'[^a-zA-Z0-9]+', '');;
  }

}
