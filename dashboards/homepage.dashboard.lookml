---
- dashboard: home_page
  title: Home Page
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: v4Dk94jBtvV3bYPOtQpXiN
  elements:
  - title: asset_trend #this title is localized
    name: Asset Trend
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_area
    fields: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month, dashboard.total_aua_last_12_month_master_list]
    sorts: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month desc]
    limit: 13
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(is_null(${last_12_months_master_list.last_12_month_with_mtd_wo_13th_month}),
        no, yes)
      label: Hide NULL Month?
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: hide_null_month
      _type_hint: yesno
    x_axis_gridlines: true
    y_axis_gridlines: false
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.total_aua_without_format,
            id: dashboard.total_aua_without_format, name: Total Market Value (CAD$)}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: ____________________________
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      dashboard.total_aua_without_format: "#003DA5"
    series_labels: {}
    x_axis_label_rotation: 0
    hidden_fields: []
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    ordering: none
    show_null_labels: false
    note_state: collapsed
    note_display: hover
    note_text: asset_trend_note #This note is localized
    hidden_pivots: {}
    hidden_points_if_no: [hide_null_month]
    listen: {}
    row: 3
    col: 0
    width: 24
    height: 8
  - title: total_assets_scorecard #this title is localized
    name: Total Assets
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_aua_multi_value_without_pct]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_aua_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_aua_multi_value_without_pct: false
    title_placement_dashboard.total_aua_multi_value_without_pct: above
    value_format_dashboard.total_aua_multi_value_without_pct: ''
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: total_assets_note #this note is localized
    listen: {}
    row: 0
    col: 0
    width: 8
    height: 3
  - title: total_clients_single_value #this title is localized
    name: Total Clients
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_client_multi_value_without_pct]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_client_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_client_multi_value_without_pct: false
    title_placement_dashboard.total_client_multi_value_without_pct: above
    value_format_dashboard.total_client_multi_value_without_pct: ''
    style_dashboard.total_aua_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_aua_multi_value_without_pct: false
    title_placement_dashboard.total_aua_multi_value_without_pct: above
    value_format_dashboard.total_aua_multi_value_without_pct: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: total_clients_note #this is localized
    listen: {}
    row: 0
    col: 8
    width: 8
    height: 3
  - title: total_households #this title is localized
    name: Total Households
    model: ax360_portal
    explore: ax360_dashboards_hh
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_household_multi_value_without_pct]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_household_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_household_multi_value_without_pct: false
    title_placement_dashboard.total_household_multi_value_without_pct: above
    value_format_dashboard.total_household_multi_value_without_pct: ''
    style_dashboard.total_client_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_client_multi_value_without_pct: false
    title_placement_dashboard.total_client_multi_value_without_pct: above
    value_format_dashboard.total_client_multi_value_without_pct: ''
    style_dashboard.total_aua_multi_value_without_pct: "#3A4245"
    show_title_dashboard.total_aua_multi_value_without_pct: false
    title_placement_dashboard.total_aua_multi_value_without_pct: above
    value_format_dashboard.total_aua_multi_value_without_pct: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: total_households_note #this is localized
    listen: {}
    row: 0
    col: 16
    width: 8
    height: 3
