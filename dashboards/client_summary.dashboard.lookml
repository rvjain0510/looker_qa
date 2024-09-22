- dashboard: client_summary
  title: Client Summary
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: V6asfRVpYm7SirZWHPs7Ev
  elements:
  - title: Client Summary
    name: Client Summary
    model: ax360_portal
    explore: access_portal_dashboard
    type: looker_grid
    fields: [dashboard.aua_converted_to_cad, dashboard.account_number_link, dashboard.accnt_tp_value,
      dashboard.accnt_holdr_name, dashboard.accnt_ownrshp_tp, dashboard.accnt_progrm_tp,
      dashboard.rep_cd_with_rep_cd_name]
    filters:
      dim_party.nk_hk_dim_party: "{{ _user_attributes['nk_hk_dim_party'] }}"
      language.lang_pref: "{{ _user_attributes['locale'] }}"
    sorts: [dashboard.accnt_ownrshp_tp]
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
    rows_font_size: '15'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: qphi
      palette_id: qphi-categorical-0
    show_sql_query_menu_options: false
    column_order: [dashboard.account_number_link, dashboard.accnt_tp_value,
      dashboard.accnt_holdr_name, dashboard.accnt_ownrshp_tp, dashboard.accnt_progrm_tp,
      dashboard.rep_cd_with_rep_cd_name, dashboard.aua_converted_to_cad]
    show_totals: true
    show_row_totals: true
    truncate_header: true
    minimum_column_width: 175
    size_to_fit: true
    series_cell_visualizations:
      dashboard.aua_converted_to_cad: false
    series_text_format:
      dashboard.aua_converted_to_cad:
        fg_color: "#525870"
        align: right
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    hidden_fields: []
    defaults_version: 1
    hidden_pivots: {}
    title_hidden: true
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 7
