// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ValidationErrorImpl _$$ValidationErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$ValidationErrorImpl(
      fieldName: json['fieldName'] as String,
      errorCode: json['errorCode'] as String,
    );

Map<String, dynamic> _$$ValidationErrorImplToJson(
        _$ValidationErrorImpl instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'errorCode': instance.errorCode,
    };
