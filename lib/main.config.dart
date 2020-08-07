// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';

import 'src/stores/app_store.dart';
import 'src/services/auth_service.dart';
import 'src/services/fire_auth_service.dart';
import 'src/services/fire_query_repository.dart';
import 'src/services/fire_repository.dart';
import 'src/stores/login_page_store.dart';
import 'src/services/query_repository.dart';
import 'src/stores/register_page_store.dart';
import 'src/services/repository.dart';
import 'src/stores/user_list_page_store.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  gh.factory<UserListPageStore>(
      () => UserListPageStore(g<QueryRepository>(), g<Repository>()));
  gh.factory<LoginPageStore>(() => LoginPageStore(g<AuthService>()));
  gh.factory<RegisterPageStore>(() => RegisterPageStore(g<AuthService>()));

  // Eager singletons must be registered in the right order
  gh.singleton<QueryRepository>(FireQueryRepository());
  gh.singleton<Repository>(FireRepository());
  gh.singleton<AuthService>(FireAuthService(g<Repository>()));
  gh.singleton<AppStore>(AppStore(g<AuthService>(), g<QueryRepository>()));
}
