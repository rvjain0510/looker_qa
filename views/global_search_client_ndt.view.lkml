view: global_search_client_ndt {
    derived_table: {
      # datagroup_trigger: data_platform_load
      explore_source: access_portal_dashboard {
        column: client_list_name { field: dim_party.party_name }
        column: party_date_of_birth_date { field: dim_party.party_date_of_birth_date }
        column: party_primary_email { field: dashboard.party_primary_email }
        column: party_primary_phone { field: dashboard.party_primary_phone }
        column: formatted_party_primary_phone {field: dim_party.formatted_party_primary_phone}
        column: accounts { field: dim_party.acct_type_and_number_list }
        column: party_address { field: dim_party.party_address_one_line }
        column: aua_converted_to_cad { field: fact_holdng_rr.aua_converted_to_cad }
        # column: houshld_list_name { field: dashboard.houshld_list_name }
        # column: houshld_id { field: dashboard.houshld_id }
        column: dim_party_nk_hk_dim_party_str {field: dim_party.nk_hk_dim_party_str}
        column: rep_cd {field: dashboard.rep_cds}
      }
    }


    dimension:  rep_cd{
      label: "rep_cd"
      description: ""
    }

    dimension: dim_party_nk_hk_dim_party_str {
      type: string
      sql: ${TABLE}.dim_party_nk_hk_dim_party_str ;;
    }
    dimension: client_list_name {
      label: "Client"
      description: ""
      html: <a href="{{link}}&redirect={{dim_party_nk_hk_dim_party_str._value}}">{{ value }}</a>;;
      # <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left; font-weight:600">
    }


  dimension: party_date_of_birth_date {
    label: "client_list_birthday"
    description: ""
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

    # dimension: party_date_of_birth_date {
    #   label: "client_list_birthday"
    #   description: ""
    #   type: date
    #   html:
    #   {% if _user_attributes['locale'] == 'en' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%B %d, %Y" }}
    #   {% elsif value contains "-01-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d janvier %Y" }}
    #   {% elsif value contains "-02-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d février %Y" }}
    #   {% elsif value contains "-03-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d mars %Y" }}
    #   {% elsif value contains "-04-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d avril %Y" }}
    #   {% elsif value contains "-05-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d mai %Y" }}
    #   {% elsif value contains "-06-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d juin %Y" }}
    #   {% elsif value contains "-07-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d juillet %Y" }}
    #   {% elsif value contains "-08-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d août %Y" }}
    #   {% elsif value contains "-09-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d septembre %Y" }}
    #   {% elsif value contains "-10-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d octobre %Y" }}
    #   {% elsif value contains "-11-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d novembre %Y" }}
    #   {% elsif value contains "-12-" and _user_attributes['locale'] == 'fr_FR' %}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d décembre %Y" }}
    #   {%else%}
    #   <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ value | date: "%d %B %Y" }}
    #   {% endif %}
    #   ;;
    # }

    dimension: party_primary_email {
      label: "Party Primary Email"
      description: ""
      # html: <p style="color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
    }

    dimension: party_primary_phone {
      label: "Party Primary Phone"
      description: ""
      # html: <p style="color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
    }

  dimension: formatted_party_primary_phone {
    label: "Party Primary Phone"
    description: ""
    # html: <p style="color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
  }

    #dimension: acct_type_and_number_list{
    #  type: string
    #}

    dimension: accounts {
      label: "accounts"
      #type: string
      #sql: (STRING_AGG(DISTINCT dim_party.acct_type_and_number_list,", " ORDER BY dim_party.acct_type_and_number_list) )  ;;
      # html: <p style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
    }

    dimension: party_address {
      label: "Address"
      description: ""
      # html: <p style="color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
    }

    measure: aua_converted_to_cad {
      type: sum
      label: "aua_converted_to_cad"
      description: ""
      value_format: "#,##0.00"
      # html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px">{{ rendered_value }};;
    }

    # dimension: houshld_list_name {
    #   label: "Dashboard Household"
    #   description: ""
    # }

    # dimension: houshld_id {
    #   description: ""
    # }

    # parameter: big_search_filter {}

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
