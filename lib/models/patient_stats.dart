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
enum States {
  @JsonValue('India')
  India,
  @JsonValue('Ladakh')
  Ladakh,
  @JsonValue('Andhra Pradesh')
  AndhraPradesh,
  @JsonValue('Telangana')
  Telangana,
  @JsonValue('Assam')
  Assam,
  @JsonValue('Arunachal Pradesh')
  ArunachalPradesh,
  @JsonValue('Bihar')
  Bihar,
  @JsonValue('Goa')
  Goa,
  @JsonValue('Gujarat')
  Gujarat,
  @JsonValue('Jammu And Kashmir')
  JammuAndKashmir,
  @JsonValue('Jharkhand')
  Jharkhand,
  @JsonValue('West Bengal')
  WestBengal,
  @JsonValue('Karnataka')
  Karnataka,
  @JsonValue('Kerala')
  Kerala,
  @JsonValue('Madhya Pradesh')
  MadhyaPradesh,
  @JsonValue('Maharashtra')
  Maharashtra,
  @JsonValue('Manipur')
  Manipur,
  @JsonValue('Chandigarh')
  Chandigarh,
  @JsonValue('Meghalaya')
  Meghalaya,
  @JsonValue('Mizoram')
  Mizoram,
  @JsonValue('Nagaland')
  Nagaland,
  @JsonValue('Odisha')
  Odisha,
  @JsonValue('Puducherry')
  Puducherry,
  @JsonValue('Punjab')
  Punjab,
  @JsonValue('Rajasthan')
  Rajasthan,
  @JsonValue('Sikkim')
  Sikkim,
  @JsonValue('Tamil Nadu')
  TamilNadu,
  @JsonValue('Tripura')
  Tripura,
  @JsonValue('Uttarakhand')
  Uttarakhand,
  @JsonValue('Uttar Pradesh')
  UttarPradesh,
  @JsonValue('Haryana')
  Haryana,
  @JsonValue('Himachal Pradesh')
  HimachalPradesh,
  @JsonValue('Chhattisgarh')
  Chhattisgarh,
  @JsonValue('Delhi')
  Delhi,
  @JsonValue('Andaman and Nicobar Islands')
  AndamanAndNicobarIslands,
  @JsonValue('Cases with no State')
  nil
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
  States state;
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
    DateTime newDate = DateTime.parse(date
        .split('/')
        .reversed
        .join());

    return newDate;
  }

  static const statesEnumMap = {
    States.India: 'India',
    States.Delhi: 'Delhi',
    States.AndhraPradesh: 'Andhra Pradesh',
    States.Assam: 'Assam',
    States.ArunachalPradesh: 'Arunachal Pradesh',
    States.Telangana: 'Telangana',
    States.Bihar: 'Bihar',
    States.Goa: 'Goa',
    States.Gujarat: 'Gujarat',
    States.JammuAndKashmir: 'Jammu And Kashmir',
    States.Jharkhand: 'Jharkhand',
    States.WestBengal: 'West Bengal',
    States.Karnataka: 'Karnataka',
    States.Kerala: 'Kerala',
    States.MadhyaPradesh: 'Madhya Pradesh',
    States.Maharashtra: 'Maharashtra',
    States.Manipur: 'Manipur',
    States.Meghalaya: 'Meghalaya',
    States.Mizoram: 'Mizoram',
    States.Nagaland: 'Nagaland',
    States.Odisha: 'Odisha',
    States.Punjab: 'Punjab',
    States.Rajasthan: 'Rajasthan',
    States.Sikkim: 'Sikkim',
    States.TamilNadu: 'Tamil Nadu',
    States.Tripura: 'Tripura',
    States.Uttarakhand: 'Uttarakhand',
    States.UttarPradesh: 'Uttar Pradesh',
    States.Haryana: 'Haryana',
    States.HimachalPradesh: 'Himachal Pradesh',
    States.Chhattisgarh: 'Chhattisgarh',
    States.Ladakh: 'Ladakh',
    States.Puducherry: 'Puducherry',
    States.AndamanAndNicobarIslands: 'Andaman and Nicobar Islands',
    States.Chandigarh: 'Chandigarh',
    States.nil: 'Cases with no State',
  };
}
