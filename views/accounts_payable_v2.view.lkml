view: accounts_payable_v2 {
  sql_table_name: `@{GCP_PROJECT}.@{REPORTING_DATASET}.AccountsPayable`
    ;;

  parameter: Aging_Interval {
    type: number
    default_value: "30"
    hidden: no
  }

  dimension: key {
    type: string
    primary_key: yes
    hidden: yes
    sql: CONCAT(${client_mandt},${accounting_document_number_belnr},${number_of_line_item_within_accounting_document_buzei},${company_code_bukrs},${target_currency_tcurr});;
  }

  dimension: account_number_of_vendor_or_creditor_lifnr {
    label: "Vendor Account Number"
    description: "This is the account number of the vendor or creditor."
    type: string
    sql: ${TABLE}.AccountNumberOfVendorOrCreditor_LIFNR ;;
  }

  dimension: account_type_koart {
    label: "Account Type"
    description: "This is the account type."
    type: string
    sql: ${TABLE}.AccountType_KOART ;;
  }

  dimension: accounting_document_number_belnr {
    label: "Accounting Document Number"
    description: "This is the accounting document number."
    type: string
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }

  dimension: accounting_documenttype_blart {
    label: "Accounting Document Type"
    description: "This is the accounting document type."
    type: string
    sql: ${TABLE}.AccountingDocumenttype_BLART ;;
  }

  dimension: amount_in_local_currency_dmbtr {
    group_label: "Local Currency"
    label: "Amount In Local Currency"
    description: "This is the value or amount of the transaction in the local currency."
    type: number
    sql: ${TABLE}.AmountInLocalCurrency_DMBTR * -1;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_amount_in_local_currency_dmbtr {
    group_label: "Local Currency"
    label: "Total Amount In Local Currency"
    description: "This is the total value or total amount across one or more accounting documents. It is the sum of the Amount In Local Currency."
    type: sum
    sql: ${amount_in_local_currency_dmbtr} ;;
    value_format_name: Greek_Number_Format
    drill_fields: [std_drill*]
  }

  measure: average_amount_in_local_currency_dmbtr {
    group_label: "Local Currency"
    label: "Average Amount In Local Currency"
    description: "This is the average value or average amount across one or more accounting documents. It is the average of the Amount In Local Currency."
    type: average
    sql: ${amount_in_local_currency_dmbtr} ;;
    value_format_name: Greek_Number_Format
  }

  dimension: amount_in_target_currency_dmbtr {
    group_label: "Target Currency"
    label: "Amount In Target Currency"
    description: "This is the value or amount of the transaction in the target currency."
    type: number
    hidden: no
    sql: ${TABLE}.AmountInTargetCurrency_DMBTR * -1 ;;
  }

  measure: total_amount_in_target_currency_dmbtr {
    group_label: "Target Currency"
    label: "Total Amount In Target Currency"
    description: "This is the total value or total amount across one or more accounting documents. It is the sum of the Amount In Target Currency."
    type: sum
    sql: ${amount_in_local_currency_dmbtr} ;;
    value_format_name: Greek_Number_Format
    drill_fields: [std_drill*]
  }

  dimension: amount_of_open_debit_items_in_source_currency {
    group_label: "Source Currency"
    label: "Amount Of Open Debit Items In Source Currency"
    description: "This is a monetary amount associated with open debit items in source currency."
    type: number
    sql: ${TABLE}.AmountOfOpenDebitItemsInSourceCurrency ;;
  }

  dimension: amount_of_open_debit_items_in_target_currency {
    group_label: "Target Currency"
    label: "Open Debit Item Amount In Target Currency"
    description: "This is a monetary amount associated with open debit items in target currency."
    type: number
    sql: ${TABLE}.AmountOfOpenDebitItemsInTargetCurrency ;;
  }

  dimension: amount_of_return_in_source_currency {
    group_label: "Source Currency"
    label: "Amount Of Return In Source Currency"
    description: "This is a monetary amount of returned goods or services in source currency."
    type: number
    sql: ${TABLE}.AmountOfReturnInSourceCurrency ;;
  }

  dimension: amount_of_return_in_target_currency {
    group_label: "Target Currency"
    label: "Amount Of Return In Target Currency"
    description: "This is a monetary amount of returned goods or services in target currency."
    type: number
    sql: ${TABLE}.AmountOfReturnInTargetCurrency ;;
  }

  dimension: cash_discount_received_in_source_currency {
    group_label: "Source Currency"
    label: "Cash Discount Received In Source Currency"
    description: "This is a cash discount received in the source currency."
    type: number
    sql: ${TABLE}.CashDiscountReceivedInSourceCurrency ;;
  }

  dimension: cash_discount_received_in_target_currency {
    group_label: "Target Currency"
    label: "Cash Discount Received In Target Currency"
    description: "This is a cash discount received in the target currency."
    type: number
    sql: ${TABLE}.CashDiscountReceivedInTargetCurrency ;;
  }




  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: clearing_date_augdt {
    label: "Clearing"
    description: "This is the clearing date of the transaction. "
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.ClearingDate_AUGDT ;;
  }

  dimension: client_mandt {
    label: "Client"
    description: "This is the client number." #?
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: company_code_bukrs {
    label: "Company Code"
    type: string
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }

  dimension: company_text_butxt {
    label: "Company Text"
    type: string
    sql: ${TABLE}.CompanyText_BUTXT ;;
  }

  dimension: currency_key_waers {
    label: "Currency Key"
    type: string
    sql: ${TABLE}.CurrencyKey_WAERS ;;
  }

  dimension: doc_fisc_period {
    label: "Document Fiscal Period"
    type: string
    sql: ${TABLE}.DocFiscPeriod ;;
  }

  dimension: document_number_of_the_clearing_document_augbl {
    label: "Document Number Of Clearing Document"
    type: string
    sql: ${TABLE}.DocumentNumberOfTheClearingDocument_AUGBL ;;
  }

  dimension: exchange_rate_ukurs {
    label: "Exchange Rate"
    type: number
    sql: ${TABLE}.ExchangeRate_UKURS ;;
  }

  dimension: fiscal_period_monat {
    label: "Fiscal Period"
    type: string
    sql: ${TABLE}.FiscalPeriod_MONAT ;;
  }

  dimension: fiscal_year_gjahr {
    label: "Fiscal Year"
    type: string
    sql: ${TABLE}.FiscalYear_GJAHR ;;
  }

  dimension: inv_status_rbstat {
    label: "Invoice Status"
    type: string
    sql: ${TABLE}.InvStatus_RBSTAT ;;
  }

  dimension: invoice_documenttype_blart {
    label: "Invoice Document Type"
    type: string
    sql: ${TABLE}.InvoiceDocumenttype_BLART ;;
  }

  dimension: is_blocked_invoice {
    description: "This is an indicator to say that the invoice is blocked. It has values of Yes or No"
    type: yesno
    sql: ${TABLE}.IsBlockedInvoice ;;
  }

  measure: blocked_invoice {
    group_label: "Counts"
    label: "Count Of Blocked Invoices"
    description: "This is a count of invoices that are blocked."
    type: count
    filters: [is_blocked_invoice: "Yes"]
    hidden: no
  }

  measure: blocked_invoice_amount {
    group_label: "Local Currency"
    label: "Blocked Invoice Amount In Local Currency"
    description: "This is the sum total monetary amount of invoices that are blocked in local currency"
    type: sum
    filters: [is_blocked_invoice: "Yes"]
    sql: ${amount_in_local_currency_dmbtr} ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }


  measure: blocked_invoice_amount_global_currency {
    group_label: "Target Currency"
    label: "Blocked Invoice Amount In Target Currency"
    description: "This is the sum total monetary amount of invoices that are blocked in target currency"
    type: sum
    filters: [is_blocked_invoice: "Yes"]
    sql: ${amount_in_target_currency_dmbtr};;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  dimension: is_parked_invoice {
    description: "Indicates if the invoice is parked. Values are Yes or No"
    type: yesno
    sql: ${TABLE}.IsParkedInvoice ;;
  }

  measure: parked_invoice {
    group_label: "Counts"
    label: "Count Of Parked Invoices"
    description: "This is a count of invoices that are parked."
    type: count
    filters: [is_parked_invoice: "Yes"]
    hidden: no
  }

  measure: parked_invoice_amount {
    group_label: "Local Currency"
    label: "Total Amount Of Parked Invoices In Local Currency"
    description: "The sum total monetary amount of parked invoices in local currency."
    type: sum
    filters: [is_parked_invoice: "Yes"]
    sql: ${TABLE}.AmountInLocalCurrency_DMBTR ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure: parked_invoice_amount_global_currency {
    group_label: "Target Currency"
    label: "Total Amount Of Parked Invoices In Target Currency"
    description: "The sum total monetary amount of parked invoices in target currency."
    type: sum
    filters: [is_parked_invoice: "Yes"]
    sql: ${TABLE}.AmountInTargetCurrency_DMBTR ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  dimension: key_fisc_period {
    label: "Key Fiscal Period"
    type: string
    sql: ${TABLE}.KeyFiscPeriod ;;
  }

  dimension: late_payments_in_source_currency {
    group_label: "Source Currency"
    label: "Late Payments In Source Currency"
    type: number
    sql: ${TABLE}.LatePaymentsInSourceCurrency ;;
  }

  dimension: late_payments_in_target_currency {
    group_label: "Target Currency"
    label: "Late Payments In Target Currency"
    type: number
    sql: ${TABLE}.LatePaymentsInTargetCurrency * -1 ;;
  }

  measure: sum_late_payments_in_target_currency {
    group_label: "Target Currency"
    label: "Total Late Payments In Target Currency"
    type: sum
    sql: ${late_payments_in_target_currency}  ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  dimension: month_of_posting_date_in_the_document_budat {
    label: "Month Of Posting Date In Document"
    type: number
    sql: ${TABLE}.MonthOfPostingDateInTheDocument_BUDAT ;;
  }

  dimension: movement_type__inventory_management___bwart {
    label: "Movement Type Inventory Management"
    type: string
    sql: ${TABLE}.MovementType__inventoryManagement___BWART ;;
  }

  dimension: name1 {
    label: "Vendor Name"
    type: string
    sql: ${TABLE}.NAME1 ;;
    hidden: no

  }

  dimension: is_null_name1 {
    label: "Is Null Name"
    type: yesno
    sql: ${TABLE}.NAME1 IS NULL ;;
    hidden: no
  }

  dimension_group: net_due {
    description: "This is the net due date for the invoice."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.NetDueDate ;;
  }

  dimension: number_of_line_item_within_accounting_document_buzei {
    description: "Number Of Line Item Within Accounting Document"
    type: string
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }

  dimension: accounting_document_and_line_number {
    description: "Document And Line Number"
    type: string
    sql: ${accounting_document_number_belnr} || '-' || ${number_of_line_item_within_accounting_document_buzei} ;;
    action: {
      label: "Investigate This Item"
      url: "https://us-central1-bhabani-demo.cloudfunctions.net/looker_action_comments_function"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Please Investigate {{ value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Hi,

          Would you please look into document {{ accounting_document_number_belnr._value }}, line number {{ number_of_line_item_within_accounting_document_buzei._value }}
          "
      }
    }
  }

  dimension: outstanding_but_not_overdue_in_source_currency {
    group_label: "Source Currency"
    description: "Outstanding But Not Overdue In Source Currency"
    type: number
    sql: ${TABLE}.OutstandingButNotOverdueInSourceCurrency * -1 ;;
    value_format_name: Greek_Number_Format
  }

  dimension: outstanding_but_not_overdue_in_target_currency {
    group_label: "Target Currency"
    description: "Outstanding But Not Overdue In Target Currency"
    type: number
    sql: ${TABLE}.OutstandingButNotOverdueInTargetCurrency * -1;;
    value_format_name: Greek_Number_Format
  }

  dimension: overdue_amount_in_source_currency {
    group_label: "Source Currency"
    description: "Overdue Amount In Source Currency"
    type: number
    sql: ${TABLE}.OverdueAmountInSourceCurrency * -1 ;;
    value_format_name: Greek_Number_Format
  }

  dimension: overdue_amount_in_target_currency {
    group_label: "Target Currency"
    description: "Overdue Amount In Target Currency"
    type: number
    sql: ${TABLE}.OverdueAmountInTargetCurrency * -1 ;;
    value_format_name: Greek_Number_Format
  }


  measure: sum_overdue_amount {
    group_label: "Target Currency"
    description: "Total Overdue Amount In Target Currency"
    type: sum
    sql: ${overdue_amount_in_target_currency} ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  dimension: Past_Due_Interval{
    label: "Past Due Interval"
    type: string
    hidden: no
    sql: if((date_diff(cast(current_date() as Date),${TABLE}.NetDueDate, DAY)>0 and date_diff(cast(current_date() as Date),${TABLE}.NetDueDate, DAY)<({% parameter Aging_Interval %}+1)),concat('b1- ',({% parameter Aging_Interval %}),' Days'),
        (if((date_diff(cast(current_date() as Date),${TABLE}.NetDueDate, DAY)<(({% parameter Aging_Interval %}*2)+1)),concat('c31-',({% parameter Aging_Interval %}*2),' Days'),
        (if((date_diff(cast(current_date() as Date),${TABLE}.NetDueDate, DAY)<(({% parameter Aging_Interval %}*3)+1)),concat('d61-',({% parameter Aging_Interval %}*3),' Days'),
        (if((date_diff(cast(current_date() as Date),${TABLE}.NetDueDate, DAY)>(({% parameter Aging_Interval %}*3)+1)),concat('e> ',({% parameter Aging_Interval %}*3),' Days'),'aNot OverDue' )) )) )) ) ;;
  }

  dimension:  past_overdue_1_to_30day{
    group_label: "Target Currency"
    label: "Past Overdue 1 to 30 Days In Target Currency"
    type: number
    sql: if(${Past_Due_Interval}='b1- 30 Days',(${overdue_on_past_date_in_target_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }

  dimension:  source_past_overdue_1_to_30day{
    group_label: "Source Currency"
    label: "Past Overdue 1 to 30 Days In Source Currency"
    type: number
    sql: if(${Past_Due_Interval}='b1- 30 Days',(${overdue_on_past_date_in_source_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }


  dimension:  past_overdue_31_to_60day{
    group_label: "Target Currency"
    label: "Past Overdue 31 to 60 Days In Target Currency"
    type: number
    sql: if(${Past_Due_Interval}='c31-60 Days',(${overdue_on_past_date_in_target_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }

  dimension:  source_past_overdue_31_to_60day{
    group_label: "Source Currency"
    label: "Past Overdue 31 to 60 Days In Source Currency"
    type: number
    sql: if(${Past_Due_Interval}='c31-60 Days',(${overdue_on_past_date_in_source_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }


  dimension:  past_overdue_61_to_90day{
    group_label: "Target Currency"
    label: "Past Overdue 61 to 90 Days In Target Currency"
    type: number
    sql: if(${Past_Due_Interval}='d61-90 Days',(${overdue_on_past_date_in_target_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }

  dimension:  source_past_overdue_61_to_90day{
    group_label: "Source Currency"
    label: "Past Overdue 61 to 90 Days In Source Currency"
    type: number
    sql: if(${Past_Due_Interval}='d61-90 Days',(${overdue_on_past_date_in_source_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }


  dimension:  past_overdue_greater_than_90day{
    group_label: "Target Currency"
    label: "Past Overdue Greater Than 90 Days In Target Currency"
    type: number
    sql: if(${Past_Due_Interval}='e> 90 Days',(${overdue_on_past_date_in_target_currency}),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }


  dimension:  source_past_overdue_greater_than_90day{
    group_label: "Source Currency"
    label: "Past Overdue Greater Than 90 Days In Source Currency"
    type: number
    sql: if(${Past_Due_Interval}='e> 90 Days',(${overdue_on_past_date_in_source_currency} ),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }




  dimension:  past_overdue_but_not_overdue{
    group_label: "Target Currency"
    label: "Past Overdue But Not Overdue In Target Currency"
    type: number
    sql: if(${Past_Due_Interval}='aNot OverDue',(${outstanding_but_not_overdue_in_target_currency}),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }

  dimension:  source_past_overdue_but_not_overdue{
    group_label: "Source Currency"
    label: "Past Overdue But Not Overdue In Source Currency"
    type: number
    sql: if(${Past_Due_Interval}='aNot OverDue',(${outstanding_but_not_overdue_in_source_currency}),0) ;;
    hidden: no
    value_format_name: Greek_Number_Format
  }

  measure:  sum_past_overdue_1_to_30days{
    group_label: "Target Currency"
    label: "Sum Past Overdue 1 to 30 Days In Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "b1- 30 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure:  sum_past_overdue_1_to_30days_conv_drill{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "b1- 30 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    link: {
      label: "Accounts Payable Aging"
      url: "/dashboards/cortex_sap_operational_v6::sap_finance_ap_07_a_accounts_payable_aging?Target+Currency={{ _filters['accounts_payable_v2.target_currency_tcurr']| url_encode }}&Vendor+Name={{ _filters['accounts_payable_v2.name1']| url_encode }}&Company+Name={{ _filters['accounts_payable_v2.company_text_butxt']| url_encode }}"
    }
  }

  measure:  sum_past_overdue_31_to_60days{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "c31-60 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure:  sum_past_overdue_31_to_60days_conv_drill{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "c31-60 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    link: {
      label: "Accounts Payable Aging"
      url: "/dashboards/cortex_sap_operational_v6::sap_finance_ap_07_a_accounts_payable_aging?Target+Currency={{ _filters['accounts_payable_v2.target_currency_tcurr']| url_encode }}&Vendor+Name={{ _filters['accounts_payable_v2.name1']| url_encode }}&Company+Name={{ _filters['accounts_payable_v2.company_text_butxt']| url_encode }}"
    }
  }

  measure:  sum_past_overdue_61_to_90days{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "d61-90 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    drill_fields: [std_drill*]
  }

  measure:  sum_past_overdue_61_to_90days_conv_drill{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "d61-90 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    link: {
      label: "Accounts Payable Aging"
      url: "/dashboards/cortex_sap_operational_v6::sap_finance_ap_07_a_accounts_payable_aging?Target+Currency={{ _filters['accounts_payable_v2.target_currency_tcurr']| url_encode }}&Vendor+Name={{ _filters['accounts_payable_v2.name1']| url_encode }}&Company+Name={{ _filters['accounts_payable_v2.company_text_butxt']| url_encode }}"
    }
    drill_fields: [std_drill*]
  }

  measure:  sum_past_overdue_greater_than_90days{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "e> 90 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    drill_fields: [std_drill*]
  }

  measure:  sum_past_overdue_greater_than_90days_conv_drill{
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    filters: [Past_Due_Interval: "e> 90 Days"]
    value_format_name: Greek_Number_Format
    hidden: no
    link: {
      label: "Accounts Payable Aging"
      url: "/dashboards/cortex_sap_operational_v6::sap_finance_ap_07_a_accounts_payable_aging?Target+Currency={{ _filters['accounts_payable_v2.target_currency_tcurr']| url_encode }}&Vendor+Name={{ _filters['accounts_payable_v2.name1']| url_encode }}&Company+Name={{ _filters['accounts_payable_v2.company_text_butxt']| url_encode }}"
    }
    drill_fields: [std_drill*]
  }

  measure:  sum_past_overdue_not_overdue{
    group_label: "Target Currency"
    type: sum
    sql: ${outstanding_but_not_overdue_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure:  sum_past_overdue_not_overdue_drill{
    group_label: "Target Currency"
    type: sum
    sql: ${outstanding_but_not_overdue_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
    link: {
      label: "Accounts Payable Aging"
      url: "/dashboards/cortex_sap_operational_v6::sap_finance_ap_07_a_accounts_payable_aging?Target+Currency={{ _filters['accounts_payable_v2.target_currency_tcurr']| url_encode }}&Vendor+Name={{ _filters['accounts_payable_v2.name1']| url_encode }}&Company+Name={{ _filters['accounts_payable_v2.company_text_butxt']| url_encode }}"
    }
  }


  measure: total_due  {
    group_label: "Target Currency"
    label: "Total Due In Target Currency"
    description: "This is the total monetary amount due in the target currency. It is the sum of overdue on past date and outstanding but not overdue across all documents."
    type: sum
    sql: (${overdue_on_past_date_in_target_currency} + ${outstanding_but_not_overdue_in_target_currency});;
    value_format_name: Greek_Number_Format
    hidden: no
    drill_fields: [std_drill*]
  }

  # measure: total_due_local  {
  #   group_label: "Local Currency"
  #   label: "Total Due In Local Currency"
  #   description: "This is the total monetary amount due in the target currency. It is the sum of overdue on past date and outstanding but not overdue across all documents."
  #   type: sum
  #   sql: (${overdue_on_past_date_in_local_currency} + ${outstanding_but_not_overdue_in_local_currency});;
  #   value_format_name: Greek_Number_Format
  #   hidden: no
  #   drill_fields: [std_drill*]
  # }

  measure: sum_overdue_amount_conv_drill_1  {
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_amount_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure: sum_overdue_amount_conv_drill_2 {
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_amount_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure: sum_overdue_amount_conv_drill_3 {
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_amount_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
  }

  measure: sum_past_overdue_amount_conv_drill {
    group_label: "Target Currency"
    type: sum
    sql: ${overdue_on_past_date_in_target_currency} ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }


  measure: outstanding_but_not_overdue_1_conv_drill  {
    group_label: "Target Currency"
    type: sum
    sql: ${outstanding_but_not_overdue_in_target_currency};;
    value_format_name: Greek_Number_Format
    hidden: no
  }


  dimension: overdue_on_past_date_in_source_currency {
    type: number
    sql: ${TABLE}.OverdueOnPastDateInSourceCurrency ;;
  }

  dimension: overdue_on_past_date_in_target_currency {
    type: number
    sql: ${TABLE}.OverdueOnPastDateInTargetCurrency * -1 ;;
  }

  dimension: partial_payments_in_source_currency {
    group_label: "Source Currency"
    label: "Partial Payments In Source Currency"
    type: number
    sql: ${TABLE}.PartialPaymentsInSourceCurrency ;;
  }

  dimension: partial_payments_in_target_currency {
    group_label: "Target Currency"
    label: "Partial Payments In Target Currency"
    type: number
    sql: ${TABLE}.PartialPaymentsInTargetCurrency ;;
  }

  dimension: payment_block_key_zlspr {
    label: "Payment Block Key"
    type: string
    sql: ${TABLE}.PaymentBlockKey_ZLSPR ;;
  }

  dimension: poorder_history_amount_in_local_currency_dmbtr {
    group_label: "Local Currency"
    label: "PO Order History Amount In Local Currency"
    type: number
    sql: ${TABLE}.POOrderHistory_AmountInLocalCurrency_DMBTR ;;
  }

  dimension: poorder_history_amount_in_target_currency_dmbtr {
    group_label: "Target Currency"
    label: "PO Order History Amount In Target Currency"
    type: number
    sql: ${TABLE}.POOrderHistory_AmountInTargetCurrency_DMBTR ;;
  }

  dimension_group: posting_date_budat {
    label: "Posting"
    description: "This is the posting date."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PostingDate_BUDAT ;;
  }

  dimension_group: posting_date_in_the_document_budat {
    label: "Document Posting"
    description: "This is the posting date that is in the document."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PostingDateInTheDocument_BUDAT ;;
  }

  dimension: potential_penalty_in_source_currency {
    group_label: "Source Currency"
    label: "Potential Penalty In Source Currency"
    description: "This is the potential monetary penalty amount for a late invoice in source currency."
    type: number
    sql: ${TABLE}.PotentialPenaltyInSourceCurrency ;;
  }

  dimension: potential_penalty_in_target_currency {
    group_label: "Target Currency"
    label: "Potential Penalty In Target Currency"
    description: "This is the potential monetary penalty amount for a late invoice in target currency."
    type: number
    sql: ${TABLE}.PotentialPenaltyInTargetCurrency * -1;;
  }

  measure: sum_potential_penalty_in_target_currency {
    group_label: "Target Currency"
    label: "Sum Potential Penalty In Target Currency"
    description: "This is the sum total potential monetary penalty amount for late invoices in target currency."
    type: sum
    sql: ${potential_penalty_in_target_currency} ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }



  dimension: purchase_in_source_currency {
    group_label: "Source Currency"
    label: "Purchase In Source Currency"
    description: "This is the purchase amount in the source currency."
    type: number
    sql: ${TABLE}.PurchaseInSourceCurrency ;;
  }

  dimension: purchase_in_target_currency {
    group_label: "Target Currency"
    label: "Purchase In Target Currency"
    description: "This is the purchase amount in the target currency."
    type: number
    sql: ${TABLE}.PurchaseInTargetCurrency ;;
  }

  dimension: purchasing_document_number_ebeln {
    label: "Purchasing Document Number"
    type: string
    sql: ${TABLE}.PurchasingDocumentNumber_EBELN ;;
  }

  dimension: quarter_of_posting_date_in_the_document_budat {
    group_label: "Document Posting"
    label: "Quarter Of Posting Date In Document"
    description: "This is the numeric quarter of the posting date in the document. For example: the value would be 2 for second quarter, or 3 for third quarter."
    type: number
    sql: ${TABLE}.QuarterOfPostingDateInTheDocument_BUDAT ;;
  }

  dimension: reason_code_for_payments_rstgr {
    label: "Reasond Code For Payments"
    type: string
    sql: ${TABLE}.ReasonCodeForPayments_RSTGR ;;
  }

  dimension: supplying_country_landl {
    label: "Supplying Country"
    description: "This is the country name of the supplier."

    type: string
    sql: ${TABLE}.SupplyingCountry_LANDL ;;
  }

  dimension: target_cash_discount_in_source_currency {
    group_label: "Source Currency"
    label: "Target Cash Discount In Source Currency"
    description: "This is the cash discount in source currency."
    type: number
    sql: ${TABLE}.TargetCashDiscountInSourceCurrency ;;
  }

  dimension: target_cash_discount_in_target_currency {
    group_label: "Target Currency"
    label: "Target Cash Discount In Target Currency"
    description: "This is the cash discount in target currency."
    type: number
    sql: ${TABLE}.TargetCashDiscountInTargetCurrency ;;
  }

  dimension: target_currency_tcurr {
    group_label: "Target Currency"
    label: "Target Currency"
    description: "This is an abbreviated currency code. For example, USD for United Stated Dollars."
    type: string
    sql: ${TABLE}.TargetCurrency_TCURR ;;
  }

  dimension: terms_of_payment_key_zterm {
    label: "Terms Of Payment Key"
    description: "This terms of payment key. Typical values 4 character strings like 0001 and 0003."
    type: string
    sql: ${TABLE}.TermsOfPaymentKey_ZTERM ;;
  }

  dimension: upcoming_payments_in_source_currency {
    group_label: "Source Currency"
    label: "Upcoming Payments In Source Currency"
    description: "This is the value of upcoming payments in the source currency."
    type: number
    sql: ${TABLE}.UpcomingPaymentsInSourceCurrency ;;
  }

  dimension: upcoming_payments_in_target_currency {
    group_label: "Target Currency"
    label: "Upcoming Payments In Target Currency"
    description: "This is the value of upcoming payments in the target currency."
    type: number
    sql: ${TABLE}.UpcomingPaymentsInTargetCurrency * -1 ;;
  }


  measure: sum_upcoming_payments_in_target_currency {
    group_label: "Target Currency"
    label: "Sum Of Upcoming Payments In Target Currency"
    description: "This is the total, or sum of upcoming payments in the target currency. This is a sum aggregation across records."
    type: sum
    sql: ${upcoming_payments_in_target_currency} ;;
    value_format_name: Greek_Number_Format
    hidden: no
  }


  dimension: week_of_posting_date_in_the_document_budat {
    group_label: "Document Posting"
    label: "Week Of Posting Date In Document"
    description: "This is the numeric week of the posting date in the document. For example: 42."
    type: number
    sql: ${TABLE}.WeekOfPostingDateInTheDocument_BUDAT ;;
  }

  dimension: year_of_posting_date_in_the_document_budat {
    group_label: "Document Posting"
    label: "Year Of Posting Date In Document"
    description: "This is the numeric year of the posting date in the document. For example: 2024."
    type: number
    sql: ${TABLE}.YearOfPostingDateInTheDocument_BUDAT ;;
  }

  measure: count {
    label: "Count"
    group_label: "Counts"
    type: count
    drill_fields: [std_drill*]
  }

  measure: count_of_documents {
    label: "Count Of Documents"
    group_label: "Counts"
    type: count_distinct
    sql: ${accounting_document_number_belnr} ;;
    drill_fields: [std_drill*]
  }

  set: std_drill {
    fields: [
        accounting_document_and_line_number
      , name1
      , company_code_bukrs
      , amount_in_target_currency_dmbtr
      , target_currency_tcurr
    ]
  }
}

# amount_in_local_currency_dmbtr,
