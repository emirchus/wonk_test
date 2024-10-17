// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison
// WARNING: This code is auto-generated by Supadart.
// WARNING: Modifications may be overwritten. Please make changes in the Supadart configuration.
import 'supadart_header.dart';

class Califications implements SupadartClass<Califications> {
  final BigInt id;
  final BigInt? cafeId;
  final double rating;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? userId;

  const Califications({
    required this.id,
    this.cafeId,
    required this.rating,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
  });

  static String get table_name => 'califications';
  static String get c_id => 'id';
  static String get c_cafeId => 'cafe_id';
  static String get c_rating => 'rating';
  static String get c_type => 'type';
  static String get c_createdAt => 'created_at';
  static String get c_updatedAt => 'updated_at';
  static String get c_deletedAt => 'deleted_at';
  static String get c_userId => 'user_id';

  static List<Califications> converter(List<Map<String, dynamic>> data) {
    return data.map(Califications.fromJson).toList();
  }

  static Califications converterSingle(Map<String, dynamic> data) {
    return Califications.fromJson(data);
  }

  static Map<String, dynamic> _generateMap({
    BigInt? id,
    BigInt? cafeId,
    double? rating,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (cafeId != null) 'cafe_id': cafeId.toString(),
      if (rating != null) 'rating': rating.toString(),
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt.toUtc().toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt.toUtc().toIso8601String(),
      if (userId != null) 'user_id': userId,
    };
  }

  static Map<String, dynamic> insert({
    BigInt? id,
    BigInt? cafeId,
    required double rating,
    required String type,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
  }) {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      rating: rating,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      userId: userId,
    );
  }

  static Map<String, dynamic> update({
    BigInt? id,
    BigInt? cafeId,
    double? rating,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
  }) {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      rating: rating,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      userId: userId,
    );
  }

  factory Califications.fromJson(Map<String, dynamic> jsonn) {
    return Califications(
      id: jsonn['id'] != null
          ? BigInt.parse(jsonn['id'].toString())
          : BigInt.from(0),
      cafeId: jsonn['cafe_id'] != null
          ? BigInt.parse(jsonn['cafe_id'].toString())
          : BigInt.from(0),
      rating: jsonn['rating'] != null
          ? double.parse(jsonn['rating'].toString())
          : 0.0,
      type: jsonn['type'] != null ? jsonn['type'].toString() : '',
      createdAt: jsonn['created_at'] != null
          ? DateTime.parse(jsonn['created_at'].toString())
          : DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: jsonn['updated_at'] != null
          ? DateTime.parse(jsonn['updated_at'].toString())
          : DateTime.fromMillisecondsSinceEpoch(0),
      deletedAt: jsonn['deleted_at'] != null
          ? DateTime.parse(jsonn['deleted_at'].toString())
          : DateTime.fromMillisecondsSinceEpoch(0),
      userId: jsonn['user_id'] != null ? jsonn['user_id'].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      cafeId: cafeId,
      rating: rating,
      type: type,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      userId: userId,
    );
  }

  Califications copyWith({
    BigInt? id,
    BigInt? cafeId,
    double? rating,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    String? userId,
  }) {
    return Califications(
      id: id ?? this.id,
      cafeId: cafeId ?? this.cafeId,
      rating: rating ?? this.rating,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      userId: userId ?? this.userId,
    );
  }
}