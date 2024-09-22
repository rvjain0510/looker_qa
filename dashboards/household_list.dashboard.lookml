- dashboard: household_list
  title: Household List
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: lEfXS9Hzg1UGmuu4rsRpiX
  elements:
  - title: Household List
    name: Household List
    model: ax360_portal
    explore: access_portal_dashboard_hh
    type: looker_grid
    fields: [dashboard.houshld_list_name, dashboard.houshld_client_list, dashboard.aua_converted_to_cad_one,
      dashboard.houshld_id]
    filters:
      language.lang_pref: "{{ _user_attributes['locale'] }}"
    sorts: [dashboard.houshld_list_name]
    limit: 500
    column_limit: 50
    auto_size_all_columns: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '14'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.houshld_list_name, dashboard.houshld_client_list, dashboard.aua_converted_to_cad_one]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 200
    size_to_fit: true
    series_cell_visualizations:
      dashboard.aua_converted_to_cad_one: false
    series_text_format:
      dashboard.houshld_list_name:
        fg_color: "#2062D4"
        align: left
        bold: true
      dashboard.houshld_client_list:
        fg_color: "#525870"
        align: left
      dashboard.aua_converted_to_cad_one:
        fg_color: "#525870"
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields: [dashboard.houshld_id]
    title_hidden: true
    listen:
      Household: dashboard.houshld_list_name
      Address: houshlds.houshld_addrss
      IA Code: dim_user_rep_cds.rep_cd
      Total Market Value (CAD$): dashboard.aua_converted_to_cad_one
      Clients: dashboard.houshld_client_list
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Household
    title: Household
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
    field: houshlds.houshld_name
  - name: Clients
    title: Clients
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
  - name: Address
    title: Address
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
    field: houshlds.houshld_addrss
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
    field: fact_holdng_rr.aua_converted_to_cad