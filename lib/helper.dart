
class FixtureUtil {
  static String json = ''' {
  "fields": [
    {
      "name": "rate_of_interest",
      "type": "dropdown",
      "label": "Rate of Interest (%)",
      "textColor": "#000000",
      "textSize": 16,
      "values": [
        {"value": 1, "label": "1%"},
        {"value": 2, "label": "2%"},
        {"value": 3, "label": "3%"},
        {"value": 4, "label": "4%"},
        {"value": 5, "label": "5%"},
        {"value": 6, "label": "6%"},
        {"value": 7, "label": "7%"},
        {"value": 8, "label": "8%"},
        {"value": 9, "label": "9%"},
        {"value": 10, "label": "10%"},
        {"value": 11, "label": "11%"},
        {"value": 12, "label": "12%"},
        {"value": 13, "label": "13%"},
        {"value": 14, "label": "14%"},
        {"value": 15, "label": "15%"}
      ]
    },
    {
      "name": "principal_amount",
      "type": "text",
      "label": "Principal Amount",
      "hintText": "Enter principal amount",
      "textColor": "#000000",
      "textSize": 16,
      "minAmount": {
        "1-3": 10000,
        "4-7": 50000,
        "8-12": 75000,
        "default": 100000
      },
      "maxAmount": 10000000,
      "errorMessage": {
        "min": "Minimum amount should be",
        "max": "Maximum amount should be"
      }
    },
    {
      "name": "compound_frequency",
      "type": "dropdown",
      "label": "No. of times compounded per year",
      "textColor": "#000000",
      "textSize": 16,
      "values": [ {"value": 12, "label": "1"},{"value": 6, "label": "2"},{"value": 3, "label": "4"}]
    },
    {
      "name": "number_of_years",
      "type": "dropdown",
      "label": "No. of Years",
      "textColor": "#000000",
      "textSize": 16,
      "validators": {
        "1": {"min": 1, "max": 10},
        "2": {"min": 1, "max": 20},
        "4": {"min": 1, "max": 30}
      }
     
    },
    {
      "name": "display",
      "type":"multi",
      "textColor": "#000000",
      "textSize": 16,
      "label": "Output Widget",
      "modeOfDisplay": "snackbar"
    }
  ]
}''';
}
