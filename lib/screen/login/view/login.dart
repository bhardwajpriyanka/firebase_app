import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/login_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.blueGrey.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Log in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold
                    // letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: txtemail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blueGrey.shade700)),
                              // hintText: "xyz@gmail.com",
                              label: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Email",
                                    style: TextStyle(
                                        color: Colors.blueGrey.shade700)),
                              ),
                              prefixIcon: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(10),
                                child: Icon(Icons.email,
                                    size: 25,
                                    ),
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        TextField(
                            controller: txtpassword,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                label: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Password",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade700)),
                                ),
                                // hintText: "Enter password",
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  child: Icon(Icons.lock,
                                      size: 25,
                                      ),
                                ))),
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot password?")),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                            onTap: () async {
                              String? msg = await FirebaseHelper.firebaseHelper
                                  .signIn(
                                  email: txtemail.text,
                                  password: txtpassword.text);
                              Get.snackbar(
                                  msg == "Success" ? "success" : "Fail to login",
                                  "firebase app");
                              if (msg == "Success") {
                                Get.offAndToNamed("/home");
                              }
                            },
                            child: Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Log in",
                                      style: TextStyle(
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    )))),
                        SizedBox(
                          height: 10.sp,
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),boxShadow: [BoxShadow(blurStyle: BlurStyle.inner,color: Colors.white)]),
                              height: 50,
                              width: 50,
                              child: FlutterLogo(),
                            ),
                            SizedBox(width: 20,),
                            InkWell(
                              onTap: () async {

                                String? msg = await FirebaseHelper.firebaseHelper
                                    .googleSignIn();
                                Get.snackbar(
                                    msg == "Success" ? "success" : "Fail to login",
                                    "firebase app");
                                if (msg == "Success") {
                                  Get.offNamed("/home");
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 50.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(fontSize: 15)),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/Singup');
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.blueGrey.shade900,fontWeight: FontWeight.bold,fontSize: 16),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}