/// Contracts for [Locator] operations.
abstract interface class Locator {
  /// Gets the needed dependency.
  T get<T>();

  /// Registers a singleton.
  void registerSingleton<T>(T instance);

  /// Registers a factory.
  void registerFactory<T>(T Function() constructor);
}

/// Concrete implementation of the [Locator].
class LocatorImpl implements Locator {
  final Map<Type, dynamic> singletonStorage = {};
  final Map<Type, dynamic> factoryStorage = {};

  @override
  T get<T>() {
    if(singletonStorage.containsKey(T)) return singletonStorage[T];
    if(factoryStorage.containsKey(T)) return factoryStorage[T]();
    throw 'Please register $T before accessing it.';
  }

  @override
  void registerFactory<T>(T Function() constructor) {
    factoryStorage[T] = constructor;
  }

  @override
  void registerSingleton<T>(T instance) {
    singletonStorage[T] = instance;
  }
}