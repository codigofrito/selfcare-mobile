import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:selfcare/app/data/session_config/session_user.dart';
import 'app/routes/screen_route_binding.dart';
import 'app/styles/themes.dart';

void main() {
  runApp(App());
  Get.put<SessionUser>(SessionUser());
  Get.putAsync<PackageInfo>(() => PackageInfo.fromPlatform(), permanent: true);
  Get.updateLocale(Locale('pt', 'BR'));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "SelfCare",
      theme: AppTheme.light,
      initialRoute: ScreenRouteBinding.INITIAL,
      getPages: ScreenRouteBinding.screens,
    );
  }
}
