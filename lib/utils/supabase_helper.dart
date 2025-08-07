import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static final SupabaseHelper _instance = SupabaseHelper._internal();
  factory SupabaseHelper() => _instance;
  SupabaseHelper._internal();

  late final SupabaseClient client;

  Future<void> init({required String url, required String anonKey}) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    client = Supabase.instance.client;
  }

  SupabaseClient get supabase => client;

  // Example: fetch data from a table
  Future<List<Map<String, dynamic>>> fetchTable(String table) async {
    final response = await client.from(table).select().then((value) => value);
    return List<Map<String, dynamic>>.from(response as List);
  }

  // Example: insert data into a table
  Future<void> insert(String table, Map<String, dynamic> data) async {
    await client.from(table).insert(data);
  }

  // Example: update data in a table
  Future<void> update(
    String table,
    Map<String, dynamic> data,
    String matchKey,
    dynamic matchValue,
  ) async {
    await client.from(table).update(data).eq(matchKey, matchValue);
  }

  // Example: delete data from a table
  Future<void> delete(String table, String matchKey, dynamic matchValue) async {
    await client.from(table).delete().eq(matchKey, matchValue);
  }
}

// ...existing code...
