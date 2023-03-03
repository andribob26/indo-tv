import 'package:get/get.dart';
import 'package:tv_indonesia/models/chanel_model.dart';
import 'package:tv_indonesia/services/firestore_service.dart';

class HomeController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  final listChanel = Rx<List<ChanelModel>>([]);
  final errorImg = Rx<bool>(false);

  @override
  void onInit() {
    // TODO: implement onInit
    getAllItem();
    super.onInit();
  }

  void getAllItem() {
    listChanel.bindStream(_firestoreService.getAllItem());
    // _firestoreService.getAllItem();
  }
}
