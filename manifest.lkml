project_name: "ax360_portal"
new_lookml_runtime: yes
# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }

# @bq_project_id@dv_dataset_name
localization_settings: {
  default_locale: en
  default_locale: fr_FR
  localization_level: permissive
}
constant: bq_connection_name {
  value: "iapw-dm-d-qa1-datahub-connection"
  #value: "prj-d-ax360-datahub"
}

constant: bq_project_id {
  value: "iapw-dm-d-qa1-datahub-1000"
}

constant: bq_dataset_name {
  value: "business_vault_looker"
}

constant: bq_dataset_business_vault {
  value: "business_vault_looker"
}
constant: ods_dataset_name {
  value: "ods"
}

constant: ods_dataset_portal {
  value: "ods_portal"
}

constant: dv_dataset_name {
  value: "data_vault"
}

constant: control_dataset_name {
  value: "control_portal"
}
#Note added to check if it removes the error
constant: icon_source_url {
  value: "https://iapw-acf-a-uat1-ax360-1000.web.app/looker-icons"
}

# Used By data Navigator Only : BEGIN
constant: dn_client_info_link {
  value: "https://iapw.cloud.looker.com/dashboards/239"
}

# Used By data Navigator Only : END
constant: value_format_liquid_currency {

  value: "{% if value >=1000000000 %}

  ${{ value | divided_by: 1000000000 | round: 0 | times: 1 }} B

  {% elsif value <=-1000000000 %}

  -${{ value | divided_by: 1000000000 | round: 0 | times: -1 }} B

  {% elsif value >=1000000 %}

  ${{ value | divided_by: 1000000 | round: 0 | times: 1 }} M

  {% elsif value <=-1000000 %}

  -${{ value | divided_by: 1000000 | round: 0 | times: -1 }} M

  {% elsif value <=-1000 %}

  -${{ value | divided_by: 1000 | round: 0 | times: -1 }} K

  {% elsif value >=1000 %}

  ${{ value | divided_by: 1000 | round: 0 | times: 1 }} K

  {% elsif value <0 %}

  -${{ value | divided_by: 1 | times: -1 | round: 0}}

  {% elsif value >0 %}

  ${{ value | divided_by: 1 | round: 0 | times: 1 }}

  {% elsif value >= 0 %}

  {{ rendered_value }}

  {% endif %}"

}
