---
- dashboard: revenue
  title: Revenue
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: gv9XntUzsu55IoFfy8nixu
  elements:
  - title: average_revenue
    name: average_client_revenue
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.average_client_revenue_multi_value,dashboard.average_household_revenue_multi_value]
    limit: 500
    column_limit: 50
    hidden_fields: [hide]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '12'
    orientation: horizontal
    style_dashboard.average_client_revenue_multi_value: "#3A4245"
    show_title_dashboard.average_client_revenue_multi_value: true
    title_placement_dashboard.average_client_revenue_multi_value: above
    value_format_dashboard.average_client_revenue_multi_value: ''
    style_dashboard.average_household_revenue_multi_value: "#3A4245"
    show_title_dashboard.average_household_revenue_multi_value: true
    title_placement_dashboard.average_household_revenue_multi_value: above
    value_format_dashboard.average_household_revenue_multi_value: ''
    show_title_hide_1: false
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
    note_text: average_revenue_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 0
    width: 7
    height: 4
  - title: revenue
    name: average_household_revenue
    model: ax360_portal
    explore: ax360_dashboards_hh_revenue
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.total_12_month_revenue_multi_value,dashboard.ytd_revenue_multi_value]
    limit: 500
    column_limit: 50
    hidden_fields: [hide]
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    font_size_main: '12'
    orientation: horizontal
    style_dashboard.total_12_month_revenue_multi_value: "#3A4245"
    show_title_dashboard.total_12_month_revenue_multi_value: true
    title_placement_dashboard.total_12_month_revenue_multi_value: above
    value_format_dashboard.total_12_month_revenue_multi_value: ''
    show_title_hide_1: false
    style_dashboard.ytd_revenue_multi_value: "#3A4245"
    show_title_dashboard.ytd_revenue_multi_value: true
    title_placement_dashboard.ytd_revenue_multi_value: above
    value_format_dashboard.ytd_revenue_multi_value: ''
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
    note_text: revenue_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 7
    width: 7
    height: 4
  - title: revenue_on_assets
    name: revenue_on_assets
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.revenue_on_assets_multi_value]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: horizontal
    show_title_dashboard.revenue_on_assets_multi_value: false
    show_title_test: false
    show_title_test1: false
    style_dashboard.revenue_on_assets_multi_value: "#3A4245"
    title_placement_dashboard.revenue_on_assets_multi_value: above
    value_format_dashboard.revenue_on_assets_multi_value: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    show_null_points: true
    interpolation: linear
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: revenue_on_assets_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 14
    width: 5
    height: 4
  - title: recurring_revenue_ratio
    name: recurring_revenue_ratio
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [dashboard.recurring_revenue_ratio_multi_value]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: false
    font_size_main: ''
    orientation: horizontal
    style_dashboard.recurring_revenue_ratio_multi_value: "#3A4245"
    show_title_dashboard.recurring_revenue_ratio_multi_value: false
    title_placement_dashboard.recurring_revenue_ratio_multi_value: above
    value_format_dashboard.recurring_revenue_ratio_multi_value: ''
    show_title_test: false
    show_title_test1: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    show_null_points: true
    interpolation: linear
    defaults_version: 0
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: recurring_revenue_ratio_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 0
    col: 19
    width: 5
    height: 4
  - title: revenue_by_program_type
    name: revenue_by_program_type
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: looker_grid
    fields: [dashboard.filtered_accnt_progrm_tp__value, total_revenue_last_12_months_pdt.total_12_month_revenue,
      total_revenue_last_12_months_pdt.revenue_on_assets]
    sorts: [dashboard.filtered_accnt_progrm_tp__value]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue}"
      label: visualization
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: visualization_1
      _type_hint: number
    - category: table_calculation
      expression: "${of_total_revenue}"
      label: visualization
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: visualization
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets}"
      label: visualization
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: visualization_2
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue}/sum(${total_revenue_last_12_months_pdt.total_12_month_revenue})"
      label: "%_of_total_revenue"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: of_total_revenue
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
    column_order: [dashboard.filtered_accnt_progrm_tp__value, total_revenue_last_12_months_pdt.total_12_month_revenue,
      fact_revn_rr.total_12_month_revenue, visualization_1, of_total_revenue, visualization,
      fact_revn_rr.revenue_on_assets_wo_html, scale_2, total_revenue_last_12_months_pdt.revenue_on_assets]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      fact_revn_rr.total_12_month_revenue_drill: 12_month_revenue_drill
      fact_revn_rr.revenue_pct: "%_of_total_revenue"
      fact_revn_rr.revenue_on_assets_wo_html: return_on_assets_ratio
      fact_revn_rr.total_12_month_revenue: 12_month_revenue_de
      visualization: visualization
    series_cell_visualizations:
      fact_revn_rr.total_12_month_revenue_drill:
        is_active: false
      scale:
        is_active: true
        value_display: false
      scale_1:
        is_active: true
        value_display: false
        palette:
          palette_id: b051f802-0b28-41db-c197-e2f5663d5359
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      scale_2:
        is_active: true
        value_display: false
        palette:
          palette_id: 786efc41-6dcb-17dc-ea79-59ff288c6f5e
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      visualization:
        is_active: true
        palette:
          palette_id: afee0dcf-41c9-8843-1d6f-cfe612571e9d
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
        value_display: false
      visualization_1:
        is_active: true
        value_display: false
      visualization_2:
        is_active: true
        value_display: false
        palette:
          palette_id: db29b3b0-8c9f-340c-8d68-e1b545141a89
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    series_text_format:
      dashboard.filtered_accnt_progrm_tp__value:
        bg_color: "#EDEFF8"
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
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: revenue_by_program_type_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 4
    col: 12
    width: 12
    height: 6
  - name: client_revenue_segmentation_by_income
    title: client_revenue_segmentation_by_income
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_income_note
    merged_queries:
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [dashboard.income_tier, dashboard.total_clients_pct_drill_for_segments_nohtml,
        dashboard.total_aua_pct_for_revenue_segments, dim_party.total_clients, dashboard.total_aua_12_month_including_current_for_segments,
        dashboard.total_aua_current_month_for_segments]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: |+
          if(is_null(
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients}),0,
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients})



        label: Avg AUA
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: avg_aua
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
        expression: "${dashboard.total_aua_current_month_for_segments}/sum(${dashboard.total_aua_current_month_for_segments})"
        label: Total AUA% (Segments)
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: total_aua_segments
        _type_hint: number
      join_fields: []
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [dashboard.income_tier, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
        total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
        dim_party.average_client_age, total_revenue_party_ndt.median_client_revenue,
        total_revenue_last_12_months_pdt.revenue_on_assets_for_clients]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
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
      join_fields:
      - field_name: dashboard.income_tier
        source_field_name: dashboard.income_tier
      - field_name: sort
        source_field_name: sort
    show_sql_query_menu_options: false
    column_order: [dashboard.income_tier, dashboard.total_clients_pct_drill_for_segments_nohtml,
      client_pct_scale_1, total_aua_segments, aua_scale, avg_aua, avg_aua_scale, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
      mth_revn_scale, total_revenue_party_ndt.median_client_revenue, median_revenue_scale,
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, roa_scale, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      average_client_age]
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
      roa_scale: visualization
      mth_revn_scale: visualization
      avg_aua_scale: visualization
      aua_scale: visualization
      client_pct_scale_1: visualization
      median_revenue_scale: visualization
      dashboard.income_tier: income_segment
      dashboard.total_clients_pct_drill_for_segments_nohtml: total_clients
      avg_aua: average_assets
      dashboard.total_aua_pct_for_segments: total_assets1
      fact_revn_rr.total_12_month_revenue: 12_month_revenue_de
      fact_revn_rr.recurring_revenue_ratio_12_month_wo_html: recurring_revenue_ratio
      dim_party.average_client_age: average_client_age
      total_aua_segments: total_assets
      revenue_on_assets: revenue_on_assets
      average_client_age: average_client_age
      total_revenue_party_ndt.median_client_revenue: median_client_revenue
    series_cell_visualizations:
      dashboard.total_clients_pct_drill_for_segments_nohtml:
        is_active: false
      client_pct_scale_1:
        is_active: true
        value_display: false
      aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: d51db7f2-b43d-1de4-779b-9e2d289f97d6
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 4d2e594c-b544-e755-be6e-028cf9b1d6ca
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      mth_revn_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 64633857-53f5-e4a7-ae59-0133b2eee29e
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      roa_scale:
        is_active: true
        palette:
          palette_id: 17b6c04a-b7cf-b2b6-a6bb-b80ddb9f6795
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
        value_display: false
      median_revenue_scale:
        is_active: true
        palette:
          palette_id: dc98165d-21c3-311d-f0e0-d01b222b55e6
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
        value_display: false
    series_text_format:
      dashboard.income_tier:
        bg_color: "#EDEFF8"
      average_client_age:
        align: right
      revenue_on_assets:
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
        italic: false, strikethrough: false, fields: [avg_aua]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: looker_grid
    hidden_fields: [sort, dim_party.total_clients, dashboard.total_aua_12_month_including_current_for_segments,
      dashboard.total_aua_current_month_for_segments, dashboard.total_aua_pct_for_revenue_segments]
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
        label: Total Clients Pct Drill for Segments Nohtml
        label_from_parameter:
        label_short: Total Clients Pct Drill for Segments Nohtml
        map_layer:
        name: dashboard.total_clients_pct_drill_for_segments_nohtml
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total Clients Pct Drill for Segments Nohtml
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_clients_pct_drill_for_segments_nohtml
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=763"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${dim_party.total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0)"
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
        label: Total AUA% (Segments)
        label_from_parameter:
        label_short: Total AUA% (Segments)
        map_layer:
        name: dashboard.total_aua_pct_for_revenue_segments
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total AUA% (Segments)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_pct_for_revenue_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1068"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: coalesce( ${total_aua_12_month_including_current_for_segments} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0)
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
        label: Dim Party Total Clients
        label_from_parameter:
        label_short: Total Clients
        map_layer:
        name: dim_party.total_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Total Clients
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.total_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=794"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: 'count(distinct case when ${dim_accnt.account_status_level_1} = "{{ _localization[''Open'']
          }}" then ${dim_party.party_id} end) '
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
        label: Total Aua 12 Month Including Current for Segments
        label_from_parameter:
        label_short: Total Aua 12 Month Including Current for Segments
        map_layer:
        name: dashboard.total_aua_12_month_including_current_for_segments
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
        field_group_variant: Total Aua 12 Month Including Current for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_12_month_including_current_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1054"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_last_12_month_including_current} "
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
        label: Total Aua Current Month for Segments
        label_from_parameter:
        label_short: Total Aua Current Month for Segments
        map_layer:
        name: dashboard.total_aua_current_month_for_segments
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
        field_group_variant: Total Aua Current Month for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_current_month_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1039"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_current_month} "
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
        name: avg_aua
        label: Avg AUA
        value_format: "#,##0"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: total_aua_segments
        label: Total AUA% (Segments)
        value_format: "#,##0.00%"
        is_disabled:
        sortable: true
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
        hidden: false
        is_filter: false
        is_numeric: true
        label: Total Revenue Last 12 Months Pdt 12-Month Revenue (CAD$)
        label_from_parameter:
        label_short: 12-Month Revenue (CAD$)
        map_layer:
        name: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
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
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: 12-Month Revenue (CAD$)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=92"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'coalesce(SUM(${TABLE}.total_12_month_revenue),0) '
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
        label: Total Revenue Last 12 Months Pdt Recurring Revenue Ratio
        label_from_parameter:
        label_short: Recurring Revenue Ratio
        map_layer:
        name: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Recurring Revenue Ratio
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=112"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_recurring_revenue_for_clients} / nullif(${total_12_month_revenue_for_clients},0),0) '
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: left
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
        is_numeric: false
        label: Dim Party Average Client Age
        label_from_parameter:
        label_short: Average Client Age
        map_layer:
        name: dim_party.average_client_age
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
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Average Client Age
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.average_client_age
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=835"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: 'cast(round(${avg_age}) as string) '
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
        label: Median Client Revenue
        label_from_parameter:
        label_short: Median Client Revenue
        map_layer:
        name: total_revenue_party_ndt.median_client_revenue
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: median
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: total_revenue_party_ndt
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_party_ndt
        dimension_group:
        error:
        field_group_variant: Median Client Revenue
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_party_ndt
        suggest_dimension: total_revenue_party_ndt.median_client_revenue
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_party_ndt.view.lkml?line=223"
        permanent: true
        source_file: views/total_revenue_party_ndt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_party_ndt.view.lkml
        sql: 'coalesce(${revenue},0) '
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
        label: Total Revenue Last 12 Months Pdt Revenue on Assets for Clients
        label_from_parameter:
        label_short: Revenue on Assets for Clients
        map_layer:
        name: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Revenue on Assets for Clients
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=135"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_revenue_for_clients}/nullif(${avg_aua_for_clients},0),0) '
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
        label: " Income Segment"
        label_from_parameter:
        label_short: Income Segment
        map_layer:
        name: dashboard.income_tier
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
        field_group_variant: Income Segment
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.income_tier
        suggest_explore: ax360_dashboards_revenue
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=889"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "CASE\n          WHEN ${dim_party.current_party_approx_annual_income_numeric}\
          \  < 25000 THEN   '{{ _localization['below_25k_income_seg'] }}'\n      \
          \    WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 25000\
          \ AND ${dim_party.current_party_approx_annual_income_numeric}  < 50000 THEN\
          \ '{{ _localization['25k_to_49k_income_seg'] }}'\n          WHEN ${dim_party.current_party_approx_annual_income_numeric}\
          \  >= 50000 AND ${dim_party.current_party_approx_annual_income_numeric}\
          \  < 100000 THEN '{{ _localization['50k_to_99k_income_seg'] }}'\n      \
          \    WHEN ${dim_party.current_party_approx_annual_income_numeric}  >= 100000\
          \ AND ${dim_party.current_party_approx_annual_income_numeric}  < 250000\
          \ THEN '{{ _localization['100k_to_249k_income_seg'] }}'\n          WHEN\
          \ ${dim_party.current_party_approx_annual_income_numeric}  >= 250000 AND\
          \ ${dim_party.current_party_approx_annual_income_numeric}  < 500000 THEN\
          \ '{{ _localization['250k_to_499k_income_seg'] }}'\n          WHEN ${dim_party.current_party_approx_annual_income_numeric}\
          \  >= 500000 AND ${dim_party.current_party_approx_annual_income_numeric}\
          \  < 1000000 THEN '{{ _localization['500k_to_999k_income_seg'] }}'\n   \
          \       WHEN ${dim_party.current_party_approx_annual_income_numeric}  >=\
          \ 1000000 THEN '{{ _localization['1m_or_above_income_seg'] }}'\n       \
          \   ELSE   '{{ _localization['not_available'] }}'\n          END "
        sql_case:
        filters:
        times_used: 0
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: sort
        label: sort
        value_format:
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: client pct scale
        name: client_pct_scale_1
        expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: aua % scale
        name: aua_scale
        expression: "${dashboard.total_aua_pct_for_revenue_segments}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Avg AUA Scale
        name: avg_aua_scale
        expression: "${avg_aua}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: 12 Mth Revn Scale
        name: mth_revn_scale
        expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: ROA Scale
        name: roa_scale
        expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: average_client_age
        name: average_client_age
        expression: coalesce(${dim_party.average_client_age},"Not Available")
        can_pivot: true
        sortable: true
        type: string
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
      - label: median_revenue_scale
        name: median_revenue_scale
        expression: "${total_revenue_party_ndt.median_client_revenue}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
      label: client pct scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: client_pct_scale_1
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.total_aua_pct_for_revenue_segments}"
      label: aua % scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${avg_aua}"
      label: Avg AUA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: avg_aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
      label: 12 Mth Revn Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: mth_revn_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
      label: ROA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: roa_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_party_ndt.median_client_revenue}"
      label: median_revenue_scale
      value_format:
      value_format_name: ''
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    listen:
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 25
    col: 0
    width: 24
    height: 8
  - name: client_revenue_segmentation_by_age
    title: client_revenue_segmentation_by_age
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_age_note
    merged_queries:
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [dashboard.total_clients_pct_drill_for_segments_nohtml, dim_party.total_clients,
        dashboard.age_tier, dashboard.total_aua_pct_for_revenue_segments, dashboard.total_aua_12_month_including_current_for_segments,
        dashboard.total_aua_current_month_for_segments]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: |+
          if(is_null(
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients}),0,
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients})



        label: Avg AUA
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: avg_aua
        _type_hint: number
      - category: table_calculation
        expression: "${dashboard.total_clients_pct_drill_for_segments}"
        label: "   %"
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: calculation
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${dashboard.total_aua_pct_for_segments}"
        label: Total AUA% (Cell Viz)
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: total_aua_cell_viz
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${avg_aua}"
        label: Avg AUA (Cell Viz)
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: avg_aua_cell_viz
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: if(${dashboard.total_aua_current_month_sample}=0 AND ${dim_party.total_clients}=0,no,yes
          )
        label: show 0 or not?
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: show_0_or_not
        _type_hint: yesno
        is_disabled: true
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
        label: sort
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: sort
        _type_hint: number
      - category: table_calculation
        expression: "${dashboard.total_aua_current_month_for_segments}/sum(${dashboard.total_aua_current_month_for_segments})"
        label: Total AUA% (Segments)
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: total_aua_segments
        _type_hint: number
      join_fields: []
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [dashboard.age_tier, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
        total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
        dim_party.average_client_age, total_revenue_party_ndt.median_client_revenue,
        total_revenue_last_12_months_pdt.revenue_on_assets_for_clients]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
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
        label: sort
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: sort
        _type_hint: number
      join_fields:
      - field_name: sort
        source_field_name: sort
      - field_name: dashboard.age_tier
        source_field_name: dashboard.age_tier
    show_sql_query_menu_options: false
    pinned_columns: {}
    column_order: [dashboard.age_tier, dashboard.total_clients_pct_drill_for_segments_nohtml,
      client_pct_scale, total_aua_segments, aua_scale, avg_aua, avg_aua_scale, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
      mth_revn_scale, total_revenue_party_ndt.median_client_revenue, median_revenue_scale,
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, roa_scale, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      average_client_age]
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
      dashboard.total_clients_pct_drill_for_segments_nohtml: total_clients
      dashboard.total_aua_pct_for_segments: total_assets
      avg_aua: average_assets
      dashboard.age_tier: age_segment
      fact_revn_rr.total_12_month_revenue: 12_month_revenue_de
      client_pct_scale: visualization
      aua_scale: visualization
      avg_aua_scale: visualization
      mth_revn_scale: visualization
      roa_scale: visualization
      median_revenue_scale: visualization
      total_aua_segments: total_assets
      revenue_on_assets: revenue_on_assets
      average_client_age: average_client_age
      fact_revn_rr.recurring_revenue_ratio_12_month_wo_html: recurring_revenue_ratio
      total_revenue_party_ndt.median_client_revenue: median_client_revenue
    series_cell_visualizations:
      dashboard.total_clients_pct_drill_for_segments_nohtml:
        is_active: false
      client_pct_scale:
        is_active: true
        value_display: false
      aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 7f36d136-78a6-c384-cc8d-599620a10329
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 562cbfb6-07f8-ce20-c86d-3d33c5984814
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      mth_revn_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 9f64b1bb-0415-0e9a-5a00-ed82ddd29b07
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      roa_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 4f20aecc-fd66-1aa7-b854-20140bcc569d
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
      median_revenue_scale:
        is_active: true
        palette:
          palette_id: acee17ba-4ad6-1e3d-8067-f6ccddf9442e
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
        value_display: false
    series_text_format:
      dashboard.age_tier:
        bg_color: "#EDEFF8"
      average_client_age:
        align: right
      revenue_on_assets:
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
        italic: false, strikethrough: false, fields: [avg_aua]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: looker_grid
    hidden_fields: [sort, dim_party.total_clients, dashboard.total_aua_12_month_including_current_for_segments,
      dashboard.total_aua_current_month_for_segments, dashboard.total_aua_pct_for_revenue_segments]
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
        label: Total Clients Pct Drill for Segments Nohtml
        label_from_parameter:
        label_short: Total Clients Pct Drill for Segments Nohtml
        map_layer:
        name: dashboard.total_clients_pct_drill_for_segments_nohtml
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total Clients Pct Drill for Segments Nohtml
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_clients_pct_drill_for_segments_nohtml
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=763"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${dim_party.total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0)"
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
        label: Dim Party Total Clients
        label_from_parameter:
        label_short: Total Clients
        map_layer:
        name: dim_party.total_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Total Clients
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.total_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=794"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: 'count(distinct case when ${dim_accnt.account_status_level_1} = "{{ _localization[''Open'']
          }}" then ${dim_party.party_id} end) '
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
        label: Total AUA% (Segments)
        label_from_parameter:
        label_short: Total AUA% (Segments)
        map_layer:
        name: dashboard.total_aua_pct_for_revenue_segments
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total AUA% (Segments)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_pct_for_revenue_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1068"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: coalesce( ${total_aua_12_month_including_current_for_segments} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0)
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
        label: Total Aua 12 Month Including Current for Segments
        label_from_parameter:
        label_short: Total Aua 12 Month Including Current for Segments
        map_layer:
        name: dashboard.total_aua_12_month_including_current_for_segments
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
        field_group_variant: Total Aua 12 Month Including Current for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_12_month_including_current_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1054"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_last_12_month_including_current} "
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
        label: Total Aua Current Month for Segments
        label_from_parameter:
        label_short: Total Aua Current Month for Segments
        map_layer:
        name: dashboard.total_aua_current_month_for_segments
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
        field_group_variant: Total Aua Current Month for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_current_month_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1039"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_current_month} "
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
        name: avg_aua
        label: Avg AUA
        value_format: "#,##0"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: total_aua_segments
        label: Total AUA% (Segments)
        value_format: "#,##0.00%"
        is_disabled:
        sortable: true
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
        hidden: false
        is_filter: false
        is_numeric: true
        label: Total Revenue Last 12 Months Pdt 12-Month Revenue (CAD$)
        label_from_parameter:
        label_short: 12-Month Revenue (CAD$)
        map_layer:
        name: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
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
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: 12-Month Revenue (CAD$)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=92"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'coalesce(SUM(${TABLE}.total_12_month_revenue),0) '
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
        label: Total Revenue Last 12 Months Pdt Recurring Revenue Ratio
        label_from_parameter:
        label_short: Recurring Revenue Ratio
        map_layer:
        name: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Recurring Revenue Ratio
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=112"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_recurring_revenue_for_clients} / nullif(${total_12_month_revenue_for_clients},0),0) '
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: left
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
        is_numeric: false
        label: Dim Party Average Client Age
        label_from_parameter:
        label_short: Average Client Age
        map_layer:
        name: dim_party.average_client_age
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
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Average Client Age
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.average_client_age
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=835"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: 'cast(round(${avg_age}) as string) '
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
        label: Median Client Revenue
        label_from_parameter:
        label_short: Median Client Revenue
        map_layer:
        name: total_revenue_party_ndt.median_client_revenue
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: median
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: total_revenue_party_ndt
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_party_ndt
        dimension_group:
        error:
        field_group_variant: Median Client Revenue
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_party_ndt
        suggest_dimension: total_revenue_party_ndt.median_client_revenue
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_party_ndt.view.lkml?line=223"
        permanent: true
        source_file: views/total_revenue_party_ndt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_party_ndt.view.lkml
        sql: 'coalesce(${revenue},0) '
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
        label: Total Revenue Last 12 Months Pdt Revenue on Assets
        label_from_parameter:
        label_short: Revenue on Assets
        map_layer:
        name: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Revenue on Assets
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=135"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_revenue_for_clients}/nullif(${avg_aua_for_clients},0),0) '
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
        label: " Age Segment"
        label_from_parameter:
        label_short: Age Segment
        map_layer:
        name: dashboard.age_tier
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
        field_group_variant: Age Segment
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.age_tier
        suggest_explore: ax360_dashboards_revenue
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=904"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "CASE\n          WHEN ${dim_party.age}  < 18 AND ${dim_party.age}  >\
          \ 0  THEN   '{{ _localization['below_18'] }}'\n          WHEN ${dim_party.age}\
          \  >= 18 AND ${dim_party.age}  < 30 THEN '{{ _localization['18_to_29'] }}'\n\
          \          WHEN ${dim_party.age}  >= 30 AND ${dim_party.age}  < 40 THEN\
          \ '{{ _localization['30_to_39'] }}'\n          WHEN ${dim_party.age}  >=\
          \ 40 AND ${dim_party.age}  < 50 THEN '{{ _localization['40_to_49'] }}'\n\
          \          WHEN ${dim_party.age}  >= 50 AND ${dim_party.age}  < 60 THEN\
          \ '{{ _localization['50_to_59'] }}'\n          WHEN ${dim_party.age}  >=\
          \ 60 AND ${dim_party.age}  < 65 THEN '{{ _localization['60_to_64'] }}'\n\
          \          WHEN ${dim_party.age}  >= 65 AND ${dim_party.age}  < 70 THEN\
          \ '{{ _localization['65_to_69'] }}'\n          WHEN ${dim_party.age}  >=\
          \ 70 THEN '{{ _localization['70_or_above'] }}'\n          ELSE '{{ _localization['not_available']\
          \ }}'\n          END "
        sql_case:
        filters:
        times_used: 0
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: sort
        label: sort
        value_format:
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: client pct Scale
        name: client_pct_scale
        expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: AUA % Scale
        name: aua_scale
        expression: "${dashboard.total_aua_pct_for_revenue_segments}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: avg AUA Scale
        name: avg_aua_scale
        expression: "${avg_aua}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: 12 mth revn Scale
        name: mth_revn_scale
        expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: ROA Scale
        name: roa_scale
        expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: average_client_age
        name: average_client_age
        expression: coalesce(${dim_party.average_client_age},"Not Available")
        can_pivot: true
        sortable: true
        type: string
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format: "#,##0"
      - label: median_revenue_scale
        name: median_revenue_scale
        expression: "${total_revenue_party_ndt.median_client_revenue}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
      label: client pct Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: client_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.total_aua_pct_for_revenue_segments}"
      label: AUA % Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${avg_aua}"
      label: avg AUA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: avg_aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
      label: 12 mth revn Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: mth_revn_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
      label: ROA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: roa_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_party_ndt.median_client_revenue}"
      label: median_revenue_scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    listen:
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 33
    col: 0
    width: 24
    height: 8
  - title: household_revenue_segmentation_by_income
    name: household_revenue_segmentation_by_income
    model: ax360_portal
    explore: ax360_dashboards_hh_revenue
    type: looker_grid
    fields: [households_age_income_segments.income_tier, households_age_income_segments.total_households_count,
      households_age_income_segments.households_pct_for_revenue_drill, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
      households_revenue_segments_ndt.median_household_revenue, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, total_aua_last_12_months_pdt.total_aua_current_month_for_clients,
      households_age_income_segments.average_household_age]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_for_revenue_drill}"
      label: Household pct scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: household_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/${households_age_income_segments.total_households_count}),0,
        ${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${total_assets}"
      label: AUA Pct Scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: aua_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Avg AUA Scale
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
      label: Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${median_household_revenue}"
      label: Median Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
      label: ROA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: roa_scale
      _type_hint: number
    - category: table_calculation
      expression: if (is_null(${households_age_income_segments.avg_age}),"Not Available",to_string(${households_age_income_segments.avg_age}))
      label: Average HH Age
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_hh_age
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: coalesce(${households_revenue_segments_ndt.median_household_revenue},0)
      label: median_household_revenue
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: median_household_revenue
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
    - category: table_calculation
      expression: "${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/sum(${total_aua_last_12_months_pdt.total_aua_current_month_for_clients})"
      label: total_assets
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: total_assets
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
    column_order: [households_age_income_segments.income_tier, households_age_income_segments.households_pct_for_revenue_drill,
      household_pct_scale, total_assets, aua_pct_scale, average_aua, avg_aua_scale,
      total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients, revenue_scale,
      median_household_revenue, median_revenue_scale, total_revenue_last_12_months_pdt.revenue_on_assets_for_clients,
      roa_scale, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      average_hh_age]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_age_income_segments.income_tier: income_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets
      visualization: visualization
      average_aua: average_assets
      visualization_1: visualization
      visualization_2: visualization
      visualization_3: visualization
      viualization: visualization
      households_age_income_segments.households_pct_for_revenue_drill: total_households
      households_revenue_segments_ndt.households_total_12_month_revenue: 12_month_revenue_de
      household_pct_scale: visualization
      households_aua_for_revenue_segments_ndt.aua_pct_drill: total_assets
      aua_pct_scale: visualization
      avg_aua_scale: visualization
      revenue_scale: visualization
      scale: visualization
      median_revenue_scale: visualization
      average_hh_age: average_household_age
      median_household_revenue: median_household_revenue
      total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients: 12_month_revenue
      roa_scale: visualization
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients: revenue_on_assets
      total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients: recurring_revenue_ratio
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
          palette_id: 95fb6c9d-e0d6-ef8e-5c93-84539c119c40
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
      visualization_3:
        is_active: true
        value_display: false
        palette:
          palette_id: c3db1308-82c0-22bf-266a-7e3c00b6e4c2
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      viualization:
        is_active: true
        value_display: false
        palette:
          palette_id: e7dce649-7579-71ca-3373-af43b48545e5
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      households_revenue_segments_ndt.households_total_12_month_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: a23c03b0-0338-5b2b-d18a-fae131ab67c6
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      households_revenue_segments_ndt.median_household_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: 2c627a39-c6f8-e6b8-5a0f-8961c4daa0b0
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6aa79fa6-91f5-4d9d-957c-40dc3bd4627e
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
      household_pct_scale:
        is_active: true
        value_display: false
      aua_pct_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: '09f10533-36ea-874b-6bf7-b0a9fcac4543'
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      average_aua:
        is_active: false
        value_display: false
        palette:
          palette_id: 4a778482-805e-ab25-a6ed-f2d98cb7df54
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 3be2af00-2c28-6f59-6b6a-3cf9643d9446
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6db66427-b892-b157-f880-885b565c502c
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      median_revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6ac52262-1ed4-ad77-305d-66889a033369
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      roa_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: d384d13c-25d4-de06-5eea-8d51ee66d72a
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
    series_text_format:
      average_aua:
        align: right
      households_revenue_segments_ndt.median_household_revenue: {}
      aua_pct_scale: {}
      revenue_scale: {}
      median_revenue_scale: {}
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
      sort, households_revenue_segments_ndt.median_household_revenue, total_aua_last_12_months_pdt.total_aua_current_month_for_clients]
    note_state: collapsed
    note_display: hover
    note_text: household_revenue_segmentation_by_income_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 47
    col: 0
    width: 24
    height: 8
  - name: revenue_segmentation
    title: revenue_segmentation
    note_state: collapsed
    note_display: hover
    note_text: revenue_segmentation_note
    merged_queries:
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [total_revenue_party_ndt.revenue_segment, total_revenue_party_ndt.total_clients_rs]
      sorts: [total_revenue_party_ndt.revenue_segment]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: "${total_revenue_party_ndt.total_clients_pct_drill_for_segment}"
        label: Client Pct Scale
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: client_pct_scale
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${dashboard.total_aua_current_month_for_segments}/sum(${dashboard.total_aua_current_month_for_segments})"
        label: Total Assets
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: total_assets
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${total_assets}"
        label: Asset pct scale
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: asset_pct_scale
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${dashboard.total_aua_current_month_for_segments}/${total_revenue_party_ndt.total_clients}"
        label: Average Assets (CAD$)
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: average_assets_cad
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${total_revenue_party_ndt.clients_total_12_month_revenue}"
        label: Revenue Scale
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: revenue_scale
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${total_revenue_party_ndt.clients_total_12_month_revenue}/(${dashboard.total_aua_12_month_including_current_for_segments}/12)"
        label: Revenue on Assets
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: revenue_on_assets
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${revenue_on_assets}"
        label: RoA Scale
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: roa_scale
        _type_hint: number
        is_disabled: true
      - category: table_calculation
        expression: "${average_assets_cad}"
        label: Avg Assets Scale
        value_format:
        value_format_name:
        _kind_hint: measure
        table_calculation: avg_assets_scale
        _type_hint: number
        is_disabled: true
      join_fields: []
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [households_revenue_segments_ndt.revenue_tier, households_revenue_segments_ndt.total_households_rs]
      sorts: [households_revenue_segments_ndt.total_households_rs desc 0]
      limit: 500
      column_limit: 50
      join_fields:
      - field_name: households_revenue_segments_ndt.revenue_tier
        source_field_name: total_revenue_party_ndt.revenue_segment
    show_sql_query_menu_options: false
    column_order: [total_revenue_party_ndt.revenue_segment, total_revenue_party_ndt.total_clients_rs,
      client_scale, households_revenue_segments_ndt.total_households_rs, household_scale]
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
      household_scale: visualization
      client_scale: visualization
      total_revenue_party_ndt.revenue_segment: revenue_segment_tier
      total_revenue_party_ndt.total_clients_rs: total_clients
      households_revenue_segments_ndt.total_households_rs: total_households
    series_cell_visualizations:
      total_revenue_party_ndt.total_clients:
        is_active: false
      client_scale:
        is_active: true
        value_display: false
      household_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 74155844-48a2-418b-f5cc-4d9236fd1717
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
    series_text_format:
      total_revenue_party_ndt.revenue_segment:
        bg_color: "#EDEFF8"
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: looker_grid
    series_types: {}
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
        label: Total Revenue Party Ndt Total Clients
        label_from_parameter:
        label_short: Total Clients
        map_layer:
        name: total_revenue_party_ndt.total_clients_rs
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: total_revenue_party_ndt
        view_label: Total Revenue Party Ndt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_party_ndt
        dimension_group:
        error:
        field_group_variant: Total Clients
        measure: true
        parameter: false
        primary_key: false
        project_name: looker_qphi
        scope: total_revenue_party_ndt
        suggest_dimension: total_revenue_party_ndt.total_clients_rs
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/looker_qphi/files/views%2Ftotal_revenue_party_ndt.view.lkml?line=150"
        permanent: true
        source_file: views/total_revenue_party_ndt.view.lkml
        source_file_path: looker_qphi/views/total_revenue_party_ndt.view.lkml
        sql: "${party_id} "
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
        label: Households Revenue Segments Ndt Total Households
        label_from_parameter:
        label_short: Total Households
        map_layer:
        name: households_revenue_segments_ndt.total_households_rs
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: count_distinct
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: households_revenue_segments_ndt
        view_label: Households Revenue Segments Ndt
        dynamic: false
        week_start_day: monday
        original_view: households_revenue_segments_ndt
        dimension_group:
        error:
        field_group_variant: Total Households
        measure: true
        parameter: false
        primary_key: false
        project_name: looker_qphi
        scope: households_revenue_segments_ndt
        suggest_dimension: households_revenue_segments_ndt.total_households_rs
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/looker_qphi/files/views%2Fhouseholds_revenue_segments_ndt.view.lkml?line=151"
        permanent: true
        source_file: views/households_revenue_segments_ndt.view.lkml
        source_file_path: looker_qphi/views/households_revenue_segments_ndt.view.lkml
        sql: "${houshld_id} "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: true
          pivot_index: 0
        aggregate: true
      dimensions:
      - align: left
        can_filter: false
        category: dimension
        default_filter_value:
        description: ''
        enumerations:
        field_group_label: Pre-set Buckets
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Total Revenue Party Ndt Revenue Segment
        label_from_parameter:
        label_short: Revenue Segment
        map_layer:
        name: total_revenue_party_ndt.revenue_segment
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
        view: total_revenue_party_ndt
        view_label: Total Revenue Party Ndt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_party_ndt
        dimension_group:
        error:
        field_group_variant: Revenue Segment
        measure: false
        parameter: false
        primary_key: false
        project_name: looker_qphi
        scope: total_revenue_party_ndt
        suggest_dimension: total_revenue_party_ndt.revenue_segment
        suggest_explore: ax360_dashboards_revenue
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/looker_qphi/files/views%2Ftotal_revenue_party_ndt.view.lkml?line=56"
        permanent: true
        source_file: views/total_revenue_party_ndt.view.lkml
        source_file_path: looker_qphi/views/total_revenue_party_ndt.view.lkml
        sql: "CASE\n          WHEN ${revenue}  < 500 THEN '{{ _localization['below_500_revenue_seg']\
          \ }}'\n          WHEN ${revenue}  >= 500 AND ${revenue}  < 1000 THEN '{{\
          \ _localization['500_to_999_revenue_seg'] }}'\n          WHEN ${revenue}\
          \  >= 1000 AND ${revenue}  < 2500 THEN '{{ _localization['1000_to_2499_revenue_seg']\
          \ }}'\n          WHEN ${revenue}  >= 2500 AND ${revenue}  < 5000 THEN '{{\
          \ _localization['2500_to_4999_revenue_seg'] }}'\n          WHEN ${revenue}\
          \  >= 5000 AND ${revenue}  < 10000 THEN '{{ _localization['5k_to_9999_revenue_seg']\
          \ }}'\n          WHEN ${revenue}  >= 10000 AND ${revenue}  < 20000 THEN\
          \ '{{ _localization['10k_to_19999_revenue_seg'] }}'\n          WHEN ${revenue}\
          \  >= 20000 THEN '{{ _localization['20k_or_above_revenue_seg'] }}'\n   \
          \       ELSE '{{ _localization['not_available'] }}'\n          END "
        sql_case:
        filters:
        times_used: 0
        sorted:
          sort_index: 0
          desc: false
      table_calculations:
      - label: Client Scale
        name: client_scale
        expression: "${total_revenue_party_ndt.total_clients_rs}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Household Scale
        name: household_scale
        expression: "${households_revenue_segments_ndt.total_households_rs}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    hidden_fields: [sort]
    sorts: [sort]
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${total_revenue_party_ndt.total_clients_rs}"
      label: Client Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: client_scale
      _type_hint: number
    - category: table_calculation
      expression: "${households_revenue_segments_ndt.total_households_rs}"
      label: Household Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: household_scale
      _type_hint: number
    - category: table_calculation
      expression: |-
        if(${total_revenue_party_ndt.revenue_segment} = "$0 to $500" OR ${total_revenue_party_ndt.revenue_segment} = "0 $ à 500 $" , 1,
        if(${total_revenue_party_ndt.revenue_segment} = "$500 to $999" OR ${total_revenue_party_ndt.revenue_segment} = "500 $ à 999 $" , 2,
        if(${total_revenue_party_ndt.revenue_segment} = "$1,000 to $2,499 " OR ${total_revenue_party_ndt.revenue_segment} = "1 000 $ à 2 499 $" , 3,
        if(${total_revenue_party_ndt.revenue_segment} = "$2,500 to $4,999" OR ${total_revenue_party_ndt.revenue_segment} = "2 500 $  à 4 999 $" ,4,
        if(${total_revenue_party_ndt.revenue_segment} = "$5,000 to $9,999" OR ${total_revenue_party_ndt.revenue_segment} = "5 000 $  à 9 999 $" , 5,
        if(${total_revenue_party_ndt.revenue_segment} = "$10,000 to $19,999" OR ${total_revenue_party_ndt.revenue_segment} = "10 000 $ à $19 999 $" , 6,
        if(${total_revenue_party_ndt.revenue_segment} = "$20,000 or Above" OR ${total_revenue_party_ndt.revenue_segment} = "Plus de 20 000 $" , 7,
        if(${total_revenue_party_ndt.revenue_segment} = "Not Available" OR ${total_revenue_party_ndt.revenue_segment} = "Non Disponible" , 8,9))))))))
      label: Sort
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: sort
      _type_hint: number
    listen:
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 70
    col: 0
    width: 24
    height: 6
  - title: revenue_trend
    name: revenue_trend
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: looker_line
    fields: [last_12_months_master_list.last_12_months_month, last_12_months_master_list.last_12_month_with_mtd,
      dashboard.total_12_month_revenue]
    filters:
      last_12_months_master_list.last_12_month_with_mtd: "-NULL"
    sorts: [last_12_months_master_list.last_12_months_month desc]
    limit: 12
    column_limit: 50
    dynamic_fields:
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: fact_revn_rr.total_12_month_revenue,
            id: fact_revn_rr.total_12_month_revenue, name: Revenue}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: ____________________________
    y_axis_label: 12_month_revenue_revenue_trend
    x_axis_zoom: true
    y_axis_zoom: true
    series_labels:
      dashboard.total_12_month_revenue: 12_month_revenue_revenue_trend
      last_12_months_master_list.last_12_month_with_mtd: month
    label_color: []
    x_axis_datetime_label: "%B"
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.filtered_accnt_progrm_tp__value, fact_revn_rr.total_12_month_revenue,
      scale, fact_revn_rr.revenue_pct, scale_1, fact_revn_rr.revenue_on_assets_wo_html,
      scale_2]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      fact_revn_rr.total_12_month_revenue_drill:
        is_active: false
      scale:
        is_active: true
        value_display: false
      scale_1:
        is_active: true
        value_display: false
        palette:
          palette_id: b051f802-0b28-41db-c197-e2f5663d5359
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      scale_2:
        is_active: true
        value_display: false
        palette:
          palette_id: 786efc41-6dcb-17dc-ea79-59ff288c6f5e
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: revenue_trend_note
    hidden_fields: [last_12_months_master_list.last_12_months_month]
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 10
    col: 0
    width: 12
    height: 7
  - title: rolling_12_month_revenue_trend
    name: rolling_12_month_revenue_trend
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: looker_area
    fields: [last_24_month_master_list.last_24_months, fact_revn_rr_24_months_master_list.total_revenue, last_24_month_master_list.last_24_month_with_mtd]
    sorts: [last_24_month_master_list.last_24_months desc, last_24_month_master_list.last_24_month_with_mtd
        desc]
    limit: 24
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: |-
        sum(
          if(${last_24_month_master_list.last_24_months}>=add_months(-11,${last_24_month_master_list.last_24_months}),${fact_revn_rr_24_months_master_list.total_revenue},0)
        )
      label: rolling 12 month
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: rolling_12_month
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: 'add_months(-11,${last_24_month_master_list.last_24_months})

        '
      label: minus 11 months
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: minus_11_months
      _type_hint: date
      is_disabled: true
    - category: table_calculation
      expression: "${last_24_month_master_list.last_24_months}>=${minus_11_months}"
      label: yesno
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: yesno
      _type_hint: yesno
      is_disabled: true
    - category: table_calculation
      expression: |-
        if(is_null(${fact_revn_rr_24_months_master_list.total_revenue}),0,${fact_revn_rr_24_months_master_list.total_revenue})+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},1)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},1))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},2)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},2))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},3)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},3))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},4)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},4))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},5)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},5))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},6)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},6))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},7)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},7))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},8)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},8))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},9)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},9))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},10)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},10))+
        if(is_null(offset(${fact_revn_rr_24_months_master_list.total_revenue},11)),0,offset(${fact_revn_rr_24_months_master_list.total_revenue},11))
      label: 12_month_revenue_revenue_trend
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: rolling_12_month_1
      _type_hint: number
    - category: table_calculation
      expression: if(row()>12,no,yes)
      label: Show 12 rows?
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_12_rows
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: rolling_12_month_1,
            id: rolling_12_month_1, name: rolling_12_month}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear}]
    x_axis_zoom: true
    y_axis_zoom: true
    series_labels:
      rolling_12_month_revenue: 12_month_revenue_revenue_trend
    x_axis_label: ____________________________
    x_axis_datetime_label: "%B"
    swap_axes: false
    hidden_pivots: {}
    hidden_fields: [fact_revn_rr_24_months_master_list.total_revenue, last_24_month_master_list.last_24_months]
    hidden_points_if_no: [show_12_rows]
    defaults_version: 1
    note_state: collapsed
    note_display: hover
    note_text: rolling_12_month_revenue_trend_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 10
    col: 12
    width: 12
    height: 7
  - title: revenue_trend_by_program_type
    name: revenue_trend_by_program_type
    model: ax360_portal
    explore: ax360_dashboards_revenue
    type: looker_line
    fields: [last_12_months_master_list.last_12_months_month, last_12_months_master_list.last_12_month_with_mtd,
    fact_revn_rr_12_months_master_list.total_12_month_commission_revenue, fact_revn_rr_12_months_master_list.total_12_month_feebased_revenue,
    fact_revn_rr_12_months_master_list.total_12_month_managed_revenue, fact_revn_rr_12_months_master_list.total_12_month_sma_revenue,
    fact_revn_rr_12_months_master_list.total_12_month_uma_revenue]
    sorts: [last_12_months_master_list.last_12_months_month desc]
    limit: 12
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_12_month_revenue_for_pgrm_tp_trend}"
      label: Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: scale
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "${fact_revn_rr.revenue_pct}"
      label: Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: scale_1
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: "${fact_revn_rr.revenue_on_assets_wo_html}"
      label: Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: scale_2
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: if(is_null(${last_12_months_master_list.last_12_month_with_mtd}),no,yes)
      label: Show 12 rows?
      value_format:
      value_format_name:
      _kind_hint: dimension
      table_calculation: show_12_rows
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
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: '', orientation: left, series: [{axisId: dashboard.total_12_month_revenue_for_pgrm_tp_trend,
            id: dashboard.total_12_month_revenue_for_pgrm_tp_trend, name: Revenue}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: ____________________________
    y_axis_label: 12_month_revenue_revenue_trend
    x_axis_zoom: true
    y_axis_zoom: true
    series_colors:
      fact_revn_rr_12_months_master_list.total_12_month_feebased_revenue: "#00A873"
      fact_revn_rr_12_months_master_list.total_12_month_commission_revenue: "#003DA5"
      fact_revn_rr_12_months_master_list.total_12_month_sma_revenue: "#8A3EB0"
      fact_revn_rr_12_months_master_list.total_12_month_uma_revenue: "#D13599"
      fact_revn_rr_12_months_master_list.total_12_month_managed_revenue: "#C78500"
    series_labels:
      dashboard.total_12_month_revenue_for_pgrm_tp_trend: 12_month_revenue_revenue_trend
      fact_revn_rr.month: month
    label_color: []
    x_axis_datetime_label: "%B"
    show_row_numbers: false
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_cell_visualizations:
      dashboard.total_12_month_revenue_for_pgrm_tp_trend:
        is_active: false
      scale:
        is_active: true
        value_display: false
      scale_1:
        is_active: true
        value_display: false
        palette:
          palette_id: b051f802-0b28-41db-c197-e2f5663d5359
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      scale_2:
        is_active: true
        value_display: false
        palette:
          palette_id: 786efc41-6dcb-17dc-ea79-59ff288c6f5e
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    note_state: collapsed
    note_display: hover
    note_text: revenue_trend_by_program_type_note
    hidden_fields: [last_12_months_master_list.last_12_months_month]
    hidden_points_if_no: [show_12_rows]
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 4
    col: 0
    width: 12
    height: 6
  - title: household_revenue_segmentation_by_age
    name: household_revenue_segmentation_by_age
    model: ax360_portal
    explore: ax360_dashboards_hh_revenue
    type: looker_grid
    fields: [households_age_income_segments.total_households_count, households_age_income_segments.households_pct_for_revenue_drill,
      total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients, households_revenue_segments_ndt.median_household_revenue,
      total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, total_aua_last_12_months_pdt.total_aua_current_month_for_clients,
      households_age_income_segments.age_tier, households_age_income_segments.average_household_age]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_for_revenue_drill}"
      label: Household pct scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: household_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/${households_age_income_segments.total_households_count}),0,
        ${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${total_assets}"
      label: AUA Pct Scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: aua_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Avg AUA Scale
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
      label: Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${median_household_revenue}"
      label: Median Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
      label: ROA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: roa_scale
      _type_hint: number
    - category: table_calculation
      expression: if (is_null(${households_age_income_segments.avg_age}),"Not Available",to_string(${households_age_income_segments.avg_age}))
      label: Average HH Age
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_hh_age
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: coalesce(${households_revenue_segments_ndt.median_household_revenue},0)
      label: median_household_revenue
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: median_household_revenue
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
    - category: table_calculation
      expression: "${total_aua_last_12_months_pdt.total_aua_current_month_for_clients}/sum(${total_aua_last_12_months_pdt.total_aua_current_month_for_clients})"
      label: total_assets
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: total_assets
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
    column_order: [households_age_income_segments.age_tier, households_age_income_segments.households_pct_for_revenue_drill,
      household_pct_scale, total_assets, aua_pct_scale, average_aua, avg_aua_scale,
      total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients, revenue_scale,
      median_household_revenue, median_revenue_scale, total_revenue_last_12_months_pdt.revenue_on_assets_for_clients,
      roa_scale, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      average_hh_age]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_age_income_segments.income_tier: income_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets
      visualization: visualization
      average_aua: average_assets
      visualization_1: visualization
      visualization_2: visualization
      visualization_3: visualization
      viualization: visualization
      households_age_income_segments.households_pct_for_revenue_drill: total_households
      households_revenue_segments_ndt.households_total_12_month_revenue: 12_month_revenue_de
      household_pct_scale: visualization
      households_aua_for_revenue_segments_ndt.aua_pct_drill: total_assets
      aua_pct_scale: visualization
      avg_aua_scale: visualization
      revenue_scale: visualization
      scale: visualization
      median_revenue_scale: visualization
      average_hh_age: average_household_age
      median_household_revenue: median_household_revenue
      total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients: 12_month_revenue
      roa_scale: visualization
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients: revenue_on_assets
      total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients: recurring_revenue_ratio
      households_age_income_segments.age_tier: age_segment
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
          palette_id: 95fb6c9d-e0d6-ef8e-5c93-84539c119c40
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
      visualization_3:
        is_active: true
        value_display: false
        palette:
          palette_id: c3db1308-82c0-22bf-266a-7e3c00b6e4c2
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      viualization:
        is_active: true
        value_display: false
        palette:
          palette_id: e7dce649-7579-71ca-3373-af43b48545e5
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      households_revenue_segments_ndt.households_total_12_month_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: a23c03b0-0338-5b2b-d18a-fae131ab67c6
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      households_revenue_segments_ndt.median_household_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: 2c627a39-c6f8-e6b8-5a0f-8961c4daa0b0
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6aa79fa6-91f5-4d9d-957c-40dc3bd4627e
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
      household_pct_scale:
        is_active: true
        value_display: false
      aua_pct_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: '09f10533-36ea-874b-6bf7-b0a9fcac4543'
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      average_aua:
        is_active: false
        value_display: false
        palette:
          palette_id: 4a778482-805e-ab25-a6ed-f2d98cb7df54
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 3be2af00-2c28-6f59-6b6a-3cf9643d9446
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6db66427-b892-b157-f880-885b565c502c
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      median_revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6ac52262-1ed4-ad77-305d-66889a033369
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      roa_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: d384d13c-25d4-de06-5eea-8d51ee66d72a
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
    series_text_format:
      average_aua:
        align: right
      households_revenue_segments_ndt.median_household_revenue: {}
      aua_pct_scale: {}
      revenue_scale: {}
      median_revenue_scale: {}
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
      sort, households_revenue_segments_ndt.median_household_revenue, total_aua_last_12_months_pdt.total_aua_current_month_for_clients]
    note_state: collapsed
    note_display: hover
    note_text: household_revenue_segmentation_by_income_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 55
    col: 0
    width: 24
    height: 8
  - title: household_revenue_segmentation_by_asset
    name: household_revenue_segmentation_by_asset
    model: ax360_portal
    explore: ax360_dashboards_hh_revenue
    type: looker_grid
    fields: [households_age_income_segments.total_households_count, households_aua_for_revenue_segments_ndt.households_aua,
      households_age_income_segments.households_pct_for_revenue_drill, households_aua_for_revenue_segments_ndt.aua_pct_drill,
      households_revenue_segments_ndt.households_total_12_month_revenue, households_revenue_segments_ndt.median_household_revenue,
      households_revenue_segments_ndt.households_recurring_revenue_ratio, households_aua_for_revenue_segments_ndt.households_aua_12_month,
      households_revenue_segments_ndt.households_revenue_on_assets, households_age_income_segments.average_household_age,
      households_aua_segments.aua_tier]
    sorts: [sort]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${households_age_income_segments.households_pct_for_revenue_drill}"
      label: Household pct scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: household_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: |+
        if(is_null(
        ${households_aua_for_revenue_segments_ndt.households_aua}/${households_age_income_segments.total_households_count}),0,
        ${households_aua_for_revenue_segments_ndt.households_aua}/${households_age_income_segments.total_households_count})



      label: Average AUA
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_aua
      _type_hint: number
    - category: table_calculation
      expression: "${households_aua_for_revenue_segments_ndt.aua_pct_drill}"
      label: AUA Pct Scale
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: aua_pct_scale
      _type_hint: number
    - category: table_calculation
      expression: "${average_aua}"
      label: Avg AUA Scale
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: avg_aua_scale
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
    - category: table_calculation
      expression: "${households_revenue_segments_ndt.households_total_12_month_revenue}"
      label: Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${median_household_revenue}"
      label: Median Revenue Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    - category: table_calculation
      expression: "${households_revenue_segments_ndt.households_revenue_on_assets}"
      label: Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: scale
      _type_hint: number
    - category: table_calculation
      expression: if (is_null(${households_age_income_segments.avg_age}),"Not Available",to_string(${households_age_income_segments.avg_age}))
      label: Average HH Age
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: average_hh_age
      _type_hint: string
      is_disabled: true
    - category: table_calculation
      expression: "${households_revenue_segments_ndt.households_total_12_month_revenue}/(${households_aua_for_revenue_segments_ndt.households_aua_12_month}/12)"
      label: Revenue on Assets
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      table_calculation: revenue_on_assets
      _type_hint: number
      is_disabled: true
    - category: table_calculation
      expression: coalesce(${households_revenue_segments_ndt.median_household_revenue},0)
      label: median_household_revenue
      value_format:
      value_format_name: decimal_0
      _kind_hint: measure
      table_calculation: median_household_revenue
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
    column_order: [households_aua_segments.aua_tier, households_age_income_segments.households_pct_for_revenue_drill,
      household_pct_scale, households_aua_for_revenue_segments_ndt.aua_pct_drill,
      aua_pct_scale, average_aua, avg_aua_scale, households_revenue_segments_ndt.households_total_12_month_revenue,
      revenue_scale, median_household_revenue, median_revenue_scale, households_revenue_segments_ndt.households_revenue_on_assets,
      scale, households_revenue_segments_ndt.households_recurring_revenue_ratio, households_age_income_segments.average_household_age]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      households_age_income_segments.income_tier: income_segment
      households_age_income_segments.households_pct_drill: total_households
      households_aua_segments.aua_pct_drill: total_assets
      households_revenue_segments_ndt.aua_tier: asset_segment
      visualization: visualization
      average_aua: average_assets
      visualization_1: visualization
      visualization_2: visualization
      visualization_3: visualization
      viualization: visualization
      scale: visualization
      households_age_income_segments.households_pct_for_revenue_drill: total_households
      households_revenue_segments_ndt.households_total_12_month_revenue: 12_month_revenue_de
      household_pct_scale: visualization
      households_aua_for_revenue_segments_ndt.aua_pct_drill: total_assets
      aua_pct_scale: visualization
      avg_aua_scale: visualization
      revenue_scale: visualization
      median_revenue_scale: visualization
      average_hh_age: average_household_age
      median_household_revenue: median_household_revenue
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
          palette_id: 95fb6c9d-e0d6-ef8e-5c93-84539c119c40
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
      visualization_3:
        is_active: true
        value_display: false
        palette:
          palette_id: c3db1308-82c0-22bf-266a-7e3c00b6e4c2
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      viualization:
        is_active: true
        value_display: false
        palette:
          palette_id: e7dce649-7579-71ca-3373-af43b48545e5
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
      households_revenue_segments_ndt.households_total_12_month_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: a23c03b0-0338-5b2b-d18a-fae131ab67c6
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      households_revenue_segments_ndt.median_household_revenue:
        is_active: false
        value_display: false
        palette:
          palette_id: 2c627a39-c6f8-e6b8-5a0f-8961c4daa0b0
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6aa79fa6-91f5-4d9d-957c-40dc3bd4627e
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
      household_pct_scale:
        is_active: true
        value_display: false
      aua_pct_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: '09f10533-36ea-874b-6bf7-b0a9fcac4543'
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      average_aua:
        is_active: false
        value_display: false
        palette:
          palette_id: 4a778482-805e-ab25-a6ed-f2d98cb7df54
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 3be2af00-2c28-6f59-6b6a-3cf9643d9446
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6db66427-b892-b157-f880-885b565c502c
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      median_revenue_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 6ac52262-1ed4-ad77-305d-66889a033369
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
    series_text_format:
      average_aua:
        align: right
      households_revenue_segments_ndt.households_total_12_month_revenue: {}
      households_revenue_segments_ndt.median_household_revenue: {}
      aua_pct_scale: {}
      revenue_scale: {}
      median_revenue_scale: {}
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
      sort, households_aua_for_revenue_segments_ndt.households_aua, households_aua_for_revenue_segments_ndt.households_aua_12_month,
      households_revenue_segments_ndt.median_household_revenue]
    note_state: collapsed
    note_display: hover
    note_text: household_revenue_segmentation_by_asset_note
    listen:
      IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 64
    col: 0
    width: 24
    height: 7
  - name: client_revenue_segmentation_by_asset
    title: client_revenue_segmentation_by_asset
    merged_queries:
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [dashboard.total_clients_pct_drill_for_segments_nohtml, dashboard.total_aua_pct_for_revenue_segments,
        dim_party.total_clients, dashboard.total_aua_12_month_including_current_for_segments,
        dashboard.total_aua_current_month_for_segments, total_aua_party_ndt.aua_tier]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: |+
          if(is_null(
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients}),0,
          ${dashboard.total_aua_current_month_for_segments}/${dim_party.total_clients})



        label: Avg AUA
        value_format:
        value_format_name: decimal_0
        _kind_hint: measure
        table_calculation: avg_aua
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
        expression: "${dashboard.total_aua_current_month_for_segments}/sum(${dashboard.total_aua_current_month_for_segments})"
        label: Total AUA% (Segments)
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: total_aua_segments
        _type_hint: number
      join_fields: []
    - model: ax360_portal
      explore: ax360_dashboards_revenue
      type: table
      fields: [total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
        total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
        dim_party.average_client_age, total_revenue_party_ndt.median_client_revenue,
        total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, total_aua_party_ndt.aua_tier]
      sorts: [sort]
      limit: 500
      column_limit: 50
      dynamic_fields:
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
      join_fields:
      - field_name: total_aua_party_ndt.aua_tier
        source_field_name: total_aua_party_ndt.aua_tier
      - field_name: sort
        source_field_name: sort
    note_state: collapsed
    note_display: hover
    note_text: client_segmentation_by_asset_note
    show_sql_query_menu_options: false
    column_order: [total_aua_party_ndt.aua_tier, dashboard.total_clients_pct_drill_for_segments_nohtml,
      client_pct_scale_1, total_aua_segments, aua_scale, avg_aua, avg_aua_scale, total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients,
      mth_revn_scale, total_revenue_party_ndt.median_client_revenue, median_revenue_scale,
      total_revenue_last_12_months_pdt.revenue_on_assets_for_clients, roa_scale, total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients,
      dim_party.average_client_age]
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
      roa_scale: visualization
      mth_revn_scale: visualization
      avg_aua_scale: visualization
      aua_scale: visualization
      client_pct_scale_1: visualization
      median_revenue_scale: visualization
      dashboard.income_tier: income_segment
      dashboard.total_clients_pct_drill_for_segments_nohtml: total_clients
      avg_aua: average_assets
      dashboard.total_aua_pct_for_segments: total_assets1
      fact_revn_rr.total_12_month_revenue: 12_month_revenue_de
      fact_revn_rr.recurring_revenue_ratio_12_month_wo_html: recurring_revenue_ratio
      dim_party.average_client_age: average_client_age
      total_aua_segments: total_assets
      revenue_on_assets: revenue_on_assets
      average_client_age: average_client_age
      total_revenue_party_ndt.median_client_revenue: median_client_revenue
    series_cell_visualizations:
      dashboard.total_clients_pct_drill_for_segments_nohtml:
        is_active: false
      client_pct_scale_1:
        is_active: true
        value_display: false
      aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: d51db7f2-b43d-1de4-779b-9e2d289f97d6
          collection_id: qphi
          custom_colors:
          - "#00A873"
          - "#00A873"
      avg_aua_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 4d2e594c-b544-e755-be6e-028cf9b1d6ca
          collection_id: qphi
          custom_colors:
          - "#C78500"
          - "#C78500"
      mth_revn_scale:
        is_active: true
        value_display: false
        palette:
          palette_id: 64633857-53f5-e4a7-ae59-0133b2eee29e
          collection_id: qphi
          custom_colors:
          - "#8A3EB0"
          - "#8A3EB0"
      roa_scale:
        is_active: true
        palette:
          palette_id: 17b6c04a-b7cf-b2b6-a6bb-b80ddb9f6795
          collection_id: qphi
          custom_colors:
          - "#668FFF"
          - "#668FFF"
        value_display: false
      median_revenue_scale:
        is_active: true
        palette:
          palette_id: dc98165d-21c3-311d-f0e0-d01b222b55e6
          collection_id: qphi
          custom_colors:
          - "#D13599"
          - "#D13599"
        value_display: false
    series_text_format:
      dashboard.income_tier:
        bg_color: "#EDEFF8"
      average_client_age:
        align: right
      revenue_on_assets:
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
        italic: false, strikethrough: false, fields: [avg_aua]}]
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    type: looker_grid
    hidden_fields: [sort, dim_party.total_clients, dashboard.total_aua_12_month_including_current_for_segments,
      dashboard.total_aua_current_month_for_segments, dashboard.total_aua_pct_for_revenue_segments]
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
        label: Total Clients Pct Drill for Segments Nohtml
        label_from_parameter:
        label_short: Total Clients Pct Drill for Segments Nohtml
        map_layer:
        name: dashboard.total_clients_pct_drill_for_segments_nohtml
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total Clients Pct Drill for Segments Nohtml
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_clients_pct_drill_for_segments_nohtml
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=779"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${dim_party.total_clients} /nullif(${totals_for_segments_ndt.total_clients_for_segments},0)"
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
        label: Total AUA% (Segments)
        label_from_parameter:
        label_short: Total AUA% (Segments)
        map_layer:
        name: dashboard.total_aua_pct_for_revenue_segments
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: dashboard
        view_label: ''
        dynamic: false
        week_start_day: monday
        original_view: dashboard
        dimension_group:
        error:
        field_group_variant: Total AUA% (Segments)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_pct_for_revenue_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1093"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: coalesce( ${total_aua_12_month_including_current_for_segments} /nullif(${totals_for_segments_ndt.total_aua_for_segments},0),0)
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
        label: Dim Party Total Clients
        label_from_parameter:
        label_short: Total Clients
        map_layer:
        name: dim_party.total_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format:
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Total Clients
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.total_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=794"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: 'count(distinct case when ${dim_accnt.account_status_level_1} = "{{ _localization[''Open'']
          }}" then ${dim_party.party_id} end) '
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
        label: Total Aua 12 Month Including Current for Segments
        label_from_parameter:
        label_short: Total Aua 12 Month Including Current for Segments
        map_layer:
        name: dashboard.total_aua_12_month_including_current_for_segments
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
        field_group_variant: Total Aua 12 Month Including Current for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_12_month_including_current_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1079"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_last_12_month_including_current} "
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
        label: Total Aua Current Month for Segments
        label_from_parameter:
        label_short: Total Aua Current Month for Segments
        map_layer:
        name: dashboard.total_aua_current_month_for_segments
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
        field_group_variant: Total Aua Current Month for Segments
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dashboard
        suggest_dimension: dashboard.total_aua_current_month_for_segments
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdashboard.view.lkml?line=1064"
        permanent: true
        source_file: views/dashboard.view.lkml
        source_file_path: prj_ax360_portal/views/dashboard.view.lkml
        sql: "${fact_holdng_rr.total_aua_current_month} "
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
        name: avg_aua
        label: Avg AUA
        value_format: "#,##0"
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      - type: number
        align: right
        measure: true
        dynamic: false
        can_pivot: true
        is_numeric: true
        name: total_aua_segments
        label: Total AUA% (Segments)
        value_format: "#,##0.00%"
        is_disabled:
        sortable: true
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
        hidden: false
        is_filter: false
        is_numeric: true
        label: Total Revenue Last 12 Months Pdt 12-Month Revenue (CAD$)
        label_from_parameter:
        label_short: 12-Month Revenue (CAD$)
        map_layer:
        name: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
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
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: 12-Month Revenue (CAD$)
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=140"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'coalesce(SUM(${TABLE}.total_12_month_revenue),0) '
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
        label: Total Revenue Last 12 Months Pdt Recurring Revenue Ratio
        label_from_parameter:
        label_short: Recurring Revenue Ratio
        map_layer:
        name: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Recurring Revenue Ratio
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.recurring_revenue_ratio_12_month_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=172"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_recurring_revenue_for_clients} / nullif(${total_12_month_revenue_for_clients},0),0) '
        sql_case:
        filters:
        times_used: 0
        aggregate: true
      - align: left
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
        is_numeric: false
        label: Dim Party Average Client Age
        label_from_parameter:
        label_short: Average Client Age
        map_layer:
        name: dim_party.average_client_age
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
        view: dim_party
        view_label: Dim Party
        dynamic: false
        week_start_day: monday
        original_view: dim_party
        dimension_group:
        error:
        field_group_variant: Average Client Age
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: dim_party
        suggest_dimension: dim_party.average_client_age
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Fdim_party.view.lkml?line=840"
        permanent: true
        source_file: views/dim_party.view.lkml
        source_file_path: prj_ax360_portal/views/dim_party.view.lkml
        sql: coalesce(cast(round(${avg_age}) as string), "{{ _localization['not_available']
          }}" )
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
        label: Total Revenue Party Ndt Median Client Revenue
        label_from_parameter:
        label_short: Median Client Revenue
        map_layer:
        name: total_revenue_party_ndt.median_client_revenue
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: median
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0"
        view: total_revenue_party_ndt
        view_label: Total Revenue Party Ndt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_party_ndt
        dimension_group:
        error:
        field_group_variant: Median Client Revenue
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_party_ndt
        suggest_dimension: total_revenue_party_ndt.median_client_revenue
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_party_ndt.view.lkml?line=238"
        permanent: true
        source_file: views/total_revenue_party_ndt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_party_ndt.view.lkml
        sql: 'coalesce(${revenue},0) '
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
        label: Total Revenue Last 12 Months Pdt Revenue on Assets
        label_from_parameter:
        label_short: Revenue on Assets
        map_layer:
        name: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        strict_value_format: false
        requires_refresh_on_sort: false
        sortable: true
        suggestions:
        tags: []
        type: number
        user_attribute_filter_types:
        - number
        - advanced_filter_number
        value_format: "#,##0.00%"
        view: total_revenue_last_12_months_pdt
        view_label: Total Revenue Last 12 Months Pdt
        dynamic: false
        week_start_day: monday
        original_view: total_revenue_last_12_months_pdt
        dimension_group:
        error:
        field_group_variant: Revenue on Assets
        measure: true
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_revenue_last_12_months_pdt
        suggest_dimension: total_revenue_last_12_months_pdt.revenue_on_assets_for_clients
        suggest_explore: ax360_dashboards_revenue
        suggestable: false
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_revenue_last_12_months_pdt.view.lkml?line=204"
        permanent: true
        source_file: views/total_revenue_last_12_months_pdt.view.lkml
        source_file_path: prj_ax360_portal/views/total_revenue_last_12_months_pdt.view.lkml
        sql: 'ifnull(${total_12_month_revenue_for_clients}/nullif(${avg_aua_for_clients},0),0) '
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
        field_group_label: Pre-set Buckets
        fill_style:
        fiscal_month_offset: 0
        has_allowed_values: false
        hidden: false
        is_filter: false
        is_numeric: false
        label: Total Aua Party Ndt Asset Segment
        label_from_parameter:
        label_short: Asset Segment
        map_layer:
        name: total_aua_party_ndt.aua_tier
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
        view: total_aua_party_ndt
        view_label: Total Aua Party Ndt
        dynamic: false
        week_start_day: monday
        original_view: total_aua_party_ndt
        dimension_group:
        error:
        field_group_variant: Asset Segment
        measure: false
        parameter: false
        primary_key: false
        project_name: prj_ax360_portal
        scope: total_aua_party_ndt
        suggest_dimension: total_aua_party_ndt.aua_tier
        suggest_explore: ax360_dashboards_revenue
        suggestable: true
        is_fiscal: false
        is_timeframe: false
        can_time_filter: false
        time_interval:
        lookml_link: "/projects/prj_ax360_portal/files/views%2Ftotal_aua_party_ndt.view.lkml?line=67"
        permanent: true
        source_file: views/total_aua_party_ndt.view.lkml
        source_file_path: prj_ax360_portal/views/total_aua_party_ndt.view.lkml
        sql: "CASE\n          WHEN ${aua}  < 50000 THEN '{{ _localization['below_50k_aua_seg']\
          \ }}'\n          WHEN ${aua}  >= 50000 AND ${aua}  < 100000 THEN '{{ _localization['50k_to_99k_aua_seg']\
          \ }}'\n          WHEN ${aua}  >= 100000 AND ${aua}  < 250000 THEN '{{ _localization['100k_to_249k_aua_seg']\
          \ }}'\n          WHEN ${aua}  >= 250000 AND ${aua}  < 500000 THEN '{{ _localization['250k_to_499k_aua_seg']\
          \ }}'\n          WHEN ${aua}  >= 500000 AND ${aua}  < 1000000 THEN '{{ _localization['500k_to_999k_aua_seg']\
          \ }}'\n          WHEN ${aua}  >= 1000000 AND ${aua}  < 2000000 THEN '{{\
          \ _localization['1m_to_1.9m_aua_seg'] }}'\n          WHEN ${aua}  >= 2000000\
          \ THEN '{{ _localization['2m_or_above_aua_seg'] }}'\n          ELSE '{{\
          \ _localization['not_available'] }}'\n          END "
        sql_case:
        filters:
        times_used: 0
      - type: number
        align: right
        measure: false
        dynamic: false
        can_pivot: false
        is_numeric: true
        name: sort
        label: sort
        value_format:
        is_disabled:
        sortable: true
        aggregate: true
        can_filter: false
        permanent: true
      table_calculations:
      - label: client pct scale
        name: client_pct_scale_1
        expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: aua % scale
        name: aua_scale
        expression: "${dashboard.total_aua_pct_for_revenue_segments}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: Avg AUA Scale
        name: avg_aua_scale
        expression: "${avg_aua}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: 12 Mth Revn Scale
        name: mth_revn_scale
        expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: ROA Scale
        name: roa_scale
        expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      - label: median_revenue_scale
        name: median_revenue_scale
        expression: "${total_revenue_party_ndt.median_client_revenue}"
        can_pivot: true
        sortable: true
        type: number
        align: right
        measure: true
        is_table_calculation: true
        dynamic: true
        value_format:
        is_numeric: true
      pivots: []
    hidden_pivots: {}
    column_limit: 50
    dynamic_fields:
    - category: table_calculation
      expression: "${dashboard.total_clients_pct_drill_for_segments_nohtml}"
      label: client pct scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: client_pct_scale_1
      _type_hint: number
    - category: table_calculation
      expression: "${dashboard.total_aua_pct_for_revenue_segments}"
      label: aua % scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${avg_aua}"
      label: Avg AUA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: avg_aua_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.total_12_month_revenue_for_clients}"
      label: 12 Mth Revn Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: mth_revn_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_last_12_months_pdt.revenue_on_assets_for_clients}"
      label: ROA Scale
      value_format:
      value_format_name:
      _kind_hint: measure
      table_calculation: roa_scale
      _type_hint: number
    - category: table_calculation
      expression: "${total_revenue_party_ndt.median_client_revenue}"
      label: median_revenue_scale
      value_format:
      value_format_name: ''
      _kind_hint: measure
      table_calculation: median_revenue_scale
      _type_hint: number
    listen:
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    - IA Code: dashboard.rep_cd_with_rep_cd_name
      RVP Name: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
      Team Name: filtered_rep_cd_by_rvp_branch_team.team_name
      Branch Name: filtered_rep_cd_by_rvp_branch_team.physical_branch_manager_name
    row: 41
    col: 0
    width: 24
    height: 8
  filters:
  - name: IA Code
    title: IA Code
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: ax360_portal
    explore: ax360_dashboards_revenue
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
      options: []
    model: ax360_portal
    explore: ax360_dashboards_revenue
    listens_to_filters: [IA Code, Branch Name, Team Name]
    field: filtered_rep_cd_by_rvp_branch_team.regional_vice_president_name
  - name: Branch Name
    title: Branch Name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: ax360_dashboards_revenue
    listens_to_filters: [Team Name, IA Code, RVP Name]
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
      options: []
    model: ax360_portal
    explore: ax360_dashboards_revenue
    listens_to_filters: [IA Code, RVP Name, Branch Name]
    field: filtered_rep_cd_by_rvp_branch_team.team_name
