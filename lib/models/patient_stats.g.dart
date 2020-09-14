// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatientStats _$PatientStatsFromJson(Map<String, dynamic> json) {
  return PatientStats(
    patientId: json['patientId'] as int,
    reportedOn: json['reportedOn'] == null
        ? null
        : PatientStats.modifyDate(json['reportedOn'] as String),
    onsetEstimate: json['onsetEstimate'] as String,
    ageEstimate: json['ageEstimate'] == ''
        ? 0
        : json['ageEstimate'].toString().contains('-')
            ? 0
            : int.tryParse(json['ageEstimate'].toString()) == null
                ? 0
                : int.parse(json['ageEstimate'].toString()),
    gender: json['gender'] as String,
    city: json['city'] as String,
    district: json['district'] as String,
    state: _$enumDecodeNullable(_$StatesEnumMap, json['state']),
    status: _$enumDecodeNullable(_$StatusEnumMap, json['status']),
    notes: json['notes'] as String,
    contractedFrom: json['contractedFrom'] as String,
  );
}

Map<String, dynamic> _$PatientStatsToJson(PatientStats instance) =>
    <String, dynamic>{
      'patientId': instance.patientId,
      'reportedOn': instance.reportedOn?.toIso8601String(),
      'onsetEstimate': instance.onsetEstimate,
      'ageEstimate': instance.ageEstimate,
      'gender': instance.gender,
      'city': instance.city,
      'district': instance.district,
      'state': _$StatesEnumMap[instance.state],
      'status': _$StatusEnumMap[instance.status],
      'notes': instance.notes,
      'contractedFrom': instance.contractedFrom,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues,
    dynamic source, {
      T unknownValue,
    }) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StatesEnumMap = {
  States.India: 'India',
  States.AndhraPradesh: 'Andhra Pradesh',
  States.Assam: 'Assam',
  States.ArunachalPradesh: 'Arunachal Pradesh',
  States.Bihar: 'Bihar',
  States.Goa: 'Goa',
  States.Gujarat: 'Gujarat',
  States.JammuAndKashmir: 'Jammu and Kashmir',
  States.Jharkhand: 'Jharkhand',
  States.WestBengal: 'West Bengal',
  States.Karnataka: 'Karnataka',
  States.Kerala: 'Kerala',
  States.MadhyaPradesh: 'Madhya Pradesh',
  States.Ladakh: 'Ladakh',
  States.Maharashtra: 'Maharashtra',
  States.Delhi: 'Delhi',
  States.Manipur: 'Manipur',
  States.Meghalaya: 'Meghalaya',
  States.Mizoram: 'Mizoram',
  States.Nagaland: 'Nagaland',
  States.Odisha: 'Odisha',
  States.Punjab: 'Punjab',
  States.Rajasthan: 'Rajasthan',
  States.Sikkim: 'Sikkim',
  States.TamilNadu: 'Tamil Nadu',
  States.Telangana: 'Telangana',
  States.Tripura: 'Tripura',
  States.Uttarakhand: 'Uttarakhand',
  States.UttarPradesh: 'Uttar Pradesh',
  States.Haryana: 'Haryana',
  States.HimachalPradesh: 'Himachal Pradesh',
  States.Chhattisgarh: 'Chhattisgarh',
  States.Puducherry: 'Puducherry',
  States.Chandigarh: 'Chandigarh',
  States.AndamanAndNicobarIslands: 'Andaman and Nicobar Islands',
  States.nil: '',
};

const _$StatusEnumMap = {
  Status.Recovered: 'Recovered',
  Status.Deceased: 'Deceased',
  Status.Hospitalized: 'Hospitalized',
  Status.Migrated: 'Migrated',
};
