import 'package:package_info_plus/package_info_plus.dart';

import '../model/init_def.dart';

class PackageCtrl implements AsyncInitializer {
  static final instance = PackageCtrl._singleton();

  PackageInfo? _packageInfo;
  PackageInfo? get packageInfo => _packageInfo;

  PackageCtrl._singleton();

  @override
  Future<void> initAAsync() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
