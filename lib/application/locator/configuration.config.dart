// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../domain/repositories/califications_repository.dart' as _i181;
import '../../domain/repositories/coffee_repository.dart' as _i812;
import '../../domain/repositories/flags_repository.dart' as _i877;
import '../../domain/services/auth_service.dart' as _i109;
import '../../domain/services/client_service.dart' as _i858;
import '../../domain/services/storage_service.dart' as _i267;
import '../repositories/califications_repository_impl.dart' as _i916;
import '../repositories/coffee_repository_impl.dart' as _i943;
import '../repositories/flags_repository_impl.dart' as _i1071;
import '../services/auth_service_impl.dart' as _i891;
import '../services/client_service_impl.dart' as _i30;
import '../services/storage_service_impl.dart' as _i506;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i858.ClientService<dynamic>>(() => _i30.ClientServiceImpl());
    gh.factory<_i877.FlagsRepository>(() =>
        _i1071.FlagsRepositoryImpl.create(gh<_i858.ClientService<dynamic>>()));
    gh.factory<_i109.AuthService>(() => _i891.SupabaseAuthServiceImpl.create(
        gh<_i858.ClientService<dynamic>>()));
    gh.factory<_i812.CoffeeRepository>(() =>
        _i943.CoffeeRepositoryImpl.create(gh<_i858.ClientService<dynamic>>()));
    gh.factory<_i267.StorageService>(() =>
        _i506.StorageServiceImpl.create(gh<_i858.ClientService<dynamic>>()));
    gh.factory<_i181.CalificationsRepository>(() =>
        _i916.CalificationsRepositoryImpl.create(
            gh<_i858.ClientService<dynamic>>()));
    return this;
  }
}
