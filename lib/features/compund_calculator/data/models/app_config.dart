import 'package:calculator/features/compund_calculator/data/models/number_of_years_field_config.dart';
import 'package:calculator/features/compund_calculator/data/models/output_value_config.dart';
import 'package:calculator/features/compund_calculator/data/models/principle_amount_field_config.dart';
import 'package:calculator/features/compund_calculator/data/models/rate_of_interest_config.dart';
import 'package:calculator/features/compund_calculator/data/models/time_to_compound_field_config.dart';

class AppConfig {
  final RateOfInterestFieldConfig rateOfInterestFieldConfig;
  final PrincipalAmountFieldConfig principalAmountFieldConfig;
  final TimesToCompoundFieldConfig timesToCompoundFieldConfig;
  final NumberOfYearsFieldConfig numberOfYearsFieldConfig;
  final OutputValueConfig outputValueConfig;

  AppConfig({
    required this.rateOfInterestFieldConfig,
    required this.principalAmountFieldConfig,
    required this.timesToCompoundFieldConfig,
    required this.numberOfYearsFieldConfig,
    required this.outputValueConfig,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      rateOfInterestFieldConfig:
          RateOfInterestFieldConfig.fromJson(json['rateOfInterest']),
      principalAmountFieldConfig:
          PrincipalAmountFieldConfig.fromJson(json['principalAmount']),
      timesToCompoundFieldConfig:
          TimesToCompoundFieldConfig.fromJson(json['timesToCompound']),
      numberOfYearsFieldConfig:
          NumberOfYearsFieldConfig.fromJson(json['numberOfYears']),
      outputValueConfig: OutputValueConfig.fromJson(json['outputValue']),
    );
  }
}
