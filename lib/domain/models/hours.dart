// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison
// WARNING: This code is auto-generated by Supadart.
// WARNING: Modifications may be overwritten. Please make changes in the Supadart configuration.
import 'supadart_header.dart';

class Hours implements SupadartClass<Hours> {
  final BigInt id;
  final BigInt? cafeId;
  final String day;
  final DateTime? openTime;
  final DateTime? closeTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const Hours({
    required this.id,
    this.cafeId,
    required this.day,
    this.openTime,
    this.closeTime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  static String get table_name => 'hours';
  static String get c_id => 'id';
  static String get c_cafeId => 'cafe_id';
  static String get c_day => 'day';
  static String get c_openTime => 'open_time';
  static String get c_closeTime => 'close_time';
  static String get c_createdAt => 'created_at';
  static String get c_updatedAt => 'updated_at';
  static String get c_deletedAt => 'deleted_at';

  static List<Hours> converter(List<Map<String, dynamic>> data) {
    return data.map(Hours.fromJson).toList();
  }

  static Hours converterSingle(Map<String, dynamic> data) {
    return Hours.fromJson(data);
  }

  static Map<String, dynamic> _generateMap({
    BigInt? id,
    BigInt? cafeId,
    String? day,
    DateTime? openTime,
    DateTime? closeTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (cafeId != null) 'cafe_id': cafeId.toString(),
      if (day != null) 'day': day,
      if (openTime != null) 'open_time': openTime.toUtc().toIso8601String(),
      if (closeTime != null) 'close_time': closeTime.toUtc().toIso8601String(),
      if (createdAt != null) 'created_at': createdAt.toUtc().toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt.toUtc().toIso8601String(),
    };
  }

  static Map<String, dynamic> insert({
    BigInt? id,
    BigInt? cafeId,
    required String day,
    DateTime? openTime,
    DateTime? closeTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      day: day,
      openTime: openTime,
      closeTime: closeTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  static Map<String, dynamic> update({
    BigInt? id,
    BigInt? cafeId,
    String? day,
    DateTime? openTime,
    DateTime? closeTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      day: day,
      openTime: openTime,
      closeTime: closeTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  factory Hours.fromJson(Map<String, dynamic> jsonn) {
    return Hours(
      id: jsonn['id'] != null ? BigInt.parse(jsonn['id'].toString()) : BigInt.from(0),
      cafeId: jsonn['cafe_id'] != null ? BigInt.parse(jsonn['cafe_id'].toString()) : BigInt.from(0),
      day: jsonn['day'] != null ? jsonn['day'].toString() : '',
      openTime: jsonn['open_time'] != null ? DateTime.parse(jsonn['open_time'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      closeTime: jsonn['close_time'] != null ? DateTime.parse(jsonn['close_time'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      createdAt: jsonn['created_at'] != null ? DateTime.parse(jsonn['created_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: jsonn['updated_at'] != null ? DateTime.parse(jsonn['updated_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      deletedAt: jsonn['deleted_at'] != null ? DateTime.parse(jsonn['deleted_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      day: day,
      openTime: openTime,
      closeTime: closeTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  Hours copyWith({
    BigInt? id,
    BigInt? cafeId,
    String? day,
    DateTime? openTime,
    DateTime? closeTime,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Hours(
      id: id ?? this.id,
      cafeId: cafeId ?? this.cafeId,
      day: day ?? this.day,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
