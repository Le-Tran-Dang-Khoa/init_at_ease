abstract class Initializer {
  void init();
}

abstract class AsyncInitializer {
  Future<void> initAAsync();
}
