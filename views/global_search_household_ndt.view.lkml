view: global_search_household_ndt {
    derived_table: {
      # datagroup_trigger: data_platform_load
      explore_source: access_portal_dashboard_hh {
        column: houshld_list_name { field:  houshlds.houshld_name }
        column: houshld_client_list { field: houshlds.houshld_client_list }
        column: aua_converted_to_cad_one { field: fact_holdng_rr.aua_converted_to_cad }
        column: accounts { field: dim_party.acct_type_and_number_list }
        column: houshld_id { field: houshlds.houshld_id }
        column: party_address { field: dashboard.addresses }
        # column: party_primary_email { field: dashboard.emails }
        # column: party_primary_phone { field: dashboard.phone_numbers }
        column: rep_cd {field: dashboard.rep_cds}
        column: is_system_generated {field: houshlds.is_system_generated}
      }
    }
  dimension: is_system_generated {
    type: string
    sql:${TABLE}.is_system_generated  ;;
  }


    dimension: houshld_list_name {
      label: "Dashboard Household"
      description: ""
      html:
      {% if is_system_generated._value == true or is_system_generated._value == 'Yes' %}
      <img alt="System Generated Icon" src="@{icon_source_url}/icon%20-%20Auto-Mantained.svg" height=16 width=16>&ensp;<a href="{{link}}&redirect={{ houshld_id._value }}">{{ houshld_list_name._value }}</a>
      {% else %}
      &nbsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;&thinsp;<a href="{{link}}&redirect={{ houshld_id._value }}">{{ houshld_list_name._value }}</a>
      {% endif %}
      ;;
      #removed:  <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:13px; text-align:left; font-weight:600"> </p>
    }


    #measure: houshld_client_list {
    dimension:  houshld_client_list{
      label: "Dashboard Clients"
      description: ""
      type: string
      #sql: (STRING_AGG(DISTINCT houshld_client_list,", " ORDER BY houshld_client_list)) ;;
      sql: array_to_string([houshld_client_list],", ") ;;
      #html: <p style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:13px; text-align:left">{{rendered_value}}</p>;;
    }
    measure: aua_converted_to_cad_one {
      label: "Dashboard Total Market Value (CAD$)"
      description: ""
      value_format: "#,##0.00"
      type: sum
      #html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ rendered_value }};;
    }
    dimension: houshld_id {
      description: ""
    }
    dimension: party_address {
      label: "Dashboard Address"
      description: ""
    }
    # dimension: party_primary_email {
    #   label: "Dashboard Email"
    #   description: ""
    # }
    # dimension: party_primary_phone {
    #   label: "Dashboard Phone Number"
    #   description: ""
    # }

   # parameter: big_search_filter {}

    # dimension: party_name {
    #   label: "Party Name"
    #   description: ""
    # }

    dimension:  rep_cd{
      label: "rep_cd"
      description: ""
      #html: <div style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:14px">{{ value }};;

    }

    dimension: accounts {
      label: "accounts"
      #type: string
      #sql: (STRING_AGG(DISTINCT acct_type_and_number_list,", " ORDER BY acct_type_and_number_list))  ;;
      #sql: array_to_string([DISTINCT acct_type_and_number_list,", "]) ;;
      #html: <p style="white-space:pre; color: #525870; font-family:'Open Sans'; font-size:12px; height:60px; text-align:left">{{rendered_value}}</p>;;
    }

  filter: multifilter {
    case_sensitive: no
    sql: {% condition %} ${houshld_list_name} {% endcondition %}
    or  {% condition %} ${houshld_client_list} {% endcondition %}
    or {% condition %} ${rep_cd} {% endcondition %}
    or {% condition %} ${party_address} {% endcondition %}
    or {% condition %} ${accounts} {% endcondition %}
    ;;
  }

}
