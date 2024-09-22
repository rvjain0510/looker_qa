- dashboard: household_global_search_ndt_multifilter
  title: Household list results
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: ZwCCIxeyL76xaDnfvzjs3B
  embed_style:
    show_title: true
  elements:
  - title: Household list results
    name: Household list results
    model: ax360_portal
    explore: global_search_household_ndt
    type: looker_grid
    fields: [global_search_household_ndt.houshld_list_name, global_search_household_ndt.houshld_id,
      global_search_household_ndt.houshld_client_list, global_search_household_ndt.aua_converted_to_cad_one]
    filters: {}
    sorts: [global_search_household_ndt.houshld_list_name]
    limit: 500
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
    header_font_size: '13'
    rows_font_size: '13'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 200
    size_to_fit: true
    series_cell_visualizations:
      global_search_household_ndt.aua_converted_to_cad_one: false
    series_text_format:
      global_search_household_ndt.houshld_list_name:
        fg_color: "#2062D4"
        align: left
        bold: true
      global_search_household_ndt.houshld_client_list:
        fg_color: "#525870"
        align: left
      global_search_household_ndt.aua_converted_to_cad_one:
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
    hidden_fields: [global_search_household_ndt.houshld_id]
    show_null_points: true
    interpolation: linear
    title_hidden: true
    listen:
      Multifilter: global_search_household_ndt.multifilter
      Clients: global_search_household_ndt.houshld_client_list
      IA Code: global_search_household_ndt.rep_cd
      Household: global_search_household_ndt.houshld_list_name
      Total Market Value (CAD$): global_search_household_ndt.aua_converted_to_cad_one
    row: 0
    col: 0
    width: 24
    height: 6
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
    explore: global_search_household_ndt
    listens_to_filters: []
    field: global_search_household_ndt.houshld_list_name
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
    explore: global_search_household_ndt
    listens_to_filters: []
    field: global_search_household_ndt.aua_converted_to_cad_one
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
    explore: global_search_household_ndt
    listens_to_filters: []
    field: global_search_household_ndt.multifilter