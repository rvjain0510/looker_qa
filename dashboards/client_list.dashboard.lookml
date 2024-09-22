- dashboard: client_list
  title: Client List
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: KF81JGjhwgr5W67frwmEtg
  embed_style:
    show_title: false
    show_filters_bar: true
  description: ''
  elements:
  - title: ''
    name: ''
    model: ax360_portal
    explore: access_portal_dashboard
    type: looker_grid
    fields: [dashboard.client_list_name, dashboard.party_date_of_birth_date, dashboard.party_address_one_line,
      dashboard.aua_converted_to_cad, dashboard.accounts]
    filters:
    sorts: [dashboard.client_list_name]
    limit: 500
    column_limit: 50
    auto_size_all_columns: true
    dynamic_fields:
    - category: dimension
      expression: concat(${dim_accnt_locale.accnt_tp__name}, " - ", ${dim_accnt.account_number})
      label: Accounts
      value_format:
      value_format_name:
      dimension: accounts
      _kind_hint: dimension
      _type_hint: string
    - category: measure
      expression:
      label: Accounts
      value_format:
      value_format_name:
      based_on: dashboard.accounts
      _kind_hint: measure
      measure: accounts_1
      type: list
      _type_hint: list
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.client_list_name, dashboard.party_date_of_birth_date,
      dashboard.party_address_one_line, dashboard.accounts, dashboard.aua_converted_to_cad]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 200
    size_to_fit: true
    series_cell_visualizations:
      dashboard.aua_converted_to_cad: false
    series_text_format:
      dashboard.client_list_name:
        fg_color: "#2062D4"
        align: left
        bold: true
      dashboard.party_date_of_birth_date:
        fg_color: "#525870"
      dashboard.party_address_one_line:
        fg_color: "#525870"
        align: left
      dashboard.accounts:
        fg_color: "#525870"
        align: left
      dashboard.aua_converted_to_cad:
        fg_color: "#525870"
        align: right
    series_size_column_to_fit: on
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    defaults_version: 1
    title_hidden: true
    listen:
      Client: dim_party.party_name
      Date of Birth: dim_party.party_date_of_birth_date
      Address: dim_party.party_address_one_line
      Total Market Value (CAD$) : dashboard.aua_converted_to_cad
      IA Code: dim_user_rep_cds.rep_cd
      Accounts: dashboard.accounts
    row: 0
    col: 0
    width: 24
    height: 10
  filters:
  - name: Client
    title: Client
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_party.party_name
  - name: Date of Birth
    title: Date of Birth
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_party.party_date_of_birth_date
  - name: Address
    title: Address
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_party.party_address_one_line
  - name: Accounts
    title: Accounts
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_accnt.acct_type_and_number
  - name: IA Code
    title: IA Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_user_rep_cds.rep_cd
  - name: Total Market Value (CAD$)
    title: Total Market Value (CAD$)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.aua_converted_to_cad