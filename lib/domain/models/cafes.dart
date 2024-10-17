// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison
// WARNING: This code is auto-generated by Supadart.
// WARNING: Modifications may be overwritten. Please make changes in the Supadart configuration.

import 'package:wonk_app/domain/models/hours.dart';
import 'package:wonk_app/domain/models/locations.dart';

import 'supadart_header.dart';

class Cafes implements SupadartClass<Cafes> {
  final BigInt id;
  final String name;
  final String address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final COUNTRIES country;
  final Locations? location;
  final List<Hours>? openingHours;

  const Cafes({
    required this.id,
    required this.name,
    required this.address,
    required this.country,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.location,
    this.openingHours,
  });

  static String get table_name => 'cafes';
  static String get c_id => 'id';
  static String get c_name => 'name';
  static String get c_address => 'address';
  static String get c_createdAt => 'created_at';
  static String get c_updatedAt => 'updated_at';
  static String get c_deletedAt => 'deleted_at';
  static String get c_country => 'country';

  static List<Cafes> converter(List<Map<String, dynamic>> data) {
    return data.map(Cafes.fromJson).toList();
  }

  static Cafes converterSingle(Map<String, dynamic> data) {
    return Cafes.fromJson(data);
  }

  static Map<String, dynamic> _generateMap({
    BigInt? id,
    String? name,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    COUNTRIES? country,
  }) {
    return {
      if (id != null) 'id': id.toString(),
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt.toUtc().toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt.toUtc().toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt.toUtc().toIso8601String(),
      if (country != null) 'country': country.toString().split('.').last,
    };
  }

  static Map<String, dynamic> insert({
    BigInt? id,
    required String name,
    required String address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    COUNTRIES? country,
  }) {
    return _generateMap(
      id: id,
      name: name,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      country: country,
    );
  }

  static Map<String, dynamic> update({
    BigInt? id,
    String? name,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    COUNTRIES? country,
  }) {
    return _generateMap(
      id: id,
      name: name,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      country: country,
    );
  }

  factory Cafes.fromJson(Map<String, dynamic> jsonn) {
    return Cafes(
      id: jsonn['id'] != null ? BigInt.parse(jsonn['id'].toString()) : BigInt.from(0),
      name: jsonn['name'] != null ? jsonn['name'].toString() : '',
      address: jsonn['address'] != null ? jsonn['address'].toString() : '',
      createdAt: jsonn['created_at'] != null ? DateTime.parse(jsonn['created_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: jsonn['updated_at'] != null ? DateTime.parse(jsonn['updated_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      deletedAt: jsonn['deleted_at'] != null ? DateTime.parse(jsonn['deleted_at'].toString()) : DateTime.fromMillisecondsSinceEpoch(0),
      country: jsonn['country'] != null ? COUNTRIES.values.byName(jsonn['country'].toString()) : COUNTRIES.values.first,
      location: jsonn[Locations.table_name] != null ? Locations.fromJson(jsonn[Locations.table_name][0]) : null,
      openingHours: jsonn[Hours.table_name] != null ? List.from(jsonn[Hours.table_name]).map<Hours>((hours) => Hours.fromJson(hours)).toList() : [],
    );
  }

  Map<String, dynamic> toJson() {
    return _generateMap(
      id: id,
      name: name,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      country: country,
    );
  }

  Cafes copyWith({
    BigInt? id,
    String? name,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    COUNTRIES? country,
  }) {
    return Cafes(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      country: country ?? this.country,
    );
  }
}