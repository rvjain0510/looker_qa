# This NDT view is specifically created for AX360 team.
# 1154400 - Created the view to add multifilter client and household in the Access Portal API explore
view: global_search_household_ndt_access_portal_api {
  derived_table: {
    explore_source: access_portal_api_hh {
      column: houshld_list_name { field:  houshlds.houshld_name }
      column: houshld_client_list { field: houshlds.houshld_client_list }
      column: aua_converted_to_cad_one { field: fact_holdng_rr.aua_converted_to_cad }
      column: accounts { field: dim_party.acct_type_and_number_list }
      column: houshld_id { field: houshlds.houshld_id }
      column: party_address { field:  dim_party.addresses }
      column: rep_cd {field: dim_user.dim_user_rep_cds}
      column: is_system_generated {field: houshlds.is_system_generated}
      bind_filters: {
        to_field: dim_user.user_id
        from_field: dim_user.user_id
      }
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
    }


    dimension:  houshld_client_list{
      label: "Dashboard Clients"
      type: string
      sql: array_to_string([houshld_client_list],", ") ;;
    }

    measure: aua_converted_to_cad_one {
      label: "Dashboard Total Market Value (CAD$)"
      value_format: "#,##0.00"
      type: sum
    }

    dimension: houshld_id {
      primary_key: yes
    }

    dimension: party_address {
      label: "Dashboard Address"
    }

    dimension:  rep_cd{
      label: "rep_cd"
    }

    dimension: accounts {
      label: "accounts"
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
