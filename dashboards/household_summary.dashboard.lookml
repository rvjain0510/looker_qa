- dashboard: household_summary
  title: Household Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: 0yLp4K4JiNlCW3hcpys8H1
  elements:
  - title: New Tile
    name: New Tile
    model: ax360_portal
    explore: access_portal_dashboard
    type: looker_grid
    fields: [dashboard.account_number_link, dashboard.account_owner_link, dashboard.accnt_ownrshp_tp,
      dashboard.accnt_tp_value, dashboard.accnt_progrm_tp, dashboard.rep_cd_with_rep_cd_name,
      dashboard.aua_converted_to_cad]
    filters:
      language.lang_pref: "{{ _user_attributes['locale'] }}"
      dim_accnt.nk_hk_dim_accnt: "{{ _user_attributes['nk_account_id'] }}"
    sorts: [dashboard.aua_converted_to_cad desc]
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
    header_font_size: '14'
    rows_font_size: '14'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.account_number_link, dashboard.account_owner_link, dashboard.accnt_ownrshp_tp,
      dashboard.accnt_tp_value, dashboard.accnt_progrm_tp, dashboard.rep_cd_with_rep_cd_name, dashboard.aua_converted_to_cad]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 200
    size_to_fit: true
    series_cell_visualizations:
      dashboard.aua_converted_to_cad: false
    series_text_format:
      dashboard.aua_converted_to_cad:
        fg_color: "#525870"
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    truncate_column_names: false
    hidden_pivots: {}
    defaults_version: 1
    title_hidden: true
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 7
