---
- dashboard: accounts
  title: Accounts
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: eqlyxnqSH1l66eqvFpPd8H
  elements:
  - title: total_accounts_by_account_type
    name: total_accounts_by_account_type
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.filtered_accnt_tp__name_merged, dashboard.total_active_accounts_drill_accnt_tp,
      dashboard.average_assets_per_active_accounts_wo_format]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    sorts: [dashboard.total_active_accounts_drill_accnt_tp desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_active_accounts_drill_accnt_tp}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_active_accounts_drill_accnt_tp} / if(sum(${dashboard.total_active_accounts_drill_accnt_tp}) = 0, null,sum(${dashboard.total_active_accounts_drill_accnt_tp}) )) * 100, 0)"
      label: percent_of_total
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: percent_of_total_1
      _type_hint: number
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.filtered_accnt_tp__name_merged, dashboard.total_active_accounts_drill_accnt_tp,
       percent_of_total_1, visualization, dashboard.average_assets_per_active_accounts_wo_format]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.filtered_accnt_tp__name_merged: account_type_q
      dashboard.total_active_accounts_drill_accnt_tp: total_accounts
      visualization: visualization
      dashboard.average_assets_per_active_accounts_wo_format: average_assets_cad
    series_column_widths:
      dashboard.total_active_accounts_drill_accnt_tp: 130
      dashboard.filtered_accnt_tp__name_merged: 156
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_active_accounts_drill_accnt_tp:
        is_active: false
      visualization:
        is_active: true
        palette:
          palette_id: 87a7d4d4-f2f7-2783-6f02-7a34e0a14cfa
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
        value_display: false
    series_text_format:
      dashboard.total_active_accounts_drill_accnt_tp:
        fg_color: "#003DA5"
        underline: true
      dashboard.filtered_accnt_tp__name_merged:
        bg_color: "#EDEFF8"
      percent_of_total_1:
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: dashboard.total_active_accounts_drill_accnt_tp,
            id: dashboard.total_active_accounts_drill_accnt_tp, name: Total Accounts}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000]#0,,"M";[>=1000]#0,"K";0',
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 6, type: linear}]
    x_axis_label: Plan Type
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000]#0,,"M";[>=1000]#0,"K";0'
    series_colors:
      dashboard.total_active_accounts: "#003DA5"
      dashboard.total_active_accounts_drill: "#003DA5"
      dashboard.total_active_accounts_drill_accnt_tp: "#003DA5"
      RESP: "#00A873"
      Margin: "#C78500"
      RDSP: "#8A3EB0"
      RRSP: "#D13599"
      TFSA: "#668FFF"
    x_axis_datetime_label: ''
    value_labels: legend
    label_type: labPer
    show_null_points: true
    interpolation: linear
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: number_of_open_accounts_within_each_account_type
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 4
    col: 0
    width: 12
    height: 9
  - title: total_accounts_by_program_type
    name: total_accounts_by_program_type
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.total_active_accounts_drill_prgrm_tp, dashboard.filtered_accnt_progrm_tp__value,
      dashboard.average_assets_per_active_accounts_wo_format]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    sorts: [dashboard.total_active_accounts_drill_prgrm_tp desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: concat(${dashboard.filtered_accnt_progrm_tp__value}," ",if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=4,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,1),"K"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=5,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,2),"K"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=6,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,3),"K"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=7,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,1),"M"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=8,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,2),"M"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=9,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,3),"M"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=10,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,1),"B"),if(length(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))=11,concat(substring(to_string(${dashboard.total_active_accounts_drill_prgrm_tp}),1,2),"B"),to_string(${dashboard.total_active_accounts_drill_prgrm_tp}))))))))))
      label: Program Type
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: program_type
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: "${dashboard.total_active_accounts_drill_prgrm_tp}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_active_accounts_drill_prgrm_tp} / if(sum(${dashboard.total_active_accounts_drill_prgrm_tp}) = 0, null,sum(${dashboard.total_active_accounts_drill_prgrm_tp}) )) * 100, 0)"
      label: percent_of_total
      value_format:
      value_format_name: decimal_2
      _kind_hint: measure
      table_calculation: percent_of_total_1
      _type_hint: number
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: qphi
      palette_id: qphi-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    column_order: [dashboard.filtered_accnt_progrm_tp__value, dashboard.total_active_accounts_drill_prgrm_tp,
      percent_of_total_1, visualization, dashboard.average_assets_per_active_accounts_wo_format]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.total_active_accounts_drill_prgrm_tp: total_accounts
      dashboard.filtered_accnt_progrm_tp__value: program_type
      visualization: visualization
      dashboard.average_assets_per_active_accounts_wo_format: average_assets_cad
    series_column_widths:
      dashboard.filtered_accnt_progrm_tp__value: 191
      dashboard.total_active_accounts_drill_prgrm_tp: 132
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_active_accounts_drill_prgrm_tp:
        is_active: false
      visualization:
        is_active: true
        palette:
          palette_id: 1a0c8e92-8836-cdbf-8734-622a70437cfe
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
        value_display: false
    series_text_format:
      dashboard.total_active_accounts_drill_prgrm_tp:
        underline: true
        fg_color: "#003DA5"
      dashboard.filtered_accnt_progrm_tp__value:
        bg_color: "#EDEFF8"
      percent_of_total_1:
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    series_colors:
      Fee-based: "#00A873"
      Managed Account Program: "#C78500"
      SMAs: "#8A3EB0"
      UMA: "#D13599"
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: dashboard.total_active_accounts_drill_prgrm_tp,
            id: dashboard.total_active_accounts_drill_prgrm_tp, name: Total Accounts}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000]#0,,"M";[>=1000]#0,"K";0',
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 9, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000]#0,,"M";[>=1000]#0,"K";0'
    hidden_pivots: {}
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: number_of_open_accounts_within_program_type
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 4
    col: 12
    width: 12
    height: 9
  - title: total_accounts
    name: total_accounts
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_accounts_multi_value]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: 'if(is_null(${dashboard.total_aua_current_month}/${dim_accnt.total_active_accounts}),0,${dashboard.total_aua_current_month}/${dim_accnt.total_active_accounts})

        '
      label: Average Assets per Account
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      table_calculation: average_assets_per_account
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: '0'
    orientation: horizontal
    dividers: false
    style_dashboard.total_accounts_multi_value: "#3A4245"
    show_title_dashboard.total_accounts_multi_value: false
    title_placement_dashboard.total_accounts_multi_value: above
    value_format_dashboard.total_accounts_multi_value: ''
    show_title_hide2: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#003DA5"
    single_value_title: Total Accounts
    comparison_label: Average Assets
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#DAE4FF",
        font_color: !!null '', color_application: {collection_id: qphi, palette_id: qphi-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: dashboard.total_active_accounts_drill,
            id: dashboard.total_active_accounts_drill, name: Total Accounts}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      dashboard.total_active_accounts: "#003DA5"
      dashboard.total_active_accounts_drill: "#003DA5"
      dashboard.total_active_accounts_drill_accnt_tp: "#003DA5"
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: number_of_open_accounts
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 0
    width: 8
    height: 4
  - title: new_accounts
    name: new_accounts
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_new_accounts_multi_value]
    filters:
      dim_accnt.new_account_ind: 'Yes'
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: 'if(is_null(${dashboard.total_aua_current_month}/${dim_accnt.total_active_accounts}),0,${dashboard.total_aua_current_month}/${dim_accnt.total_active_accounts})

        '
      label: Average Assets per Account
      value_format:
      value_format_name: usd_0
      _kind_hint: measure
      table_calculation: average_assets_per_account
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_dashboard.total_new_accounts_multi_value: "#3A4245"
    show_title_dashboard.total_new_accounts_multi_value: false
    title_placement_dashboard.total_new_accounts_multi_value: above
    value_format_dashboard.total_new_accounts_multi_value: ''
    style_hide: "#3A4245"
    show_title_hide: false
    title_placement_hide: above
    value_format_hide: ''
    show_comparison_hide: false
    style_dashboard.total_accounts_multi_value: "#3A4245"
    show_title_dashboard.total_accounts_multi_value: false
    title_placement_dashboard.total_accounts_multi_value: above
    value_format_dashboard.total_accounts_multi_value: ''
    style_hide1: "#3A4245"
    show_title_hide1: false
    title_placement_hide1: above
    value_format_hide1: ''
    show_comparison_hide1: false
    show_title_hide2: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#003DA5"
    single_value_title: Total Accounts
    comparison_label: Average Assets
    conditional_formatting: [{type: not null, value: !!null '', background_color: "#DAE4FF",
        font_color: !!null '', color_application: {collection_id: qphi, palette_id: qphi-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
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
    y_axes: [{label: '', orientation: bottom, series: [{axisId: dashboard.total_active_accounts_drill,
            id: dashboard.total_active_accounts_drill, name: Total Accounts}], showLabels: false,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      dashboard.total_active_accounts: "#003DA5"
      dashboard.total_active_accounts_drill: "#003DA5"
      dashboard.total_active_accounts_drill_accnt_tp: "#003DA5"
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: number_of_new_accounts_opened
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 8
    width: 8
    height: 4
  - title: closed_accounts
    name: closed_accounts
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_lost_accounts_multi_value]
    filters:
      dim_accnt.lost_account_ind: 'Yes'
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_lost_accounts_multi_value: "#3A4245"
    show_title_dashboard.total_lost_accounts_multi_value: false
    title_placement_dashboard.total_lost_accounts_multi_value: above
    value_format_dashboard.total_lost_accounts_multi_value: ''
    style_hide: "#3A4245"
    show_title_hide: false
    title_placement_hide: above
    value_format_hide: ''
    show_comparison_hide: false
    show_title_hide1: false
    style_hide2: "#3A4245"
    show_title_hide2: false
    title_placement_hide2: above
    value_format_hide2: ''
    show_comparison_hide2: false
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
    note_text: number_of_accounts_closed
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 16
    width: 8
    height: 4
  filters:
  - name: IA Code
    title: ia_code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: ax360_dashboards
    listens_to_filters: [RVP Name, Branch Name, Team Name]
    field: dashboard.rep_cd_with_rep_cd_name
  - name: RVP Name
    title: RVP Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: ax360_dashboards
    listens_to_filters: [IA Code, Branch Name, Team Name]
    field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
  - name: Branch Name
    title: Branch Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: ax360_dashboards
    listens_to_filters: [IA Code, RVP Name, Team Name]
    field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
  - name: Team Name
    title: Team Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
    model: ax360_portal
    explore: ax360_dashboards
    listens_to_filters: [IA Code, RVP Name, Branch Name]
    field: filtered_rep_cd_by_rvp_branch_team.team_name
