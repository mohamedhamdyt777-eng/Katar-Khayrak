// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/bloc/auth_cubit.dart' as _i903;
import '../../features/auth/datasources/auth_local_datasource.dart' as _i556;
import '../../features/auth/datasources/auth_remote_datasource.dart' as _i573;
import '../../features/auth/repositories/auth_repository.dart' as _i1041;
import '../../features/cart/bloc/cart_cubit.dart' as _i227;
import '../../features/dashboard/bloc/campaigns_cubit.dart' as _i703;
import '../../features/dashboard/bloc/recommendations_cubit.dart' as _i528;
import '../../features/favorites/bloc/favorites_cubit.dart' as _i797;
import '../../features/notifications/bloc/notifications_cubit.dart' as _i772;
import '../bloc/app_cubit.dart' as _i868;
import 'injection.dart' as _i464;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i556.AuthLocalDatasource>(() => _i556.AuthLocalDatasource());
    gh.singleton<_i868.AppCubit>(() => _i868.AppCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i227.CartCubit>(() => _i227.CartCubit());
    gh.lazySingleton<_i703.CampaignsCubit>(() => _i703.CampaignsCubit());
    gh.lazySingleton<_i528.RecommendationsCubit>(
      () => _i528.RecommendationsCubit(),
    );
    gh.lazySingleton<_i797.FavoritesCubit>(() => _i797.FavoritesCubit());
    gh.lazySingleton<_i772.NotificationsCubit>(
      () => _i772.NotificationsCubit(),
    );
    gh.factory<_i573.AuthRemoteDatasource>(
      () => _i573.AuthRemoteDatasource(gh<_i361.Dio>()),
    );
    gh.factory<_i1041.AuthRepository>(
      () => _i1041.AuthRepository(
        gh<_i573.AuthRemoteDatasource>(),
        gh<_i556.AuthLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i903.AuthCubit>(
      () => _i903.AuthCubit(gh<_i1041.AuthRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i464.RegisterModule {}
