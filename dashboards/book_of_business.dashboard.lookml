---
- dashboard: book_of_business
  title: Book of Business
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: MDgFdQzDq7TMzCLertroAs
  elements:
  - title: asset_by_program_type
    name: asset_by_program_type
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_grid
    fields: [dashboard.accnt_progrm_tp__value, dashboard.total_aua_current_month_drill_prgrm_tp]
    sorts: [dashboard.total_aua_current_month_drill_prgrm_tp desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_aua_current_month_drill_prgrm_tp}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_aua_current_month_drill_prgrm_tp} / if(sum(${dashboard.total_aua_current_month_drill_prgrm_tp}) = 0, null,sum(${dashboard.total_aua_current_month_drill_prgrm_tp}) )) * 100, 0)"
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
    column_order: [dashboard.accnt_progrm_tp__value, dashboard.total_aua_current_month_drill_prgrm_tp,
      percent_of_total_1, visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.accnt_progrm_tp__value: program_type
      dashboard.total_aua_current_month_drill_prgrm_tp: total_market_value_cad
      visualization: visualization
    series_column_widths:
      dashboard.accnt_progrm_tp__value: 199.005
      dashboard.total_aua_current_month_drill_prgrm_tp: 147
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_aua_current_month_drill_prgrm_tp:
        is_active: false
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 191590a6-41f7-0b32-660e-0dd49b19dd61
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
    series_text_format:
      dashboard.total_aua_current_month_drill_prgrm_tp:
        fg_color: "#003DA5"
      dashboard.accnt_progrm_tp__value:
        bg_color: "#EDEFF8"
      percent_of_total_1:
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    value_labels: legend
    label_type: labVal
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: AUA, orientation: left, series: [{axisId: dashboard.total_aua_current_month_drill_prgrm_tp,
            id: dashboard.total_aua_current_month_drill_prgrm_tp, name: Total AUA}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000000]$#,,,"B";[>=1000000]$#,,"M";$0',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: Program Type
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    legend_position: center
    label_value_format: '[>=1000000000]$#,,,"B";[>=1000000]$#,,"M";$0'
    point_style: none
    series_colors:
      dashboard.total_aua: "#003daf"
      Fee-based: "#00A873"
      Managed Account Program: "#C78500"
      SMAs: "#8A3EB0"
      UMA: "#D13599"
      'null': "#668FFF"
      dashboard.total_aua_current_month_drill_prgrm_tp: "#668FFF"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    inner_radius: 50
    defaults_version: 1
    hidden_pivots: {}
    note_state: expanded
    note_display: hover
    note_text: asset_by_program_type_note
    hidden_fields: []
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 11
    col: 12
    width: 12
    height: 5
  - title: top_mutual_funds
    name: top_mutual_funds
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_grid
    fields: [dashboard.total_aua_current_month_drill_top_10, dashboard.product_description,
      dashboard.prodct_id]
    filters:
      dashboard.prodct_tp: MF
    sorts: [dashboard.total_aua_current_month_drill_top_10 desc]
    limit: 5000
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_aua_current_month_drill_top_10}"
      label: Visualization
      value_format:
      value_format_name: usd
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_aua_current_month_drill_top_10} / if(${dashboard.total_aua_current_month_drill_top_10:total} = 0, null,${dashboard.total_aua_current_month_drill_top_10:total} )) * 100, 0)"
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
    column_order: [dashboard.product_description, dashboard.total_aua_current_month_drill_top_10,
      percent_of_total_1, visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.product_description: description
      dashboard.total_aua_current_month_drill_top_10: total_market_value_cad
      visualization: visualization
    series_column_widths:
      dashboard.total_aua_current_month_drill_top_10: 186
      dashboard.product_description: 301
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_aua_current_month_drill_top_10:
        is_active: false
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 3635f1dc-f6b9-9cd4-d665-082ddccbd1f8
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
    series_text_format:
      dashboard.total_aua_current_month_drill_top_10: {}
      dashboard.product_description:
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: AUA, orientation: bottom, series: [{axisId: dashboard.total_aua_current_month_drill_top_10,
            id: dashboard.total_aua_current_month_drill_top_10, name: Total AUA}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000000]$#0,,,"B";[>=1000000]$#0,,"M";$0',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Mutual Funds
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000000]$#0,,,"B";[>=1000000]$#0,,"M";$0'
    series_colors:
      dashboard.total_aua_current_month_drill_top_10: "#003DA5"
    label_color: []
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: top_mutual_funds_note
    hidden_fields: [dashboard.prodct_id]
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 16
    col: 12
    width: 12
    height: 7
  - title: top_holdings
    name: top_holdings
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_grid
    fields: [dashboard.total_aua_current_month_drill_top_10, dashboard.product_description,
      dashboard.prodct_id]
    sorts: [dashboard.total_aua_current_month_drill_top_10 desc]
    limit: 5000
    column_limit: 50
    total: true
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_aua_current_month_drill_top_10}"
      label: Visualization
      value_format:
      value_format_name: usd
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_aua_current_month_drill_top_10} / if(${dashboard.total_aua_current_month_drill_top_10:total} = 0, null,${dashboard.total_aua_current_month_drill_top_10:total} )) * 100, 0)"
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
    column_order: [dashboard.product_description, dashboard.total_aua_current_month_drill_top_10,
      percent_of_total_1, visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.product_description: description
      dashboard.total_aua_current_month_drill_top_10: total_market_value_cad
      visualization: visualization
    series_column_widths:
      dashboard.total_aua_current_month_drill_top_10: 186
      dashboard.product_description: 301
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_aua_current_month_drill_top_10:
        is_active: false
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 5bc16e8e-0437-def2-4fed-2820ff076969
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
    series_text_format:
      dashboard.total_aua_current_month_drill_top_10: {}
      dashboard.product_description:
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: AUA, orientation: bottom, series: [{axisId: dashboard.total_aua_current_month_drill_top_10,
            id: dashboard.total_aua_current_month_drill_top_10, name: Total AUA}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000000]$#0,,,"B";[>=1000000]$#0,,"M";$0',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Holdings
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000000]$#0,,,"B";[>=1000000]$#0,,"M";$0'
    series_colors:
      dashboard.total_aua_current_month_drill_top_10: "#00A873"
    label_color: []
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: top_10_holdings_note
    hidden_fields: [dashboard.prodct_id]
    hidden_points_if_no: [hide]
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 16
    col: 0
    width: 12
    height: 7
  - name: asset_change_breakdown
    title: asset_change_breakdown
    note_state: collapsed
    note_display: hover
    note_text: asset_change_breakdown_note
    merged_queries:
    - model: ax360_portal
      explore: ax360_dashboards_historical
      type: table
      fields: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month, dashboard.total_aua_last_12_month_master_list,
        last_12_months_master_list.last_12_months_month]
      sorts: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month desc]
      limit: 13
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: " offset(if(is_null(${dashboard.total_aua_last_12_month_master_list}),0,${dashboard.total_aua_last_12_month_master_list}),\
          \ 1)\n"
        label: Total AUA (Previous Month)
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: total_aua_previous_month
        _type_hint: number
      - category: table_calculation
        expression: if(is_null(${dashboard.total_aua_last_12_month_master_list}),0,${dashboard.total_aua_last_12_month_master_list})-${total_aua_previous_month}
        label: AUA Change
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: aua_change
        _type_hint: number
      - category: table_calculation
        expression: if(row()=13, no,yes)
        label: Hide 13th row
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: hide_13th_row
        _type_hint: yesno
        is_disabled: true
      join_fields: []
    - model: ax360_portal
      explore: ax360_dashboards_historical
      type: table
      fields: [dashboard.trad_dt_month_with_mtd, dashboard.existing_client_cashflow_drill,
        dashboard.new_clients_cashflow_drill, dashboard.lost_clients_cashflow_drill,
        fact_transctn_rr.trad_dt_month]
      sorts: [fact_transctn_rr.trad_dt_month desc]
      limit: 12
      column_limit: 50
      join_fields:
      - field_name: fact_transctn_rr.trad_dt_month
        source_field_name: last_12_months_master_list.last_12_months_month
    show_sql_query_menu_options: false
    column_order: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month,
      total_growth, net_client_growth, net_client_growth_viz, dashboard.existing_client_cashflow_drill,
      existing_cf_viz, dashboard.new_clients_cashflow_drill, new_client_cf_viz, dashboard.lost_clients_cashflow_drill,
      lost_client_cf_viz, market_variation, market_variation_cf]
    show_totals: true
    show_row_totals: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    truncate_header: false
    size_to_fit: true
    minimum_column_width: 75
    series_labels:
      dashboard.existing_client_cashflow_drill: existing_clients_cad
      dashboard.new_clients_cashflow_drill: new_clients_cad
      dashboard.lost_clients_cashflow_drill: lost_clients_cad
      existing_cf_viz: visualization
      new_client_cf_viz: visualization
      lost_client_cf_viz: visualization
      market_variation_cf: visualization
      market_variation: market_variation_cad
      last_12_months_master_list.last_12_month_with_mtd_wo_13th_month: month
      dashboard.total_aua_last_12_month_master_list: total_market_value_cad
      month: month
      net_client_growth: net_client_growth_cad
      net_client_growth_viz: visualization
      total_growth: total_growth_cad
    series_column_widths: {}
    series_cell_visualizations:
      dashboard.existing_client_cashflow_drill:
        is_active: false
        value_display: false
      existing_cf_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: c34f3b2c-f413-d973-23b8-882954d0df06
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      new_client_cf_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: 5c30b7ef-c62b-ee66-ceab-94a95156a6b3
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      lost_client_cf_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: 65d649d1-05d7-835a-8d43-4dda4834a181
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      market_variation_cf:
        is_active: true
        value_display: false
        palette:
          palette_id: aa7898f1-223e-e2ee-b56c-8a7adb670498
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      dashboard.lost_clients_cashflow_drill:
        is_active: false
      dashboard.new_clients_cashflow_drill:
        is_active: false
        value_display: false
      net_client_growth_viz:
        is_active: true
        value_display: false
    series_text_format:
      dashboard.existing_client_cashflow_drill:
        underline: true
        fg_color: "#003DA5"
      dashboard.new_clients_cashflow_drill:
        underline: true
        fg_color: "#003DA5"
      dashboard.lost_clients_cashflow_drill:
        fg_color: "#003DA5"
        underline: true
      market_variation:
        align: right
      dashboard.trad_dt_month_with_mtd:
        bg_color: "#EDEFF8"
      dashboard.last_12_month_with_mtd:
        bg_color: "#EDEFF8"
      last_12_months_master_list.last_12_month_with_mtd:
        bg_color: "#EDEFF8"
      month:
        bg_color: "#EDEFF8"
      net_client_growth:
        align: right
      total:
        align: right
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-diverging-0, options: {
            constraints: {min: {type: minimum}, mid: {type: number, value: 0}, max: {
                type: maximum}}, mirror: true, reverse: false, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: [total_growth, net_client_growth, market_variation]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_value_format: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.existing_client_cashflow_drill,
            id: dashboard.existing_client_cashflow_drill, name: Existing Client Cashflow},
          {axisId: dashboard.new_clients_cashflow_drill, id: dashboard.new_clients_cashflow_drill,
            name: New Client Cashflow}, {axisId: dashboard.lost_clients_cashflow_drill,
            id: dashboard.lost_clients_cashflow_drill, name: Lost Client Cashflow}],
        showLabels: true, showValues: true, valueFormat: '$#0,,"M"', unpinAxis: false,
        tickDensity: default, tickDensityCustom: 5, type: linear}, {label: !!null '',
        orientation: right, series: [{axisId: market_variation, id: market_variation,
            name: Market Variation}], showLabels: true, showValues: true, valueFormat: '$#0,,"M"',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    x_axis_label: month
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    legend_position: center
    series_types: {}
    point_style: none
    series_colors:
      fact_transctn_rr.new_clients_cashflow: "#00A873"
      fact_transctn_rr.lost_clients_cashflow: "#C78500"
      market_variation: "#003DA5"
      dashboard.new_clients_cashflow_drill: "#00A873"
      dashboard.lost_clients_cashflow_drill: "#5B2F75"
      dashboard.existing_client_cashflow_drill: "#9E6A00"
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    x_axis_datetime_label: "%b- %y"
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    type: looker_grid
    hidden_fields: [total_aua_previous_month, aua_change, dashboard.trad_dt_month_with_mtd,
      last_12_months_master_list.last_12_months_month, dashboard.last_12_month_with_mtd,
      last_12_months_master_list.last_12_month_with_mtd, dashboard.total_aua_last_12_month_master_list]
    hidden_points_if_no: [hide_null_month, hide_null]
    hide_totals: false
    hide_row_totals: false
    query_fields:
      measures:
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: " Total Market Value (CAD$)"
        label_from_parameter:
        label_short: Total Market Value (CAD$)
        map_layer:
        name: dashboard.total_aua_last_12_month_master_list
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total Market Value (CAD$)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_last_12_month_master_list
        suggest_explore: ax360_dashboards_historical
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1184"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: 'coalesce(${fact_holdng_rr_12_months_master_list.aua_converted_to_cad_last_business_day_of_months},0) '
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: total_aua_previous_month
        label: Total AUA (Previous Month)
        value_format: "#,##0"
        is_disabled:
        sortable: false
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: aua_change
        label: AUA Change
        value_format: "#,##0"
        is_disabled:
        sortable: false
        aggregate: true
        can_filter: false
        permanent: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: true
        is_filter: false
        is_numeric: true
        label: Existing Client Cashflow Drill
        label_from_parameter:
        label_short: Existing Client Cashflow Drill
        map_layer:
        name: dashboard.existing_client_cashflow_drill
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Existing Client Cashflow Drill
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.existing_client_cashflow_drill
        suggest_explore: ax360_dashboards_historical
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1702"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_transctn_rr.total_existing_clients_cashflow} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: true
        label: New Clients Cashflow Drill
        label_from_parameter:
        label_short: New Clients Cashflow Drill
        map_layer:
        name: dashboard.new_clients_cashflow_drill
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: New Clients Cashflow Drill
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.new_clients_cashflow_drill
        suggest_explore: ax360_dashboards_historical
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1538"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_transctn_rr.total_new_clients_cashflow} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: right
        can_filter: false
        category: measure
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: true
        is_filter: false
        is_numeric: true
        label: Lost Clients Cashflow Drill
        label_from_parameter:
        label_short: Lost Clients Cashflow Drill
        map_layer:
        name: dashboard.lost_clients_cashflow_drill
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Lost Clients Cashflow Drill
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.lost_clients_cashflow_drill
        suggest_explore: ax360_dashboards_historical
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1626"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_transctn_rr.total_lost_clients_cashflow} "
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: " Month"
        label_from_parameter:
        label_short: Month
        map_layer:
        name: last_12_months_master_list.last_12_month_with_mtd_wo_13th_month
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        view: last_12_months_master_list
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: last_12_months_master_list
        dimension_group:
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: last_12_months_master_list
        suggest_dimension: last_12_months_master_list.last_12_month_with_mtd_wo_13th_month
        suggest_explore: ax360_dashboards_historical
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Flast_12_months_master_list.view.lkml?line=44"
        permanent: true
        source_file: views/last_12_months_master_list.view.lkml
        source_file_path: prj_ax360_portal/views/last_12_months_master_list.view.lkml
        sql: |-
          CASE WHEN  ${last_12_months_date} >= DATE_SUB( ${last_holding_date.last_update_date}, INTERVAL 11 month) THEN
                     CASE WHEN FORMAT_DATE('%Y-%m',${last_12_months_date})= FORMAT_DATE('%Y-%m',  cast("{{ _user_attributes['latest_holding_date'] }}" as date) )  THEN '{{ _localization['month_to_date'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="January" THEN '{{ _localization['january'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="February" THEN '{{ _localization['february'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="March" THEN '{{ _localization['march'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="April" THEN '{{ _localization['april'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="May" THEN '{{ _localization['may'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="June" THEN '{{ _localization['june'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="July" THEN '{{ _localization['july'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="August" THEN '{{ _localization['august'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="September" THEN '{{ _localization['september'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="October" THEN '{{ _localization['october'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="November" THEN '{{ _localization['november'] }}'
                        WHEN cast(format_date('%B',${last_12_months_date}) as string) ="December" THEN '{{ _localization['december'] }}'
                        END
                    END
        sql_case:
        filters:
        times_used: 0
        sorted:
          desc: false
          sort_index: 0
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Last 12 Months Date
        fill_style: range
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Last 12 Months Month
        label_from_parameter:
        label_short: Last 12 Months Month
        map_layer:
        name: last_12_months_master_list.last_12_months_month
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: date_month
        user_attribute_filter_types:
        - datetime
        - advanced_filter_datetime
        value_format:
        view: last_12_months_master_list
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: last_12_months_master_list
        dimension_group: last_12_months_master_list.last_12_months
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: last_12_months_master_list
        suggest_dimension: last_12_months_master_list.last_12_months_month
        suggest_explore: ax360_dashboards_historical
        suggestable: false
        is_fiscal: false
        is_timeframe: true
        can_time_filter: false
        time_interval:
          name: month
          count: 1
        lookml_link: "/projects/prj_ax360_portal/files/views%2Flast_12_months_master_list.view.lkml?line=10"
        permanent: true
        source_file: views/last_12_months_master_list.view.lkml
        source_file_path: prj_ax360_portal/views/last_12_months_master_list.view.lkml
        sql: "${TABLE}.last_12_months_date "
        sql_case:
        filters:
        times_used: 0
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label:
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: true
        is_filter: false
        is_numeric: false
        label: " Month"
        label_from_parameter:
        label_short: Month
        map_layer:
        name: dashboard.trad_dt_month_with_mtd
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: string
        user_attribute_filter_types:
        - string
        - advanced_filter_string
        value_format:
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Month
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.trad_dt_month_with_mtd
        suggest_explore: ax360_dashboards_historical
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1394"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "CASE WHEN ${fact_transctn_rr.trad_dt_month}= (FORMAT_DATE('%Y-%m', ${last_holding_date.last_update_date}\
          \ ))  THEN '{{ _localization['month_to_date'] }}'\n              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date})\
          \ as string) =\"January\" THEN '{{ _localization['january'] }}'\n      \
          \        WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as\
          \ string) =\"February\" THEN '{{ _localization['february'] }}'\n       \
          \       WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as\
          \ string) =\"March\" THEN '{{ _localization['march'] }}'\n             \
          \ WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string)\
          \ =\"April\" THEN '{{ _localization['april'] }}'\n              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date})\
          \ as string) =\"May\" THEN '{{ _localization['may'] }}'\n              WHEN\
          \ cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string) =\"\
          June\" THEN '{{ _localization['june'] }}'\n              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date})\
          \ as string) =\"July\" THEN '{{ _localization['july'] }}'\n            \
          \  WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as string)\
          \ =\"August\" THEN '{{ _localization['august'] }}'\n              WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date})\
          \ as string) =\"September\" THEN '{{ _localization['september'] }}'\n  \
          \            WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date})\
          \ as string) =\"October\" THEN '{{ _localization['october'] }}'\n      \
          \        WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as\
          \ string) =\"November\" THEN '{{ _localization['november'] }}'\n       \
          \       WHEN cast(format_date('%B',${fact_transctn_rr.trad_dt_date}) as\
          \ string) =\"December\" THEN '{{ _localization['december'] }}'\n       \
          \       END "
        sql_case:
        filters:
        times_used: 0
      table_calculations:
      - label: Market Variation
        name: market_variation
        expression: |-
          if(is_null(${aua_change}),0,${aua_change}) -
            (if(is_null(${dashboard.existing_client_cashflow_drill}),0,${dashboard.existing_client_cashflow_drill})+
               if(is_null(${dashboard.new_clients_cashflow_drill}),0,${dashboard.new_clients_cashflow_drill})+
                    if(is_null(${dashboard.lost_clients_cashflow_drill}),0,${dashboard.lost_clients_cashflow_drill}))
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: Existing CF (Viz)
        name: existing_cf_viz
        expression: "${dashboard.existing_client_cashflow_drill}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: New Client CF (Viz)
        name: new_client_cf_viz
        expression: "${dashboard.new_clients_cashflow_drill}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: Lost Client CF (Viz)
        name: lost_client_cf_viz
        expression: "${dashboard.lost_clients_cashflow_drill}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: market Variation CF
        name: market_variation_cf
        expression: "${market_variation}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      - label: Hide NULL?
        name: hide_null
        expression: " NOT is_null(${last_12_months_master_list.last_12_month_with_mtd_wo_13th_month})"
        can_pivot: false
        sortable: true
        type: yesno
        align: left
        measure: false
        is_table_calculation: true
        dynamic: true
        value_format:
      - label: Net Client Growth
        name: net_client_growth
        expression: round(coalesce(${dashboard.existing_client_cashflow_drill},0)
          +  coalesce(${dashboard.new_clients_cashflow_drill},0) + coalesce(${dashboard.lost_clients_cashflow_drill},0),0)
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Net Client Growth (Viz)
        name: net_client_growth_viz
        expression: "${net_client_growth}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Total Growth
        name: total_growth
        expression: 'coalesce(${dashboard.existing_client_cashflow_drill},0) + coalesce(${dashboard.new_clients_cashflow_drill},0)
          + coalesce(${dashboard.lost_clients_cashflow_drill},0) + coalesce(${market_variation},0) '
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    sorts: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month]
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        if(is_null(${aua_change}),0,${aua_change}) -
          (if(is_null(${dashboard.existing_client_cashflow_drill}),0,${dashboard.existing_client_cashflow_drill})+
             if(is_null(${dashboard.new_clients_cashflow_drill}),0,${dashboard.new_clients_cashflow_drill})+
                  if(is_null(${dashboard.lost_clients_cashflow_drill}),0,${dashboard.lost_clients_cashflow_drill}))
      label: Market Variation
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: market_variation
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.existing_client_cashflow_drill}"
      label: Existing CF (Viz)
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: existing_cf_viz
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.new_clients_cashflow_drill}"
      label: New Client CF (Viz)
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: new_client_cf_viz
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.lost_clients_cashflow_drill}"
      label: Lost Client CF (Viz)
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: lost_client_cf_viz
      _type_hint: number
    - category: table_calculation
      expression: "${market_variation}"
      label: market Variation CF
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: market_variation_cf
      _type_hint: number
    - category: table_calculation
      expression: " NOT is_null(${last_12_months_master_list.last_12_month_with_mtd_wo_13th_month})"
      label: Hide NULL?
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: hide_null
      _type_hint: yesno
    - category: table_calculation
      expression: round(coalesce(${dashboard.existing_client_cashflow_drill},0) +  coalesce(${dashboard.new_clients_cashflow_drill},0)
        + coalesce(${dashboard.lost_clients_cashflow_drill},0),0)
      label: Net Client Growth
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: net_client_growth
      _type_hint: number
    - category: table_calculation
      expression: "${net_client_growth}"
      label: Net Client Growth (Viz)
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: net_client_growth_viz
      _type_hint: number
    - category: table_calculation
      expression: 'coalesce(${dashboard.existing_client_cashflow_drill},0) + coalesce(${dashboard.new_clients_cashflow_drill},0)
        + coalesce(${dashboard.lost_clients_cashflow_drill},0) + coalesce(${market_variation},0) '
      label: Total Growth
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: total_growth
      _type_hint: number
    listen:
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 31
    col: 0
    width: 24
    height: 8
  - title: asset_allocation
    name: asset_allocation
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_grid
    fields: [dashboard.allocation_name_locale, dashboard.total_aua_allctn]
    sorts: [dashboard.total_aua_allctn desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_aua_allctn}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_aua_allctn} / if(sum(${dashboard.total_aua_allctn}) = 0, null,sum(${dashboard.total_aua_allctn}) )) * 100, 0)"
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
    column_order: [dashboard.allocation_name_locale, dashboard.total_aua_allctn, percent_of_total_1,
      visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.allocation_name_locale: asset_type
      dashboard.total_aua_allctn: total_market_value_cad
      visualization: visualization
    series_column_widths:
      dashboard.allocation_name_locale: 306.1500000000001
      dashboard.total_aua_allctn: 172
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_aua_allctn:
        is_active: false
      visualization:
        is_active: true
        palette:
          palette_id: effdb482-a1f8-e16a-7061-767cca252c37
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
        value_display: false
    series_text_format:
      dashboard.allocation_name_locale:
        bg_color: "#EDEFF8"
      dashboard.total_aua_allctn:
        underline: true
        fg_color: "#003DA5"
      percent_of_total_1:
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.total_aua_allctn,
            id: dashboard.total_aua_allctn, name: Total AUA}], showLabels: true, showValues: true,
        valueFormat: '$#,##0,,"M"', unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
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
    x_axis_zoom: true
    y_axis_zoom: true
    trellis: ''
    stacking: ''
    legend_position: center
    label_value_format: $#,##0,,"M"
    point_style: none
    series_colors:
      Fixed Income Securities and Fixed Income Funds: "#00A873"
      Cash and Cash Equivalent: "#C78500"
      Alternatives and Other Assets: "#8A3EB0"
      Debit Balance and Owed Investments: "#D13599"
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    defaults_version: 1
    hidden_fields: []
    note_state: collapsed
    note_display: hover
    note_text: asset_allocation_note
    hidden_pivots: {}
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 11
    col: 0
    width: 12
    height: 5
  - title: asset_change_ytd
    name: asset_change_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [total_aua_last_12_months_asset_change_pdt.aua_change_ytd, total_aua_last_12_months_asset_change_pdt.market_variation]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: [total_aua_last_12_months_asset_change_pdt.market_variation]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: "#3A4245"
    show_title_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: false
    title_placement_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: above
    value_format_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: ''
    style_dashboard.aua_change_ytd_bob: "#3A4245"
    show_title_dashboard.aua_change_ytd_bob: false
    title_placement_dashboard.aua_change_ytd_bob: above
    value_format_dashboard.aua_change_ytd_bob: ''
    show_title_dashboard.aua_change_ytd: false
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: asset_change_ytd_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 0
    width: 4
    height: 3
  - title: asset_trend
    name: asset_trend
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_area
    fields: [dashboard.total_aua_last_12_month_master_list, last_12_months_master_list.last_12_month_with_mtd_wo_13th_month]
    sorts: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month]
    limit: 5000
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(is_null(${last_12_months_master_list.last_12_month_with_mtd_wo_13th_month}),
        no, yes )
      label: Hide
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: hide
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
    x_axis_reversed: false
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.total_aua_last_12_month_master_list,
            id: dashboard.total_aua_last_12_month_master_list, name: Total Market
              Value (CAD$)}], showLabels: true, showValues: true, unpinAxis: true,
        tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: ____________________________
    x_axis_zoom: true
    y_axis_zoom: false
    series_labels:
      dashboard.total_aua_last_12_month_master_list: Total Market Value (CAD$)
    x_axis_label_rotation: 0
    ordering: none
    show_null_labels: false
    defaults_version: 1
    hidden_pivots: {}
    hidden_points_if_no: [hide]
    note_state: collapsed
    note_display: hover
    note_text: asset_trend_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 6
    col: 5
    width: 19
    height: 5
  - title: existing_clients_ytd
    name: existing_clients_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [fact_transctn_rr.existing_clients_cashflow_ytd_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: ''
    style_dashboard.existing_client_cashflow_bob: "#3A4245"
    show_title_dashboard.existing_client_cashflow_bob: false
    title_placement_dashboard.existing_client_cashflow_bob: above
    value_format_dashboard.existing_client_cashflow_bob: ''
    style_dashboard.existing_client_cashflow: "#3A4245"
    show_title_dashboard.existing_client_cashflow: false
    title_placement_dashboard.existing_client_cashflow: above
    value_format_dashboard.existing_client_cashflow: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: existing_clients_ytd_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 8
    width: 4
    height: 3
  - title: new_clients_ytd
    name: new_clients_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [fact_transctn_rr.new_clients_cashflow_ytd_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: ''
    style_dashboard.new_clients_cashflow_bob: "#3A4245"
    show_title_dashboard.new_clients_cashflow_bob: false
    title_placement_dashboard.new_clients_cashflow_bob: above
    value_format_dashboard.new_clients_cashflow_bob: ''
    style_dashboard.new_clients_cashflow: "#3A4245"
    show_title_dashboard.new_clients_cashflow: false
    title_placement_dashboard.new_clients_cashflow: above
    value_format_dashboard.new_clients_cashflow: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: new_clients_ytd_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 12
    width: 4
    height: 3
  - title: lost_clients_ytd
    name: lost_clients_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [fact_transctn_rr.lost_clients_cashflow_ytd_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: ''
    style_dashboard.lost_clients_cashflow_bob: "#3A4245"
    show_title_dashboard.lost_clients_cashflow_bob: false
    title_placement_dashboard.lost_clients_cashflow_bob: above
    value_format_dashboard.lost_clients_cashflow_bob: ''
    style_dashboard.lost_clients_cashflow: "#3A4245"
    show_title_dashboard.lost_clients_cashflow: false
    title_placement_dashboard.lost_clients_cashflow: above
    value_format_dashboard.lost_clients_cashflow: ''
    style_dashboard.total_lost_clients_cashflow_drill: "#3A4245"
    show_title_dashboard.total_lost_clients_cashflow_drill: true
    title_placement_dashboard.total_lost_clients_cashflow_drill: above
    value_format_dashboard.total_lost_clients_cashflow_drill: ''
    show_comparison_dashboard.total_lost_clients_cashflow_drill: false
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: lost_clients_ytd_note
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 16
    width: 4
    height: 3
  - title: total_assets_scorecard
    name: total_assets_scorecard
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_aua_multi_value]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: total_assets_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 6
    col: 0
    width: 5
    height: 5
  - title: market_variation_ytd
    name: market_variation_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [total_aua_last_12_months_asset_change_pdt.market_variation]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_total_aua_last_12_months_asset_change_pdt.market_variation: "#3A4245"
    show_title_total_aua_last_12_months_asset_change_pdt.market_variation: false
    title_placement_total_aua_last_12_months_asset_change_pdt.market_variation: above
    value_format_total_aua_last_12_months_asset_change_pdt.market_variation: ''
    style_fact_transctn_rr.total_ytd: "#3A4245"
    show_title_fact_transctn_rr.total_ytd: false
    title_placement_fact_transctn_rr.total_ytd: above
    value_format_fact_transctn_rr.total_ytd: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: market_variation_ytd_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 20
    width: 4
    height: 3
  - title: asset_change_ytd_title
    name: asset_change_ytd_title
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: single_value
    fields: [dashboard.bob_ytd_net_change_title]
    sorts: [dashboard.bob_ytd_net_change_title]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 1
  - title: asset_change_ytd_formula
    name: asset_change_ytd_formula
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: single_value
    fields: [dashboard.bob_ytd_net_change_formula]
    sorts: [dashboard.bob_ytd_net_change_formula]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    listen: {}
    row: 4
    col: 0
    width: 24
    height: 2
  - title: asset_change_by_month
    name: asset_change_by_month
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: looker_line
    fields: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month, asset_change_ndt_tran.total_aua_last_12_month_including_current,
      asset_change_ndt_tran.total_aua_pre_month, asset_change_ndt_tran.total_aua_change,
      asset_change_ndt_tran.year, asset_change_ndt_tran.asset_change_mtd_wo_13th_month]
    filters:
      asset_change_ndt_tran.last_12_months_month: NOT NULL
    sorts: [last_12_months_master_list.last_12_month_with_mtd_wo_13th_month desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(is_null(${last_12_months_master_list.last_12_month_with_mtd_wo_13th_month}),no,yes)
      label: hide
      value_format:
      value_format_name: ''
      _kind_hint: dimension
      table_calculation: hide
      _type_hint: yesno
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    interpolation: monotone
    y_axes: [{label: '', orientation: left, series: [{axisId: asset_change_ndt_tran.total_aua_change,
            id: asset_change_ndt_tran.total_aua_change, name: asset_change_cad}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: false
    label_value_format: ''
    swap_axes: false
    advanced_vis_config: |-
      {
        tooltip: {
          backgroundColor: "#FFF",
          borderRadius: 4,
          borderWidth: 1,
          borderColor: "#EDEFFA",
          borderStyle: 'solid',
          shadow: true,
          style: {
            color: "black"
          },
          shadow: {
            color: 'rgba(0, 0, 0, 0.25)',
            offsetX: 4,
            offsetY: 4
          }
        }
      }
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [asset_change_ndt_tran.total_aua_last_12_month_including_current,
      asset_change_ndt_tran.total_aua_pre_month, asset_change_ndt_tran.balance_dt_month,
      asset_change_ndt_tran.year, asset_change_ndt_tran.asset_change_mtd_wo_13th_month]
    hidden_pivots: {}
    hidden_points_if_no: [hide]
    note_state: collapsed
    note_display: hover
    note_text: asset_change_by_month_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 23
    col: 0
    width: 24
    height: 8
  - title: 12_month_net_change_title
    name: 12_month_net_change_title
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: single_value
    fields: [dashboard.bob_12_month_net_change_title]
    sorts: [dashboard.bob_12_month_net_change_title]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    custom_color_enabled: true
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    defaults_version: 1
    listen: {}
    row: 39
    col: 0
    width: 24
    height: 1
  - title: new_client_cash_flow
    name: new_client_cash_flow
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.new_clients_cashflow_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_dashboard.new_clients_cashflow_scorecard: "#3A4245"
    show_title_dashboard.new_clients_cashflow_scorecard: false
    title_placement_dashboard.new_clients_cashflow_scorecard: above
    value_format_dashboard.new_clients_cashflow_scorecard: ''
    style_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.new_clients_cashflow_ytd_scorecard: ''
    style_dashboard.new_clients_cashflow_bob: "#3A4245"
    show_title_dashboard.new_clients_cashflow_bob: false
    title_placement_dashboard.new_clients_cashflow_bob: above
    value_format_dashboard.new_clients_cashflow_bob: ''
    style_dashboard.new_clients_cashflow: "#3A4245"
    show_title_dashboard.new_clients_cashflow: false
    title_placement_dashboard.new_clients_cashflow: above
    value_format_dashboard.new_clients_cashflow: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: new_client_cash_flow_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 12
    width: 4
    height: 3
  - title: existing_client_cash_flow
    name: existing_client_cash_flow
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.existing_client_cashflow_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    show_title_dashboard.existing_client_cashflow_scorecard: false
    style_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: ''
    style_dashboard.existing_client_cashflow: "#3A4245"
    show_title_dashboard.existing_client_cashflow: false
    title_placement_dashboard.existing_client_cashflow: above
    value_format_dashboard.existing_client_cashflow: ''
    style_dashboard.existing_client_cashflow_bob: "#3A4245"
    show_title_dashboard.existing_client_cashflow_bob: false
    title_placement_dashboard.existing_client_cashflow_bob: above
    value_format_dashboard.existing_client_cashflow_bob: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: existing_client_cash_flow_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 8
    width: 4
    height: 3
  - title: asset_change_12_months_cad
    name: asset_change_12_months_cad
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [asset_change_ndt_tran.sum_aua_change_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_asset_change_ndt_tran.sum_aua_change_scorecard: "#3A4245"
    show_title_asset_change_ndt_tran.sum_aua_change_scorecard: false
    title_placement_asset_change_ndt_tran.sum_aua_change_scorecard: above
    value_format_asset_change_ndt_tran.sum_aua_change_scorecard: ''
    style_asset_change_ndt.sum_aua_change: "#3A4245"
    show_title_asset_change_ndt.sum_aua_change: false
    title_placement_asset_change_ndt.sum_aua_change: above
    value_format_asset_change_ndt.sum_aua_change: ''
    style_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: "#3A4245"
    show_title_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: false
    title_placement_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: above
    value_format_total_aua_last_12_months_asset_change_pdt.aua_change_ytd: ''
    style_dashboard.aua_change_ytd_bob: "#3A4245"
    show_title_dashboard.aua_change_ytd_bob: false
    title_placement_dashboard.aua_change_ytd_bob: above
    value_format_dashboard.aua_change_ytd_bob: ''
    show_title_dashboard.aua_change_ytd: false
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: asset_change_12_months_cad_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 0
    width: 4
    height: 3
  - title: lost_client_cash_flow
    name: lost_client_cash_flow
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.lost_clients_cashflow_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_dashboard.lost_clients_cashflow_scorecard: "#3A4245"
    show_title_dashboard.lost_clients_cashflow_scorecard: false
    title_placement_dashboard.lost_clients_cashflow_scorecard: above
    value_format_dashboard.lost_clients_cashflow_scorecard: ''
    style_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.lost_clients_cashflow_ytd_scorecard: ''
    style_dashboard.lost_clients_cashflow_bob: "#3A4245"
    show_title_dashboard.lost_clients_cashflow_bob: false
    title_placement_dashboard.lost_clients_cashflow_bob: above
    value_format_dashboard.lost_clients_cashflow_bob: ''
    style_dashboard.lost_clients_cashflow: "#3A4245"
    show_title_dashboard.lost_clients_cashflow: false
    title_placement_dashboard.lost_clients_cashflow: above
    value_format_dashboard.lost_clients_cashflow: ''
    style_dashboard.total_lost_clients_cashflow_drill: "#3A4245"
    show_title_dashboard.total_lost_clients_cashflow_drill: true
    title_placement_dashboard.total_lost_clients_cashflow_drill: above
    value_format_dashboard.total_lost_clients_cashflow_drill: ''
    show_comparison_dashboard.total_lost_clients_cashflow_drill: false
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: lost_client_cash_flow_note
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 16
    width: 4
    height: 3
  - title: net_client_growth_ytd
    name: net_client_growth_ytd
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [fact_transctn_rr.net_client_growth_ytd_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    show_title_fact_transctn_rr.net_client_growth_ytd_scorecard: false
    style_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: ''
    style_dashboard.existing_client_cashflow_bob: "#3A4245"
    show_title_dashboard.existing_client_cashflow_bob: false
    title_placement_dashboard.existing_client_cashflow_bob: above
    value_format_dashboard.existing_client_cashflow_bob: ''
    style_dashboard.existing_client_cashflow: "#3A4245"
    show_title_dashboard.existing_client_cashflow: false
    title_placement_dashboard.existing_client_cashflow: above
    value_format_dashboard.existing_client_cashflow: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: net_client_growth_ytd_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 1
    col: 4
    width: 4
    height: 3
  - title: net_client_growth
    name: net_client_growth
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.net_client_growth_scorecard]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_dashboard.net_client_growth_scorecard: "#3A4245"
    show_title_dashboard.net_client_growth_scorecard: false
    title_placement_dashboard.net_client_growth_scorecard: above
    value_format_dashboard.net_client_growth_scorecard: ''
    style_dashboard.net_client_growth: "#3A4245"
    show_title_dashboard.net_client_growth: false
    title_placement_dashboard.net_client_growth: above
    value_format_dashboard.net_client_growth: ''
    show_title_fact_transctn_rr.net_client_growth_ytd_scorecard: false
    style_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: "#3A4245"
    show_title_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: false
    title_placement_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: above
    value_format_fact_transctn_rr.existing_clients_cashflow_ytd_scorecard: ''
    style_dashboard.existing_client_cashflow_bob: "#3A4245"
    show_title_dashboard.existing_client_cashflow_bob: false
    title_placement_dashboard.existing_client_cashflow_bob: above
    value_format_dashboard.existing_client_cashflow_bob: ''
    style_dashboard.existing_client_cashflow: "#3A4245"
    show_title_dashboard.existing_client_cashflow: false
    title_placement_dashboard.existing_client_cashflow: above
    value_format_dashboard.existing_client_cashflow: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: net_client_growth_cad_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 4
    width: 4
    height: 3
  - title: market_variation_scorecard_cad
    name: market_variation_scorecard_cad
    model: ax360_portal
    explore: ax360_dashboards_historical
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [asset_change_ndt_tran.market_variation]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: '""'
      label: test
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: '""'
      label: test 2
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: test_2
      _type_hint: string
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_asset_change_ndt_tran.market_variation: "#3A4245"
    show_title_asset_change_ndt_tran.market_variation: false
    title_placement_asset_change_ndt_tran.market_variation: above
    value_format_asset_change_ndt_tran.market_variation: ''
    style_dashboard.market_variation: "#3A4245"
    show_title_dashboard.market_variation: false
    title_placement_dashboard.market_variation: above
    value_format_dashboard.market_variation: ''
    style_total_aua_last_12_months_asset_change_pdt.market_variation: "#3A4245"
    show_title_total_aua_last_12_months_asset_change_pdt.market_variation: false
    title_placement_total_aua_last_12_months_asset_change_pdt.market_variation: above
    value_format_total_aua_last_12_months_asset_change_pdt.market_variation: ''
    style_fact_transctn_rr.total_ytd: "#3A4245"
    show_title_fact_transctn_rr.total_ytd: false
    title_placement_fact_transctn_rr.total_ytd: above
    value_format_fact_transctn_rr.total_ytd: ''
    style_dashboard.total_ytd: "#3A4245"
    show_title_dashboard.total_ytd: false
    title_placement_dashboard.total_ytd: above
    value_format_dashboard.total_ytd: ''
    style_dashboard.total_aua_multi_value: "#3A4245"
    show_title_dashboard.total_aua_multi_value: false
    title_placement_dashboard.total_aua_multi_value: above
    value_format_dashboard.total_aua_multi_value: ''
    style_test: "#3A4245"
    show_title_test: false
    title_placement_test: above
    value_format_test: ''
    show_comparison_test: false
    style_test_2: "#3A4245"
    show_title_test_2: false
    title_placement_test_2: above
    value_format_test_2: ''
    show_comparison_test_2: false
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: market_variation_scorecard_cad_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Account Type: dim_accnt.accnt_tp_value
      Program Type: dim_accnt.accnt_progrm_tp_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
    row: 40
    col: 20
    width: 4
    height: 3
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
    explore: ax360_dashboards_historical
    listens_to_filters: [Account Type, Program Type, RVP Name, Branch Name, Team Name]
    field: dashboard.rep_cd_with_rep_cd_name
  - name: Account Type
    title: Account Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: ax360_dashboards_historical
    listens_to_filters: [IA Code, Program Type, RVP Name, Branch Name, Team Name]
    field: dim_accnt.accnt_tp_value
  - name: Program Type
    title: Program Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: ax360_dashboards_historical
    listens_to_filters: [IA Code, Account Type, RVP Name, Branch Name, Team Name]
    field: dim_accnt.accnt_progrm_tp_name
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
    explore: ax360_dashboards_historical
    listens_to_filters: [IA Code, Account Type, Program Type, Branch Name, Team Name]
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
    explore: ax360_dashboards_historical
    listens_to_filters: [IA Code, Account Type, Program Type, RVP Name, Team Name]
    field: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
  - name: Team Name
    title: Team Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: ax360_dashboards_historical
    listens_to_filters: [IA Code, Account Type, Program Type, RVP Name, Branch Name]
    field: filtered_rep_cd_by_rvp_branch_team.team_name