- dashboard: holdings_consolidated
  title: Holdings - Consolidated
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: NlCGfn0U1jHQ3sOcZ7WQWZ
  elements:
  - title: Holdings - Consolidated
    name: Holdings - Consolidated
    model: ax360_portal
    explore: access_portal_dashboard
    type: looker_grid
    fields: [dashboard.symbol_desc_holding, dashboard.quantity_holdings_consolidated,
      dashboard.market_price_holdings_consolidated, dashboard.market_value_holdings_consolidated,
      dashboard.account_transaction]
    filters:
      dim_accnt.nk_hk_dim_accnt: "{{ _user_attributes['nk_account_id'] }}"
      dashboard.symbol_desc_holding: "-NULL"
      language.lang_pref: "{{ _user_attributes['locale'] }}"
    sorts: [dashboard.symbol_desc_holding,dim_prodct_hld.prodct_symbl, dim_prodct_hld.prodct_desc]
    subtotals: [dashboard.symbol_desc_holding]
    limit: 500
    column_limit: 50
    auto_size_all_columns: true
    show_view_names: false
    show_row_numbers: false
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [dashboard.symbol_desc_holding, dashboard.account_transaction, dashboard.quantity_holdings_consolidated,
      dashboard.market_price_holdings_consolidated, dashboard.aua_converted_to_cad]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    size_to_fit: true
    series_cell_visualizations:
      dashboard.quantity_holdings_consolidated:
        is_active: false
    series_text_format:
      dashboard.market_price_holdings_consolidated:
        align: right
        fg_color: "#525870"
      dashboard.aua_converted_to_cad:
        fg_color: "#525870"
        align: right
      dashboard.quantity_holdings_consolidated:
        fg_color: "#525870"
      dashboard.symbol_desc_holding:
        fg_color: "#525870"
      dashboard.market_value_holdings_consolidated:
        fg_color: "#525870"
      dashboard.account_transaction:
        fg_color: "#525870"
    series_collapsed:
      dashboard.symbol_desc_holding: true
      dashboard.account_transaction: true
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    truncate_column_names: true
    defaults_version: 1
    hidden_pivots: {}
    title_hidden: true
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 7