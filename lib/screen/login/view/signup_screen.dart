import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/login_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  "Sing up",
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
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(10),
                                child: Icon(Icons.email,
                                    size: 25,
                                    ),
                              )),
                        ),
                        SizedBox(
                          height: 2,
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
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  child: Icon(Icons.lock,
                                      size: 25,
                                      ),
                                ))),
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text("Forgot password?")),
                        SizedBox(
                          height: 5
                        ),
                        InkWell(
                            onTap: () async {
                              String? msg = await FirebaseHelper.firebaseHelper
                                  .signUp(
                                  email: txtemail.text,
                                  password: txtpassword.text);
                              Get.snackbar(
                                  "${msg == true ? "SuccessxFully Logon" : "Fail to login"}",
                                  "firebase app");
                              if (msg == true) {
                                Get.offAndToNamed("/signin");
                              }
                            },
                            child: Container(
                                height: 60,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    )))),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have account ?",style: TextStyle(fontSize: 15)),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed('/signin');
                                },
                                child: Text(
                                  "Log in",
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