constant: CONNECTION_NAME {
  value: "sap-iac-test-cortex-bq-conn"
  export: override_required
}

constant: GCP_PROJECT {
  value: "sap-iac-test"
  export: override_required
}

constant: REPORTING_DATASET {
  value: "GS4_REPORTING"
  export: override_required
}

constant: CLIENT {
  value: "600"
  export: override_required
}

# Revenue is generally displayed in general ledger as a negative number, which indicates a credit.
# By setting Sign Change value to 'yes', it's displayed as a positive number in income statement reports.
constant: SIGN_CHANGE {
  value: "yes"
  export: override_required
}

#

#############################
# Additional Constants used for formatting and other logic
#{

# to show negative values in red, at this constant to the html: parameter
# For example:
#         measure: profit {
#            type: number
#            sql: ${total_sales} - ${total_cost} ;;
#            html: @{negative_format} ;;
#         }

constant: negative_format {
  value: "{% if value < 0 %}<p style='color:red;'>{{rendered_value}}</p>{% else %} {{rendered_value}} {% endif %}"
}

constant: sign_change_multiplier {
  value: "{% assign choice = '@{SIGN_CHANGE}' | downcase %}
  {% if choice == 'yes' %}{% assign multiplier = -1 %}{% else %}{% assign multiplier = 1 %}{% endif %}"
}



#} end additional constants

application: explore_assistant {
  label: "Explore Assistant_v6"
  url: "https://localhost:8080/bundle.js"
  # file: "bundle.js"
  entitlements: {
    core_api_methods: ["lookml_model_explore","create_sql_query","run_sql_query","run_query","create_query"]
    navigation: yes
    use_embeds: yes
    use_iframes: yes
    new_window: yes
    new_window_external_urls: ["https://developers.generativeai.google/*"]
    local_storage: yes
    external_api_urls: ["https://us-central1-sap-iac-test.cloudfunctions.net/explore-assistant-api"]
  }
}
