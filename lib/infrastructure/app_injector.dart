import '../application/logic/daily_task/task_bloc.dart';
import '../application/logic/error/error_cubit.dart';
import '../domain/repository/error_repository.dart';
import '../domain/repository/task_repository.dart';
import 'repository/error_repository_impl.dart';
import 'repository/task_repository_impl.dart';
import '../application/service/locator.dart';

/// Global instance for locator
final Locator locator = LocatorImpl();

/// Defines the contract for service locator based of flavor of the application.
abstract interface class AppInjector {
  /// Injects all the dependencies and initialize services.
  Future<void> init();
}

/// Service locator for development.
class DependencyInjector implements AppInjector {
  @override
  Future<void> init() async {
    // mock data
    locator.registerFactory<TaskRepository>(() => TaskRepositoryImpl());
    locator.registerFactory<TaskBloc>(
      () => TaskBloc(locator.get<TaskRepository>(), locator.get()),
    );

    locator.registerFactory<ErrorRepository>(() => const ErrorRepositoryImpl());
    locator.registerFactory(() => ErrorCubit(locator.get()));
  }
}
