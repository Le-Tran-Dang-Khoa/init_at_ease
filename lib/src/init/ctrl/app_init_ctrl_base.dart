import 'dart:ui';

import 'package:meta/meta.dart';

import '../model/init_def.dart';
import 'linear_loading_waiting_ctrl.dart';

abstract class AppInitCtrlBase extends LinearLoadingWaitingCtrl {
  void Function(AppInitCtrlBase appCtrl)? _onInitCompleted;

  AppInitCtrlBase() : super();

  @mustCallSuper
  Future<void> preinitAAsync({
    List<Initializer>? initializers,
    List<AsyncInitializer>? asyncInitializers,
  }) async {
    if (initializers != null) {
      for (var initializer in initializers) {
        initializer.init();
      }
    }
    if (asyncInitializers != null) {
      for (var asyncInitializer in asyncInitializers) {
        await asyncInitializer.initAAsync();
      }
    }
  }

  @mustCallSuper
  void initAsync({
    List<Initializer>? initializers,
    List<AsyncInitializer>? asyncInitializers,
    int minWaitingMillisec: 0,
  }) async {
    restart((initializers ?? []).length + (asyncInitializers ?? []).length);

    var start = DateTime.now();

    if (initializers != null) {
      for (var initializer in initializers) {
        initializer.init();
        doneOne();
      }
    }

    if (asyncInitializers != null) {
      for (var asyncInitializer in asyncInitializers) {
        await asyncInitializer.initAAsync();
        doneOne();
      }
    }

    var end = DateTime.now();
    var elapsedMillisec =
        end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;
    if (elapsedMillisec < minWaitingMillisec) {
      await Future.delayed(
        Duration(milliseconds: minWaitingMillisec - elapsedMillisec),
      );
    }

    doneWaiting();
    _onInitCompleted?.call(this);
  }

  void postInit() {}

  void regInitCompletedCallback(
      void Function(AppInitCtrlBase appCtrl) callback) {
    _onInitCompleted = callback;
  }

  void unregInitCompletedCallbackk() {
    _onInitCompleted = null;
  }

  void setAppStateChanged(AppLifecycleState state) {}

  void release() {}
}
