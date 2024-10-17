import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/domain/services/client_service.dart';

@Singleton(as: ClientService)
class ClientServiceImpl implements ClientService {
  @override
  SupabaseClient get client => Supabase.instance.client;
}
