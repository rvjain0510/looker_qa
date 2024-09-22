view: first_name_first {

  derived_table:  {
    # datagroup_trigger: data_platform_load
    sql:
    (SELECT 'Yes' AS first_name_first
    UNION ALL
    SELECT 'No' AS first_name_first);;
  }

  dimension: first_name_first {
    type:  string
    sql:  ${TABLE}.first_name_first ;;
  }

  dimension: is_first_name_first {  ## Created this to validate user_attributes OR first_name_first filter is equal to 'Yes' or not.
    hidden: yes
    type: string
    sql:  case when ${first_name_first.first_name_first} = 'Yes'  OR "{{ _user_attributes['first_name_first'] }}" = 'Yes'  then "Yes" else "No" end;;
  }


}
