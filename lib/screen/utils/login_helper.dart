import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> insertProduct({
    required p_name,
    required p_price,
    required p_rate,
    required p_image,
    required discount,
  }) async {
    await firebaseFirestore.collection("raj1").add(
      {
        "name": p_name,
        "price": p_price,
        "rate": p_rate,
        "image": p_image,
        "discount" : discount,
      },
    );
  }
  Future<bool> checkLogin() async {
    User? user = firebaseAuth.currentUser;

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> readProduct() {
    return firebaseFirestore.collection("product").snapshots();
  }


  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> signUp({required email, required password}) async {
    String? msg;

    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => "Success")
        .catchError((e) => "$e");
  }

  Future<String?> signIn({required email, required password}) async {
    String? msg;

    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => "Success")
        .catchError((e) => "$e");

  }

  Future<String?> googleSignIn() async {
    String? msg;

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

    var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    return await firebaseAuth
        .signInWithCredential(credential)
        .then((value) => "Success")
        .catchError((e) => "$e");
  }
  Future<void> logut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> read() {
    User? user = firebaseAuth.currentUser;
    String? uid = user?.uid;
    return firestore.collection("Product").snapshots();
  }

  Future<void> userdata() async {
    User? user = await firebaseAuth.currentUser;
    String? email=await user!.email;
    String? name=await user.displayName;
    String? image=await user!.photoURL;
  }
  Future<void> cartadd({
    required name,
    required price,
    required image,
    required category,
  }) async {
    await firebaseFirestore.collection("cart").add(
      {
        "name": name,
        "price": price,
        "image": image,
        "category" : category,
      },
    );
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> cartread() {
    User? user = firebaseAuth.currentUser;
    String? uid = user?.uid;
    return firestore.collection("cart").snapshots();
  }

  Future<void> cartdelete({required key})
  {
    return firestore.collection("cart").doc(key).delete();
  }

}