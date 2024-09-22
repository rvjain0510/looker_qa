---
- dashboard: clients
  title: Clients
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: u58agwfdQyQYIzbDyu4LXY
  elements:
  - title: total_clients_by_account_type
    name: total_clients_by_account_type
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.accnt_tp__name_merged, dashboard.total_active_clients_drill_accnt_tp]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    sorts: [dashboard.total_active_clients_drill_accnt_tp desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_active_clients_drill_accnt_tp}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_active_clients_drill_accnt_tp} / if(sum(${dashboard.total_active_clients_drill_accnt_tp}) = 0, null,sum(${dashboard.total_active_clients_drill_accnt_tp}) )) * 100, 0)"
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
    column_order: [dashboard.accnt_tp__name_merged, dashboard.total_active_clients_drill_accnt_tp,
      percent_of_total_1, visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.accnt_tp__name_merged: account_type_q
      dashboard.total_active_clients_drill_accnt_tp: total_clients
      visualization: visualization
    series_column_widths:
      dashboard.accnt_tp__name_merged: 130
      dashboard.total_active_clients_drill_accnt_tp: 130
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_active_clients_drill_accnt_tp:
        is_active: false
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 2a76e3c6-c18c-53f1-f1b6-ac34ac207f38
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
    series_text_format:
      dashboard.total_active_clients_drill_accnt_tp:
        fg_color: "#003DA5"
        underline: true
      dashboard.accnt_tp__name_merged:
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
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.total_active_clients_drill_accnt_tp,
            id: dashboard.total_active_clients_drill_accnt_tp, name: Total Clients}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000]#0,,"M";[>=1000]#0,"K";0',
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_label: Plan Type
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000]#0,,"M";[>=1000]#0,"K";0'
    series_colors:
      dashboard.total_active_accounts: "#003DA5"
      dashboard.total_active_accounts_drill: "#003DA5"
      dashboard.total_active_accounts_drill_accnt_tp: "#003DA5"
      dashboard.total_active_clients_drill_accnt_tp: "#003DA5"
      RESP: "#00A873"
      Margin: "#C78500"
      RDSP: "#8A3EB0"
      RRSP: "#D13599"
      TFSA: "#668FFF"
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    hidden_pivots: {}
    defaults_version: 1
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    note_state: collapsed
    note_display: hover
    note_text: total_clients_by_account_type_note
    hidden_fields: []
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 38
    col: 0
    width: 12
    height: 9
  - title: total_clients_by_program_type
    name: total_clients_by_program_type
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.total_active_clients_drill_prgrm_tp, dashboard.accnt_progrm_tp__value]
    filters:
      dashboard.account_status_level_1: "{{ _localization['Open'] }}"
    sorts: [dashboard.total_active_clients_drill_prgrm_tp desc]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_active_clients_drill_prgrm_tp}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "coalesce((${dashboard.total_active_clients_drill_prgrm_tp} / if(sum(${dashboard.total_active_clients_drill_prgrm_tp}) = 0, null,sum(${dashboard.total_active_clients_drill_prgrm_tp}) )) * 100, 0)"
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
    column_order: [dashboard.accnt_progrm_tp__value, dashboard.total_active_clients_drill_prgrm_tp,
       percent_of_total_1, visualization]
    show_totals: false
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      dashboard.total_active_clients_drill_prgrm_tp: total_clients
      dashboard.accnt_progrm_tp__value: program_type
      visualization: visualization
    series_column_widths:
      dashboard.accnt_progrm_tp__value: 171.005
      dashboard.total_active_clients_drill_prgrm_tp: 142
      percent_of_total_1: 130
    series_cell_visualizations:
      dashboard.total_active_clients_drill_prgrm_tp:
        is_active: false
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 923170d9-5150-9c1b-d62b-ac2a01f7390d
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
    series_text_format:
      dashboard.total_active_clients_drill_prgrm_tp:
        underline: true
        fg_color: "#003DA5"
      dashboard.accnt_progrm_tp__value:
        bg_color: "#EDEFF8"
      percent_of_total_1:
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    series_colors:
      dashboard.total_active_accounts_drill_prgrm_tp: "#003Da5"
      dashboard.total_active_clients_drill_prgrm_tp: "#003DA5"
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
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Total Clients, orientation: bottom, series: [{axisId: dashboard.total_active_clients_drill_prgrm_tp,
            id: dashboard.total_active_clients_drill_prgrm_tp, name: Total Clients}],
        showLabels: true, showValues: true, valueFormat: '[>=1000000]#0,,"M";[>=1000]#0,"K";0',
        unpinAxis: false, tickDensity: custom, tickDensityCustom: 7, type: linear}]
    x_axis_label: Program Type
    x_axis_zoom: true
    y_axis_zoom: true
    label_value_format: '[>=1000000]#0,,"M";[>=1000]#0,"K";0'
    hidden_pivots: {}
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: total_clients_by_program_type_note
    hidden_fields: []
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 38
    col: 12
    width: 12
    height: 9
  - title: client_segmentation_by_income
    name: client_segmentation_by_income
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.income_tier, dashboard.total_clients_pct_drill_for_segments,
      dashboard.total_aua_pct_for_segments, dashboard.total_aua_current_month_sample,
      dim_party.total_clients]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |+
        if(is_null(
        ${dashboard.total_aua_current_month_sample}/${dim_party.total_clients}),0,
        ${dashboard.total_aua_current_month_sample}/${dim_party.total_clients})



      label: Avg AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua
      _type_hint: number
    - category: table_calculation
      expression: if(${dashboard.income_tier}="Undefined","Not Applicable",${dashboard.income_tier})
      label: Income
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: income
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: "${dashboard.total_clients_pct_drill_for_segments}"
      label: "   %"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: calculation
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.total_aua_pct_for_segments}"
      label: Total AUA% (Cell Viz)
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: total_aua_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: "${avg_aua}"
      label: Avg AUA (Cell Viz)
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: |-
        if( ${dashboard.income_tier} ="Below $25,000" OR ${dashboard.income_tier} ="Moins de 25 000 $" , 1,
        if(${dashboard.income_tier} ="$25,000 to $49,999"  OR ${dashboard.income_tier} ="25 000 $ à 49 999 $", 2,
            if(${dashboard.income_tier} ="$50,000 to $99,999"  OR ${dashboard.income_tier} ="50 000 $ à 99 999 $", 3,
            if(${dashboard.income_tier} ="$100,000 to $249,999"  OR ${dashboard.income_tier} ="100 000 $ à 249 999 $",4,
              if(${dashboard.income_tier} ="$250,000 to $499,999"  OR ${dashboard.income_tier} ="250 000 $ à 499 999 $", 5,if(${dashboard.income_tier} ="$500,000 to $999,999"  OR ${dashboard.income_tier} ="500 000 $ à 999 999 $", 6,
                    if(${dashboard.income_tier} ="$1,000,000 or Above"  OR ${dashboard.income_tier} ="Plus de 1 000 000 $", 7,
                    if(${dashboard.income_tier} ="Not Available"  OR ${dashboard.income_tier} ="Non Disponible" , 8, 9))))))))
      label: sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
      _type_hint: number
    - category: table_calculation
      expression: if(${dashboard.total_aua_current_month_sample}=0 AND ${dim_party.total_clients}=0,no,yes
        )
      label: show 0 or not?
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: show_0_or_not
      _type_hint: yesno
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.income_tier, dashboard.total_clients_pct_drill_for_segments,
      calculation, dashboard.total_aua_pct_for_segments, total_aua_cell_viz, avg_aua,
      avg_aua_cell_viz]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      avg_aua: average_assets_cad
      dashboard.total_clients_pct_drill_for_segments: total_clients
      total_aua_cell_viz: visualization
      avg_aua_cell_viz: visualization
      dashboard.income_tier: income_segment
      dashboard.total_aua_pct_for_segments: total_assets_pct
      calculation: visualization
    series_cell_visualizations:
      avg_aua:
        is_active: false
        palette:
          palette_id: 9637a1d8-4f92-1480-a296-d2f6f3487e3c
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      dashboard.total_aua_pct_for_segments:
        is_active: false
        palette:
          palette_id: 6a97c368-d0d4-8bc2-a805-f824ca451365
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      dashboard.total_clients_pct_drill_for_segments:
        is_active: false
        palette:
          palette_id: 04450752-631e-23f2-89aa-09dd2df9cd8e
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      calculation:
        is_active: true
        palette:
          palette_id: 5c261bfb-6233-66a2-7981-088fa1b19974
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
        value_display: false
      total_aua_cell_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: 3409ad46-0e74-6991-b6db-5b19c2f3c2f4
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      avg_aua_cell_viz:
        is_active: true
        palette:
          palette_id: 7c32de8c-6d7d-c9f9-be14-6b5e3074cbc6
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
        value_display: false
    series_text_format:
      avg_aua:
        align: right
      dashboard.income_tier:
        bg_color: "#EDEFF8"
      dashboard.total_clients_pct_drill_for_segments: {}
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: [avg_aua, dashboard.total_aua_pct_for_segments,
          dashboard.total_clients_pct_drill_for_segments]}]
    hidden_pivots: {}
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
    hidden_fields: [dashboard.total_active_clients, dashboard.total_aua_current_month_sample,
      dim_party.total_clients, sort]
    hidden_points_if_no: [show_0_or_not]
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_income_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 4
    col: 0
    width: 24
    height: 5
  - title: client_segmentation_by_asset
    name: client_segmentation_by_asset
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [total_aua_party_ndt.aua_tier, total_aua_party_ndt.aua_segments_clients_pct,
      total_aua_party_ndt.aua_segments_aua_pct, total_aua_party_ndt.avg_aua, dim_party.total_clients]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(${total_aua_party_ndt.aua_tier}="Undefined",no,yes)
      label: Show in viz?
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_in_viz
      _type_hint: yesno
      is_disabled: true
    - category: table_calculation
      expression: "${total_aua_party_ndt.aua_segments_clients_pct}"
      label: Client% Cell Viz
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: client_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: "${total_aua_party_ndt.aua_segments_aua_pct}"
      label: AUA% cell viz
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: aua_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: "${total_aua_party_ndt.avg_aua}"
      label: Average cell Viz
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${total_aua_party_ndt.aua_tier} ="Below $50,000" OR ${total_aua_party_ndt.aua_tier} ="Moins de 50 000 $",1,
          if(${total_aua_party_ndt.aua_tier} ="$50,000 to $99,999"  OR ${total_aua_party_ndt.aua_tier} ="50 000 $ à 99 999 $",2,
            if(${total_aua_party_ndt.aua_tier} ="$100,000 to $249,999"  OR ${total_aua_party_ndt.aua_tier} ="100 000 $ à 249 999 $", 3,
              if(${total_aua_party_ndt.aua_tier} ="$250,000 to $499,999"  OR ${total_aua_party_ndt.aua_tier} ="250 000 $ à 499 999 $", 4,
                if(${total_aua_party_ndt.aua_tier} ="$500,000 to $999,999"  OR ${total_aua_party_ndt.aua_tier} ="500 000 $ à 999 999 $", 5,
                    if(${total_aua_party_ndt.aua_tier} ="$1,000,000 to $1,999,999"  OR ${total_aua_party_ndt.aua_tier} ="1 000 000 $ à 1 999 999 $", 6,
                    if(${total_aua_party_ndt.aua_tier} ="$2,000,000 or Above" OR ${total_aua_party_ndt.aua_tier} ="2 000 000 $ et plus",7,
                    if(${total_aua_party_ndt.aua_tier} ="Not Available" OR ${total_aua_party_ndt.aua_tier} ="Non Disponible" , 8, 9))))))))
      label: sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
      _type_hint: number
    - category: table_calculation
      expression: if(is_null(${total_aua_party_ndt.avg_aua}) AND ${dim_party.total_clients}=0,
        no, yes)
      label: hide Null values?
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: hide_null_values
      _type_hint: yesno
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [total_aua_party_ndt.aua_tier, total_aua_party_ndt.aua_segments_clients_pct,
      client_cell_viz, total_aua_party_ndt.aua_segments_aua_pct, aua_cell_viz, total_aua_party_ndt.avg_aua,
      average_cell_viz]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      total_aua_party_ndt.aua_tier: asset_segment
      total_aua_party_ndt.aua_segments_clients_pct: total_clients
      total_aua_party_ndt.aua_segments_aua_pct: total_assets_pct
      total_aua_party_ndt.avg_aua: average_assets_cad
      client_cell_viz: visualization
      aua_cell_viz: visualization
      average_cell_viz: visualization
    series_cell_visualizations:
      total_aua_party_ndt.avg_aua:
        is_active: false
        palette:
          palette_id: da22852f-c26d-fd0d-f323-97d62d973c39
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      total_aua_party_ndt.aua_segments_clients_pct:
        is_active: false
        palette:
          palette_id: c8d62cf0-1b15-d933-721c-bd43f4a8cb3b
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      total_aua_party_ndt.aua_segments_aua_pct:
        is_active: false
        palette:
          palette_id: 506b98da-1eb1-7808-1243-12b90b188e0f
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      client_cell_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: b87a147a-fb5e-ebe7-1d0d-d0bcb7315aa2
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      aua_cell_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: e382bf16-9586-63ae-3c56-9c94329ed136
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      average_cell_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: c881bf2d-3f4f-b42d-f795-1e00944350b9
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    series_text_format:
      total_aua_party_ndt.aua_tier:
        bg_color: "#EDEFF8"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: [total_aua_party_ndt.aua_segments_clients_pct,
          total_aua_party_ndt.avg_aua, total_aua_party_ndt.aua_segments_aua_pct]}]
    truncate_column_names: false
    defaults_version: 1
    hidden_fields: [dim_party.total_clients, sort]
    hidden_pivots: {}
    hidden_points_if_no: [hidden, hide_null_values]
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_asset_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 16
    col: 0
    width: 24
    height: 5
  - title: client_segmentation_by_age
    name: client_segmentation_by_age
    model: ax360_portal
    explore: ax360_dashboards
    type: looker_grid
    fields: [dashboard.total_clients_pct_drill_for_segments, dashboard.total_aua_pct_for_segments,
      dashboard.total_aua_current_month_sample, dim_party.total_clients, dashboard.age_tier]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |+
        if(is_null(
        ${dashboard.total_aua_current_month_sample}/${dim_party.total_clients}),0,
        ${dashboard.total_aua_current_month_sample}/${dim_party.total_clients})



      label: Avg AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua
      _type_hint: number
    - category: table_calculation
      expression: if(${dashboard.age_tier}="Undefined","Not Applicable",${dashboard.age_tier})
      label: Age
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: age
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: "${dashboard.total_clients_pct_drill_for_segments}"
      label: "   %"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: calculation
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.total_aua_pct_for_segments}"
      label: Total AUA% (Cell Viz)
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: total_aua_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: "${avg_aua}"
      label: Avg AUA (Cell Viz)
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua_cell_viz
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${dashboard.age_tier} ="Below 18" OR ${dashboard.age_tier} ="Moins de 18" , 1,if(
           ${dashboard.age_tier} ="18 to 29" OR ${dashboard.age_tier} ="18 à 29", 2,if(
           ${dashboard.age_tier} ="30 to 39" OR ${dashboard.age_tier} ="30 à 39", 3, if(
           ${dashboard.age_tier} ="40 to 49" OR ${dashboard.age_tier} ="40 à 49", 4, if(
           ${dashboard.age_tier} ="50 to 59"OR ${dashboard.age_tier} ="50 à 59", 5, if(
           ${dashboard.age_tier} ="60 to 64" OR ${dashboard.age_tier} ="60 à 64" , 6, if(
           ${dashboard.age_tier} ="65 to 69" OR ${dashboard.age_tier} ="65 à 69" , 7, if(
           ${dashboard.age_tier} ="70 or Above" OR ${dashboard.age_tier} ="70 et plus", 8,if(
           ${dashboard.age_tier} ="Not Available" OR ${dashboard.age_tier} ="Non Disponible" , 9,
           10)))))))))
      label: Sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
      _type_hint: number
    - category: table_calculation
      expression: if(${dashboard.total_aua_current_month_sample}=0 AND ${dim_party.total_clients}=0,no,yes
        )
      label: Hide 0 or not?
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: hide_0_or_not
      _type_hint: yesno
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.age_tier, dashboard.total_clients_pct_drill_for_segments,
      calculation, dashboard.total_aua_pct_for_segments, total_aua_cell_viz, avg_aua,
      avg_aua_cell_viz]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      avg_aua: average_assets_cad
      dashboard.total_aua_pct_for_segments: total_assets_pct
      dashboard.total_clients_pct_drill_for_segments: total_clients
      total_aua_cell_viz: visualization
      avg_aua_cell_viz: visualization
      dashboard.age_tier: age_segment
      calculation: visualization
    series_cell_visualizations:
      avg_aua:
        is_active: false
        palette:
          palette_id: 9637a1d8-4f92-1480-a296-d2f6f3487e3c
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      dashboard.total_aua_pct_for_segments:
        is_active: false
        palette:
          palette_id: 6a97c368-d0d4-8bc2-a805-f824ca451365
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      dashboard.total_clients_pct_drill_for_segments:
        is_active: false
        palette:
          palette_id: 04450752-631e-23f2-89aa-09dd2df9cd8e
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      calculation:
        is_active: true
        palette:
          palette_id: 5c261bfb-6233-66a2-7981-088fa1b19974
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
        value_display: false
      total_aua_cell_viz:
        is_active: true
        value_display: false
        palette:
          palette_id: 92db29a0-2d6c-561c-9a32-a24b3b781b18
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      avg_aua_cell_viz:
        is_active: true
        palette:
          palette_id: 3dac00ea-37c8-cc1d-9e9a-2f299fe18c6d
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
        value_display: false
    series_text_format:
      avg_aua:
        align: right
      dashboard.total_clients_pct_drill_for_segments: {}
      dashboard.age_tier:
        bg_color: "#EDEFF8"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: [dashboard.total_clients_pct_drill_for_segments,
          dashboard.total_aua_pct_for_segments, avg_aua]}]
    hidden_pivots: {}
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
    hidden_fields: [dashboard.total_active_clients, dashboard.total_aua_current_month_sample,
      dim_party.total_clients, sort]
    hidden_points_if_no: [hide_0_or_not]
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_age_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 9
    col: 0
    width: 24
    height: 7
  - title: household_segmentation_by_age
    name: household_segmentation_by_age
    model: ax360_portal
    explore: ax360_dashboards_hh
    type: looker_grid
    fields: [households_age_income_segments.age_tier, households_age_income_segments.total_households_count,
      households_aua_segments.households_aua, households_age_income_segments.households_pct_drill,
      households_aua_segments.aua_pct_drill]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count}),0,
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${households_aua_segments.aua_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization_1
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization_2
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${households_age_income_segments.age_tier} ="Below 18" OR ${households_age_income_segments.age_tier} ="Moins de 18" , 1,if(
          ${households_age_income_segments.age_tier} ="18 to 29" OR ${households_age_income_segments.age_tier} ="18 à 29", 2,if(
          ${households_age_income_segments.age_tier} ="30 to 39" OR ${households_age_income_segments.age_tier} ="30 à 39", 3, if(
          ${households_age_income_segments.age_tier} ="40 to 49" OR ${households_age_income_segments.age_tier} ="40 à 49", 4, if(
          ${households_age_income_segments.age_tier} ="50 to 59"OR ${households_age_income_segments.age_tier} ="50 à 59", 5, if(
          ${households_age_income_segments.age_tier} ="60 to 64" OR ${households_age_income_segments.age_tier} ="60 à 64" , 6, if(
          ${households_age_income_segments.age_tier} ="65 to 69" OR ${households_age_income_segments.age_tier} ="65 à 69" , 7, if(
          ${households_age_income_segments.age_tier} ="70 or Above" OR ${households_age_income_segments.age_tier} ="70 et plus", 8,if(
          ${households_age_income_segments.age_tier} ="Not Available" OR ${households_age_income_segments.age_tier} ="Non Disponible" , 9,
          10)))))))))
      label: sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [households_age_income_segments.age_tier, households_age_income_segments.households_pct_drill,
      visualization, households_aua_segments.aua_pct_drill, visualization_1, average_aua,
      visualization_2]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_age_income_segments.age_tier: age_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets_pct
      visualization: visualization
      average_aua: average_assets_cad
      visualization_1: visualization
      visualization_2: visualization
    series_cell_visualizations:
      households_age_income_segments.households_pct_drill:
        is_active: false
      households_aua_segments.aua_pct_drill:
        is_active: false
        value_display: false
        palette:
          palette_id: 480c114d-678e-e450-36d4-be323ee0f2df
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#1A73E8"
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 82154fab-e553-fbc8-b79f-ada124a17eec
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      visualization_1:
        is_active: true
        value_display: false
        palette:
          palette_id: 6763f492-5978-f44d-82d8-5f79b946d2c5
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      visualization_2:
        is_active: true
        value_display: false
        palette:
          palette_id: fcc57912-fac8-943d-3e83-4e713f0331f6
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    series_text_format:
      average_aua:
        align: right
      households_age_income_segments.age_tier:
        bg_color: "#EDEFF8"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: [average_aua]}]
    hidden_pivots: {}
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
    hidden_fields: [households_age_income_segments.total_households_count, households_aua_segments.households_aua,
      sort]
    note_state: collapsed
    note_display: hover
    note_text: household_segmentation_by_age_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 26
    col: 0
    width: 24
    height: 6
  - title: household_segmentation_by_income
    name: household_segmentation_by_income
    model: ax360_portal
    explore: ax360_dashboards_hh
    type: looker_grid
    fields: [households_age_income_segments.total_households_count, households_aua_segments.households_aua,
      households_age_income_segments.households_pct_drill, households_aua_segments.aua_pct_drill,
      households_age_income_segments.income_tier]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count}),0,
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${households_aua_segments.aua_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization_1
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization_2
      _type_hint: number
    - category: table_calculation
      expression: |-
        if( ${households_age_income_segments.income_tier} ="Below $25,000" OR ${households_age_income_segments.income_tier} ="Moins de 25 000 $" , 1,
        if(${households_age_income_segments.income_tier} ="$25,000 to $49,999"  OR ${households_age_income_segments.income_tier} ="25 000 $ à 49 999 $", 2,
            if(${households_age_income_segments.income_tier} ="$50,000 to $99,999"  OR ${households_age_income_segments.income_tier} ="50 000 $ à 99 999 $", 3,
            if(${households_age_income_segments.income_tier} ="$100,000 to $249,999"  OR ${households_age_income_segments.income_tier} ="100 000 $ à 249 999 $",4,
              if(${households_age_income_segments.income_tier} ="$250,000 to $499,999"  OR ${households_age_income_segments.income_tier} ="250 000 $ à 499 999 $", 5,if(${households_age_income_segments.income_tier} ="$500,000 to $999,999"  OR ${households_age_income_segments.income_tier} ="500 000 $ à 999 999 $", 6,
                    if(${households_age_income_segments.income_tier} ="$1,000,000 or Above"  OR ${households_age_income_segments.income_tier} ="Plus de 1 000 000 $", 7,
                    if(${households_age_income_segments.income_tier} ="Not Available"  OR ${households_age_income_segments.income_tier} ="Non Disponible" , 8, 9))))))))
      label: sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [households_age_income_segments.income_tier, households_age_income_segments.households_pct_drill,
      visualization, households_aua_segments.aua_pct_drill, visualization_1, average_aua,
      visualization_2]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_age_income_segments.income_tier: income_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets_pct
      visualization: visualization
      average_aua: average_assets_cad
      visualization_1: visualization
      visualization_2: visualization
    series_cell_visualizations:
      households_age_income_segments.households_pct_drill:
        is_active: false
      households_aua_segments.aua_pct_drill:
        is_active: false
        value_display: false
        palette:
          palette_id: 480c114d-678e-e450-36d4-be323ee0f2df
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#1A73E8"
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 82154fab-e553-fbc8-b79f-ada124a17eec
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      visualization_1:
        is_active: true
        value_display: false
        palette:
          palette_id: 6763f492-5978-f44d-82d8-5f79b946d2c5
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      visualization_2:
        is_active: true
        value_display: false
        palette:
          palette_id: fcc57912-fac8-943d-3e83-4e713f0331f6
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    series_text_format:
      average_aua:
        align: right
      households_age_income_segments.income_tier:
        bg_color: "#EDEFF8"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-sequential-0}, bold: false,
        italic: false, strikethrough: false, fields: [average_aua]}]
    hidden_pivots: {}
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
    hidden_fields: [households_age_income_segments.total_households_count, households_aua_segments.households_aua,
      sort]
    note_state: collapsed
    note_display: hover
    note_text: household_segmentation_by_income_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 21
    col: 0
    width: 24
    height: 5
  - title: household_segmentation_by_asset
    name: household_segmentation_by_asset
    model: ax360_portal
    explore: ax360_dashboards_hh
    type: looker_grid
    fields: [households_age_income_segments.total_households_count, households_aua_segments.households_aua,
      households_age_income_segments.households_pct_drill, households_aua_segments.aua_pct_drill,
      households_aua_segments.aua_tier]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count}),0,
        ${households_aua_segments.households_aua}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${households_aua_segments.aua_pct_drill}"
      label: Visualization
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: visualization_1
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Visualization
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: visualization_2
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${households_aua_segments.aua_tier} ="Below $50,000" OR ${households_aua_segments.aua_tier} ="Moins de 50 000 $",1,
          if(${households_aua_segments.aua_tier} ="$50,000 to $99,999"  OR ${households_aua_segments.aua_tier} ="50 000 $ à 99 999 $",2,
            if(${households_aua_segments.aua_tier} ="$100,000 to $249,999"  OR ${households_aua_segments.aua_tier} ="100 000 $ à 249 999 $", 3,
              if(${households_aua_segments.aua_tier} ="$250,000 to $499,999"  OR ${households_aua_segments.aua_tier} ="250 000 $ à 499 999 $", 4,
                if(${households_aua_segments.aua_tier} ="$500,000 to $999,999"  OR ${households_aua_segments.aua_tier} ="500 000 $ à 999 999 $", 5,
                    if(${households_aua_segments.aua_tier} ="$1,000,000 to $1,999,999"  OR ${households_aua_segments.aua_tier} ="1 000 000 $ à 1 999 999 $", 6,
                    if(${households_aua_segments.aua_tier} ="$2,000,000 or Above" OR ${households_aua_segments.aua_tier} ="2 000 000 $ et plus",7,
                    if(${households_aua_segments.aua_tier} ="Not Available" OR ${households_aua_segments.aua_tier} ="Non Disponible" , 8, 9))))))))
      label: sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
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
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [households_aua_segments.aua_tier, households_age_income_segments.households_pct_drill,
      visualization, households_aua_segments.aua_pct_drill, visualization_1, average_aua,
      visualization_2, households_aua_segments.total_households]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_aua_segments.aua_tier: asset_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets_pct
      average_aua: average_assets_cad
      visualization: visualization
      visualization_1: visualization
      visualization_2: visualization
    series_cell_visualizations:
      households_age_income_segments.households_pct_drill:
        is_active: false
      households_aua_segments.aua_pct_drill:
        is_active: false
        value_display: false
        palette:
          palette_id: 480c114d-678e-e450-36d4-be323ee0f2df
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#1A73E8"
      visualization:
        is_active: true
        value_display: false
        palette:
          palette_id: 82154fab-e553-fbc8-b79f-ada124a17eec
          collection_id: qphi
          custom_colors:
          - "#003DA5"
          - "#003DA5"
      visualization_1:
        is_active: true
        value_display: false
        palette:
          palette_id: 6763f492-5978-f44d-82d8-5f79b946d2c5
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      visualization_2:
        is_active: true
        value_display: false
        palette:
          palette_id: fcc57912-fac8-943d-3e83-4e713f0331f6
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    series_text_format:
      average_aua:
        align: right
      households_aua_segments.aua_tier:
        bg_color: "#EDEFF8"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: less than, value: 0, background_color: '', font_color: "#B5252A",
        color_application: {collection_id: qphi, palette_id: qphi-diverging-0, options: {
            constraints: {min: {type: minimum}, mid: {type: number, value: 0}, max: {
                type: maximum}}, mirror: true, reverse: false, stepped: false}}, bold: false,
        italic: false, strikethrough: false, fields: [average_aua]}]
    hidden_pivots: {}
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
    hidden_fields: [households_age_income_segments.total_households_count, households_aua_segments.households_aua,
      sort]
    note_state: collapsed
    note_display: hover
    note_text: household_segmentation_by_asset_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 32
    col: 0
    width: 24
    height: 6
  - title: total_clients_single_value
    name: total_clients_single_value
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_client_multi_value]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |+
        if(is_null(
        ${dashboard.total_aua_current_month}/${dashboard.total_active_clients}),0,
        ${dashboard.total_aua_current_month}/${dashboard.total_active_clients})

      label: Average Assets per Client
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_assets_per_client
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    dividers: false
    style_dashboard.total_client_multi_value: "#3A4245"
    show_title_dashboard.total_client_multi_value: false
    title_placement_dashboard.total_client_multi_value: above
    value_format_dashboard.total_client_multi_value: ''
    style_hide: "#3A4245"
    show_title_hide: false
    title_placement_hide: above
    value_format_hide: ''
    show_comparison_hide: false
    style_dashboard.total_aua_current_month: "#3A4245"
    show_title_dashboard.total_aua_current_month: true
    title_placement_dashboard.total_aua_current_month: above
    value_format_dashboard.total_aua_current_month: ''
    style_dashboard.total_active_clients: "#3A4245"
    show_title_dashboard.total_active_clients: true
    title_placement_dashboard.total_active_clients: above
    value_format_dashboard.total_active_clients: ''
    show_comparison_dashboard.total_active_clients: false
    style_dim_party.average_assets_per_active_clients: "#3A4245"
    show_title_dim_party.average_assets_per_active_clients: true
    title_placement_dim_party.average_assets_per_active_clients: above
    value_format_dim_party.average_assets_per_active_clients: ''
    show_comparison_dim_party.average_assets_per_active_clients: false
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
    single_value_title: Total Clients
    comparison_label: Average Assets
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: total_clients_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 0
    width: 6
    height: 4
  - title: new_clients
    name: new_clients
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.new_client_multi_value]
    filters:
      dim_party.new_client_ind: 'Yes'
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        if(is_null(
        ${dashboard.total_aua_current_month}/${dashboard.total_active_clients}),0,
        ${dashboard.total_aua_current_month}/${dashboard.total_active_clients})
      label: Average Assets per New Clients
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_assets_per_new_clients
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.new_client_multi_value: "#3A4245"
    show_title_dashboard.new_client_multi_value: false
    title_placement_dashboard.new_client_multi_value: above
    value_format_dashboard.new_client_multi_value: ''
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
    single_value_title: New Clients
    comparison_label: Average Assets
    hidden_pivots: {}
    defaults_version: 0
    note_state: collapsed
    note_display: hover
    note_text: new_clients_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 6
    width: 6
    height: 4
  - title: lost_clients
    name: lost_clients
    model: ax360_portal
    explore: ax360_dashboards
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_lost_client_multi_value]
    filters:
      dim_party.lost_client_ind: 'Yes'
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |+
        abs(if(is_null(
        ${dashboard.total_transaction_amount_cad}/${dashboard.total_active_clients}),0,
        ${dashboard.total_transaction_amount_cad}/${dashboard.total_active_clients}))

      label: Average Assets per Lost Clients
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_assets_per_clients
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_lost_client_multi_value: "#3A4245"
    show_title_dashboard.total_lost_client_multi_value: false
    title_placement_dashboard.total_lost_client_multi_value: above
    value_format_dashboard.total_lost_client_multi_value: ''
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
    single_value_title: Lost Clients
    value_format: ''
    comparison_label: Average Assets
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: lost_clients_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 12
    width: 6
    height: 4
  - title: total_households
    name: total_households
    model: ax360_portal
    explore: ax360_dashboards_hh
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_household_multi_value]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: if(is_null(${dashboard.total_aua_current_month}/${dashboard.active_household_count}),0,${dashboard.total_aua_current_month}/${dashboard.active_household_count})
      label: Average AUA per household
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua_per_household
      _type_hint: number
      is_disabled: true
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: horizontal
    style_dashboard.total_household_multi_value: "#3A4245"
    show_title_dashboard.total_household_multi_value: false
    title_placement_dashboard.total_household_multi_value: above
    value_format_dashboard.total_household_multi_value: ''
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
    single_value_title: Total Households
    comparison_label: Average Assets
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
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: total_households_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 18
    width: 6
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
