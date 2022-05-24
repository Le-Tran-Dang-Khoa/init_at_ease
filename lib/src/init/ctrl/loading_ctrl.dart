import 'package:get/get.dart';

class LoadingCtrl extends GetxController {
  final RxBool completed = false.obs;

  LoadingCtrl();

  void restart() => completed.value = false;
  void done() => completed.value = true;
}
