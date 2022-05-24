import 'package:get/get.dart';

import 'linear_loading_ctrl.dart';

class LinearLoadingWaitingCtrl extends LinearLoadingCtrl {
  final waiting = true.obs;

  LinearLoadingWaitingCtrl() : super();

  bool get isWaiting => waiting.value;

  @override
  void restart(int totalValue) {
    waiting.value = true;
    super.restart(totalValue);
  }

  void doneWaiting() {
    if (isWaiting) waiting.value = false;
  }
}
