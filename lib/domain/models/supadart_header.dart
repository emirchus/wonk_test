// ignore_for_file: non_constant_identifier_names, camel_case_types, file_namesimport, file_names, unnecessary_null_comparison

// WARNING: This code is auto-generated by Supadart.
// WARNING: Modifications may be overwritten. Please make changes in the SupaDart configuration.

// SDK
import 'package:supabase_flutter/supabase_flutter.dart';

// No Intl package needed
// No Dart Convert needed
// Supadart Class
abstract class SupadartClass<T> {
  static Map<String, dynamic> insert(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  static Map<String, dynamic> update(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  factory SupadartClass.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  static converter(List<Map<String, dynamic>> data) {
    throw UnimplementedError();
  }

  static converterSingle(Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}

// Supabase Client Extension
extension SupadartClient on SupabaseClient {
  SupabaseQueryBuilder get locations => from('locations');
  SupabaseQueryBuilder get califications => from('califications');
  SupabaseQueryBuilder get cafes => from('cafes');
  SupabaseQueryBuilder get flags => from('flags');
  SupabaseQueryBuilder get hours => from('hours');
}

// Supabase Storage Client Extension
extension SupadartStorageClient on SupabaseStorageClient {}

// Enums
enum COUNTRIES { arg, uy, br, mx }

// Utils