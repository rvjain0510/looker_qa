- dashboard: client_global_search_ndt_multifilter
  title: Client list results
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: yZrgxVqfTa3AFmxPH868II
  embed_style:
    show_title: true
  elements:
  - title: Client list results
    name: Client list results
    model: ax360_portal
    explore: global_search_client_ndt
    type: looker_grid
    fields: [global_search_client_ndt.client_list_name, global_search_client_ndt.party_date_of_birth_date,
    global_search_client_ndt.party_address, global_search_client_ndt.accounts, global_search_client_ndt.party_primary_email,
    global_search_client_ndt.formatted_party_primary_phone, global_search_client_ndt.aua_converted_to_cad]
    filters: {}
    sorts: [global_search_client_ndt.client_list_name]
    limit: 500
    auto_size_all_columns: true
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
    column_order: [global_search_client_ndt.client_list_name, global_search_client_ndt.party_date_of_birth_date,
    global_search_client_ndt.party_address, global_search_client_ndt.formatted_party_primary_phone, global_search_client_ndt.party_primary_email,
    global_search_client_ndt.accounts, global_search_client_ndt.aua_converted_to_cad]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 200
    series_cell_visualizations:
      global_search_client_ndt.aua_converted_to_cad: false
    series_text_format:
      global_search_client_ndt.client_list_name:
        fg_color: "#2062D4"
        align: left
        bold: true
      global_search_client_ndt.party_date_of_birth_date:
        fg_color: "#525870"
      global_search_client_ndt.party_address:
        fg_color: "#525870"
        align: left
      global_search_client_ndt.accounts:
        fg_color: "#525870"
        align: left
      global_search_client_ndt.party_primary_email:
        fg_color: "#525870"
        align: left
      global_search_client_ndt.formatted_party_primary_phone:
        fg_color: "#525870"
        align: left
      global_search_client_ndt.aua_converted_to_cad:
        fg_color: "#525870"
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [global_search_client_ndt.rep_cd]
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Multifilter: global_search_client_ndt.multifilter
      Client: global_search_client_ndt.client_list_name
      Date of Birth: global_search_client_ndt.party_date_of_birth_date
      Address: global_search_client_ndt.party_address
      Total Market Value (CAD$): global_search_client_ndt.aua_converted_to_cad
      IA Code: global_search_client_ndt.rep_cd
      Accounts: global_search_client_ndt.accounts
      Email: global_search_client_ndt.party_primary_email
      Phone Number: global_search_client_ndt.formatted_party_primary_phone
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
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.client_list_name
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
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.party_date_of_birth_date
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
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.party_address
  - name: Email
    title: Email
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.party_primary_email
  - name: Phone Number
    title: Phone Number
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.formatted_party_primary_phone
  - name: Accounts
    title: Accounts
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
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.aua_converted_to_cad
  - name: Multifilter
    title: Multifilter
    type: field_filter
    default_value: ""
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: global_search_client_ndt
    listens_to_filters: []
    field: global_search_client_ndt.multifilter