// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';

import 'src/stores/app_store.dart';
import 'src/services/auth_service.dart';
import 'src/stores/login_page_store.dart';
import 'src/services/memory_auth_service.dart';
import 'src/services/memory_query_repository.dart';
import 'src/services/memory_repository.dart';
import 'src/services/query_repository.dart';
import 'src/stores/register_page_store.dart';
import 'src/services/repository.dart';
import 'src/stores/user_list_page_store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  gh.factory<LoginPageStore>(() => LoginPageStore(g<AuthService>()));
  gh.factory<RegisterPageStore>(() => RegisterPageStore(g<AuthService>()));
  gh.factory<UserListPageStore>(
      () => UserListPageStore(g<QueryRepository>(), g<Repository>()));

  // Eager singletons must be registered in the right order
  gh.singleton<Repository>(MemoryRepository());
  gh.singleton<AuthService>(MemoryAuthService(g<Repository>()));
  gh.singleton<QueryRepository>(MemoryQueryRepository(g<Repository>()));
  gh.singleton<AppStore>(AppStore(g<AuthService>(), g<QueryRepository>()));
}
