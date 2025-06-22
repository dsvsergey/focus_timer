// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:focus_timer/cubit/timer_cubit.dart' as _i6;
import 'package:focus_timer/repositories/database_repository.dart' as _i3;
import 'package:focus_timer/services/macos_service.dart' as _i4;
import 'package:focus_timer/services/notification_service.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.DatabaseRepository>(() => _i3.DatabaseRepository());
    gh.singleton<_i4.MacOSService>(() => _i4.MacOSService());
    gh.singleton<_i5.NotificationService>(() => _i5.NotificationService());
    gh.factory<_i6.TimerCubit>(() => _i6.TimerCubit(
          gh<_i3.DatabaseRepository>(),
          gh<_i5.NotificationService>(),
          gh<_i4.MacOSService>(),
        ));
    return this;
  }
}
