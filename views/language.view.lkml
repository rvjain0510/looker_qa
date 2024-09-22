view: language {

  derived_table:  {
    # datagroup_trigger: data_platform_load
    sql:
    (SELECT 'en' AS LANG_PREF
    UNION ALL
    SELECT 'fr_FR' AS LANG_PREF);;
  }

  dimension: lang_pref {
    type:  string
    sql:  ${TABLE}.LANG_PREF ;;
  }

  dimension: is_lang_pref_fr {  ## Created this to validate user_attributes OR lang_pref filter is equal to 'fr_FR' or not.
    hidden: yes
    type: string
    sql:  case when ${language.lang_pref} = 'fr_FR'  OR "{{ _user_attributes['locale'] }}" = 'fr_FR'  then "Yes" else "No" end;;
  }


}
