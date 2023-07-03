import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../spleshscreen/modelpage.dart';
import '../../utils/login_helper.dart';

class logincontroller extends GetxController{
  void login()
  {
    FirebaseHelper.firebaseHelper.googleSignIn();
  }
  RxMap userDetail = {}.obs;
  List<HomeModel> productList = [];

  Stream<QuerySnapshot<Map<String, dynamic>>> readData() {
    return FirebaseHelper.firebaseHelper.readProduct();
  }
}