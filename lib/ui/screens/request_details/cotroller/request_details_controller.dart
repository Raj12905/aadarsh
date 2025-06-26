import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';


class RequestDetailsController extends BaseController {
    late Map<String,dynamic> request;

    @override
    void onInit() {
        super.onInit();
        request = Get.arguments  as Map<String, dynamic>;
    }



    void viewAttachment(String attachmentUrl) {
        // Implement attachment viewing logic
        showToast('Opening attachment: $attachmentUrl');
    }
}