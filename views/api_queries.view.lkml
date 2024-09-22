view: api_queries {

  derived_table:  {
    sql:
     Select 1 as dummy;;
  }

  dimension: account_number_link {
    type: string
    label: "account_number_link"
    sql: ${dim_accnt.account_number} ;;
    html:
      {% if dim_accnt.accnt_currnc._value == 'USD'%}
      <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:14px; font-weight:600"><img alt="USD Currency Icon" src="@{icon_source_url}/Country%20-%20USA@2x.png" height=15 width=15>&ensp;<a href="{{link}}&redirect={{ dim_accnt.nk_hk_dim_accnt._value }}">{{ dim_accnt.account_number._value }}</a></p>
      {% else %}
      <p style="white-space:pre; color: #2062D4; font-family:'Open Sans'; font-size:14px; font-weight:600"><img alt="CAD Currency Icon" src="@{icon_source_url}/Country%20-%20CAD@2x.png" height=16 width=16>&ensp;<a href="{{link}}&redirect={{ dim_accnt.nk_hk_dim_accnt._value }}">{{ dim_accnt.account_number._value }}</a></p>
      {% endif %}
      ;;
  }
}
