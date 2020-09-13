import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'patient_stats.g.dart';

enum Status {
  @JsonValue('Recovered')
  Recovered,
  @JsonValue('Deceased')
  Deceased,
  @JsonValue('Hospitalized')
  Hospitalized,
  @JsonValue('Migrated')
  Migrated,
}

@JsonSerializable()
class PatientStats {
  int patientId;
  DateTime reportedOn;
  String onsetEstimate;
  int ageEstimate;
  String gender;
  String city;
  String district;
  String state;
  Status status;
  String notes;
  String contractedFrom;

  PatientStats({
    this.patientId,
    this.reportedOn,
    this.onsetEstimate,
    this.ageEstimate,
    this.gender,
    this.city,
    this.district,
    this.state,
    this.status,
    this.notes,
    this.contractedFrom,
  });

  factory PatientStats.fromJson(Map<String, dynamic> json) =>
      _$PatientStatsFromJson(json);

  Map<String, dynamic> toJson() => _$PatientStatsToJson(this);

  static Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data.json');
  }

  static Future<List> listFromJson() async {
    String x = await loadAsset();
    var data = jsonDecode(x);
    List<PatientStats> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(PatientStats.fromJson(data[i]));
    }
    return list;
  }

  static DateTime modifyDate(String date) {
    DateTime newDate = DateTime.parse(date.split('/').reversed.join());

    return newDate;
  }
}
