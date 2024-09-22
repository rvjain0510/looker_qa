- dashboard: piechart
  title: pie-chart
  layout: newspaper
  preferred_viewer: dashboards-next
  preferred_slug: W1N2FOXE0T1pBp514DLxxp
  embed_style:
    background_color: "#ffffff"
  elements:
    - title: ''
      name: ''
      model: ax360_portal
      explore: access_portal_dashboard
      type: looker_pie
      fields: [fact_allctn_holdng.allocation_aua, fact_allctn_holdng.allocation_code,
        fact_allctn_holdng.allocation_name, fact_allctn_holdng.lang_cd, allocationcodedim,
        allocationnamedim, fact_allctn_holdng.allocation_aua_pct]
      filters:
        fact_allctn_holdng.allocation_code_msr: "CU,EQ,FI,OT"
        dim_accnt.nk_hk_dim_accnt: "{{ _user_attributes['nk_account_id'] }}"
      sorts: [allocationcodesort]
      limit: 500
      column_limit: 50
      dynamic_fields:
      - category: table_calculation
        expression: case(when(${allocationcodedim}="CU",running_total(${fact_allctn_holdng.allocation_aua})),${fact_allctn_holdng.allocation_aua})
        label: Total Market Value (CAD$)
        value_format:
        value_format_name: usd
        _kind_hint: measure
        table_calculation: totalallocationaua
        _type_hint: number
      - category: table_calculation
        expression: case(when(${fact_allctn_holdng.allocation_code} != "CASH",yes), no)
        label: DisplayFlag
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: displayflag
        _type_hint: yesno
      - category: table_calculation
        expression: "(${totalallocationaua} / sum(${fact_allctn_holdng.allocation_aua}))"
        label: Total Market Value (CAD$)
        value_format:
        value_format_name: percent_2
        _kind_hint: measure
        table_calculation: percent_of_totalallocationaua
        _type_hint: number
      - category: dimension
        expression: case(when(${fact_allctn_holdng.allocation_code}="CASH","CU"),${fact_allctn_holdng.allocation_code})
        label: AllocationCodeDim
        value_format:
        value_format_name:
        dimension: allocationcodedim
        _kind_hint: dimension
        _type_hint: string
      - category: dimension
        expression: case(when(${fact_allctn_holdng.allocation_code}="CASH",case(when(${fact_allctn_holdng.lang_cd}="en","Cash and Equivalents"),"Encaisse et quasi-espèces")),${fact_allctn_holdng.allocation_name})
        label: AllocationNameDim
        value_format:
        value_format_name:
        dimension: allocationnamedim
        _kind_hint: dimension
        _type_hint: string
      - category: table_calculation
        expression: |+
          case(when(${fact_allctn_holdng.allocation_code} = "CU", 1),
          case(when(${fact_allctn_holdng.allocation_code} = "FI", 2),
          case(when(${fact_allctn_holdng.allocation_code} = "EQ", 3),
          case(when(${fact_allctn_holdng.allocation_code} = "OT", 4),
          0))))
        label: AllocationCodeSort
        value_format:
        value_format_name:
        _kind_hint: dimension
        table_calculation: allocationcodesort
        _type_hint: number
      value_labels: legend
      label_type: labPer
      inner_radius: 60
      series_colors:
        Cash and Equivalents: "#003DA5"
        Equity and Equities Funds: "#C78500"
        Alternative and Other Assets: "#862968"
        Fixed Income Securities and Fixed Income Funds: "#007762"
        Alternatives and Other Assets: "#862968"
        Cash and Cash Equivalent: "#092E6F"
        Equities and Equity Funds: "#C78500"
        Alternatifs et autres actifs: "#862968"
        Encaisse et quasi-espèces: "#092E6F"
        Titres à revenu fixe et fonds à revenu fixe: "#007762"
        Titres de participation et fonds d'actions: "#C78500"
      advanced_vis_config: |-
        {
          chart: {
            backgroundColor: 'rgba(255, 255, 255, 1)'
          }
        }
      x_axis_gridlines: false
      y_axis_gridlines: true
      show_view_names: false
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
      defaults_version: 1
      hidden_pivots: {}
      hidden_points_if_no: [displayflag]
      hidden_fields: [fact_allctn_holdng.allocation_code, fact_allctn_holdng.allocation_name,
        fact_allctn_holdng.lang_cd, allocationcodedim, fact_allctn_holdng.allocation_aua,
        fact_allctn_holdng.allocation_aua_pct, allocationcodesort, percent_of_totalallocationaua]
      title_hidden: true
      listen: {}
      row: 0
      col: 0
      width: 24
      height: 7