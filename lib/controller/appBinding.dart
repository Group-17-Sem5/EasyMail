import 'package:get/get.dart';
import 'postManController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostManController>(() => PostManController());
    //Get.lazyPut<NotificationHandler>(() => NotificationHandler());
  }
}
