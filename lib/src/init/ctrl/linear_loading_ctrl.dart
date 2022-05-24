import 'package:get/get.dart';

class LinearLoadingCtrl extends GetxController {
  final total = 0.obs;
  final progress = 0.obs;

  LinearLoadingCtrl();

  bool get isCompleted => progress.value >= total.value;
  double get percentCompleted => (progress.value * 100.0) / total.value;

  void restart(int totalValue) {
    progress.value = 0;
    total.value = totalValue;
  }

  void doneOne() => doneSerie(1);

  void doneSerie(int serie) {
    if ((serie <= 0) || ((progress.value + serie) > total.value)) {
      throw 'doneSerie: Invalid serie value';
    }

    progress.value += serie;
  }
}
