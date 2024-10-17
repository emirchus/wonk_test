import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wonk_app/domain/exceptions/no_files_exception.dart';
import 'package:wonk_app/domain/services/client_service.dart';
import 'package:wonk_app/domain/services/storage_service.dart';

@Injectable(as: StorageService)
class StorageServiceImpl implements StorageService {
  final SupabaseClient supabase;

  @factoryMethod
  factory StorageServiceImpl.create(ClientService clientService) {
    return StorageServiceImpl(supabase: clientService.client);
  }

  const StorageServiceImpl({required this.supabase});

  @override
  Future<Either<NoFilesException, List<String>>> getFilesFromStore(BigInt storeId) async {
    try {
      final List<FileObject> objects = await supabase.storage.from('coffees_stores').list(path: storeId.toString());

      final files = objects.map((e) => e.name).toList();

      if (files.isEmpty) {
        return Left(NoFilesException("No files found"));
      }

      final publicUrls = files.map((e) => supabase.storage.from('coffees_stores').getPublicUrl("${storeId.toString()}/$e")).toList();

      return Right(publicUrls);
    } catch (e) {
      return Left(NoFilesException("Error fetching files"));
    }
  }
}
