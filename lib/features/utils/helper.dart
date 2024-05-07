class FixtureUtil {
  static String json = '''
{
  "rateOfInterest": {
    "textColor": "#000000",
    "textSize": 16,
    "labelText": "Rate of Interest",
    "values": {
      "1": "1%",
      "2": "2%",
      "3": "3%",
      "4": "4%",
      "5": "5%",
      "6": "6%",
      "7": "7%",
      "8": "8%",
      "9": "9%",
      "10": "10%",
      "11": "11%",
      "12": "12%",
      "13": "13%",
      "14": "14%",
      "15": "15%"
    }
  },
  "principalAmount": {
    "hintText": "Enter principal amount",
    "textColor": "#000000",
    "textSize": 16,
    "minAmount": {
      "1": 10000,
      "2": 10000,
      "3": 10000,
      "4": 50000,
      "5": 50000,
      "6": 50000,
      "7": 50000,
      "8": 75000,
      "9": 75000,
      "10": 75000,
      "11": 75000,
      "12": 100000,
      "13": 100000,
      "14": 100000,
      "15": 100000
    },
    "maxAmount": 10000000,
    "errorMessage": "Principal amount must be between {minAmount} and {maxAmount}"
  },
  "timesToCompound": {
    "labelText": "No. of Times to Compound in a Year",
    "textColor": "#000000",
    "textSize": 16,
    "values": {
      "1": "1",
      "2": "2",
      "4": "4"
    }
  },
  "numberOfYears": {
    "labelText": "No. of Years",
    "textColor": "#000000",
    "textSize": 16,
    "values": {
      "1": "1",
      "2": "2",
      "3": "3",
      "4": "4",
      "5": "5",
      "6": "6",
      "7": "7",
      "8": "8",
      "9": "9",
      "10": "10",
      "11": "11",
      "12": "12",
      "13": "13",
      "14": "14",
      "15": "15",
      "16": "16",
      "17": "17",
      "18": "18",
      "19": "19",
      "20": "20",
      "21": "21",
      "22": "22",
      "23": "23",
      "24": "24",
      "25": "25",
      "26": "26",
      "27": "27",
      "28": "28",
      "29": "29",
      "30": "30"
    }
  },
  "outputValue": {
    "textColor": "#000000",
    "labelText": "Output Value",
    "textSize": 16,
    "modeOfDisplay": "text-field"
  }
}

 ''';
}
