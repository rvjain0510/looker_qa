- dashboard: transactions
  title: Transactions
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: XlcuBbxRAAgtCG94iZayz8
  elements:
  - title: Transactions
    name: Transactions
    model: ax360_portal
    explore: access_portal_dashboard
    type: looker_grid
    fields: [dashboard.settlmnt_dt_date, dashboard.trad_dt_date, dashboard.process_date,
      dashboard.account_transaction, dashboard.symbol_desc_transactions, dashboard.transaction_descr,
      dashboard.transctn_quantt, dashboard.transctn_pric_str, dashboard.transaction_amount, fact_transctn_rr.transaction_id]
    filters:
      dim_accnt.nk_hk_dim_accnt: "{{ _user_attributes['nk_account_id'] }}"
      dashboard.transaction_descr: ''
      language.lang_pref: "{{ _user_attributes['locale'] }}"
    sorts: [dashboard.settlmnt_dt_date desc]
    limit: 5000
    column_limit: 50
    auto_size_all_columns: true
    auto_size_all_rows: true
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
    color_application:
      collection_id: qphi
      palette_id: qphi-categorical-0
    show_sql_query_menu_options: false
    column_order: [dashboard.settlmnt_dt_date, dashboard.trad_dt_date, dashboard.process_date,
      dashboard.account_transaction, dashboard.symbol_desc_transactions, dashboard.transaction_descr,
      dashboard.transctn_quantt, dashboard.transctn_pric_str, dashboard.transaction_amount]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    size_to_fit: true
    header_font_color: "#000548"
    header_background_color: "#EDEFF8"
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#003DA5",
        font_color: !!null '', color_application: {collection_id: qphi, palette_id: qphi-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_cell_visualizations:
      dashboard.transctn_quantt: false
    series_text_format:
      dashboard.settlmnt_dt_date:
        fg_color: "#525870"
      dashboard.account_transaction:
        fg_color: "#525870"
      dashboard.trad_dt_date:
        fg_color: "#525870"
      dashboard.process_date:
        fg_color: "#525870"
      dashboard.symbol_desc_transactions:
        fg_color: "#525870"
      dashboard.transaction_descr:
        fg_color: "#525870"
      dashboard.transctn_quantt:
        fg_color: "#525870"
      dashboard.transctn_pric_str:
        fg_color: "#525870"
        align: right
      dashboard.transaction_amount:
        fg_color: "#525870"
    defaults_version: 1
    hidden_fields: [fact_transctn_rr.transaction_id]
    title_hidden: true
    listen:
      Quantity: dashboard.transctn_quantt
      Process Date: dashboard.process_date
      Trade Date: dashboard.trad_dt_date
      Amount ($): dashboard.transaction_amount
      Price ($): dashboard.transctn_pric
      Product: dim_prodct_tran.prodct_tp_name
      Settlement Date: dashboard.settlmnt_dt_date
      Transaction Type: dim_transctn_cd.operation_type_descr
      Symbol & Description: dashboard.symbol_desc_transactions
      Currency: fact_transctn_rr.transctn_currnc
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Settlement Date
    title: Settlement Date
    type: field_filter
    default_value: 30 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.settlmnt_dt_date
  - name: Trade Date
    title: Trade Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.trad_dt_date
  - name: Process Date
    title: Process Date
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.process_date
  - name: Symbol & Description
    title: Symbol & Description
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
    field: dashboard.symbol_desc_transactions
  - name: Transaction Type
    title: Transaction Type
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_transctn_cd.operation_type_descr
  - name: Quantity
    title: Quantity
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.transctn_quantt
  - name: Price ($)
    title: Price ($)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.transctn_pric
  - name: Amount ($)
    title: Amount ($)
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dashboard.transaction_amount
  - name: Product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: dim_prodct_tran.prodct_tp_name
  - name: Currency
    title: Currency
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: checkboxes
      display: popover
    model: ax360_portal
    explore: access_portal_dashboard
    listens_to_filters: []
    field: fact_transctn_rr.transctn_currnc