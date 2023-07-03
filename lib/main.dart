import 'package:firebase_app/screen/cartpage/view/cartscreen.dart';
import 'package:firebase_app/screen/detailpage/detail_screen.dart';
import 'package:firebase_app/screen/lastpages/last_screen.dart';
import 'package:firebase_app/screen/login/view/login.dart';
import 'package:firebase_app/screen/login/view/signup_screen.dart';
import 'package:firebase_app/screen/spleshscreen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/splesh',
        getPages: [
          GetPage(
            name: '/',
            page: () => const Bottomscreen(),
          ),
          GetPage(
            name: '/Signin',
            page: () => const SignInScreen(),
          ),
          GetPage(
            name: '/splesh',
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: '/bottom',
            page: () => const Bottomscreen(),
          ),
          GetPage(
            name: '/Singup',
            page: () => const SignupScreen(),
          ),
          GetPage(
            name: '/detail',
            page: () => const detail_screen(),
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: '/cart',
            page: () => const Cart_screen(),
          ),
        ],
      ),
    ),
  );
}