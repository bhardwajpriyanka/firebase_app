import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../login/controller/login_controller.dart';
import '../utils/login_helper.dart';
import 'modelpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  logincontroller controller = Get.put(
    logincontroller(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.grey.shade900,
                      ),
                      Text(
                        "15/2 New Texas",
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.toNamed("/cart");
                      },
                      icon: Icon(Icons.shopping_cart))
                  // CircleAvatar(
                  //   backgroundColor: Colors.pink,
                  // ),
                ],
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text("Explore", style: TextStyle(fontSize: 25.sp)),
              SizedBox(height: 15.sp),
              Text(
                "Best outfits for you",
                style: TextStyle(color: Colors.grey, fontSize: 15.sp),
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Container(
                  height: 45.sp,
                  width: 300.sp,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: Colors.grey.shade100,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50.sp,
                          width: 50.sp,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.search,
                          ),
                        ),
                        Container(
                          height: 50.sp,
                          width: 100.sp,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "search items",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Container(
                            height: 55.sp,
                            width: 35.sp,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.centerLeft,
                            child: Center(
                                child: Icon(Icons.manage_search_outlined))),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("New Arraival",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    Text("See All"),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseHelper.firebaseHelper.read(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      QuerySnapshot? snapData = snapshot.data;

                      controller.productList.clear();

                      for (var x in snapData!.docs) {
                        Map? data = x.data() as Map;

                        HomeModel m1 = HomeModel(
                            Price: data['price'],
                            Name: data['name'],
                            Category: data['category'],
                            image: data['image'],
                            key: x.id);

                        controller.productList.add(m1);

                        print(
                            "============${data['name']} ${data['price']} ${data['category']} ${data['image']}");
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 230),
                        shrinkWrap: true,
                        itemCount: controller.productList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed("/detail",
                                  arguments: controller.productList[index]);
                            },
                            child: Container(
                              height: 150,
                              width: 250,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 0.5)
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: Image.network(
                                              "${controller.productList[index].image}",
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("${controller.productList[index].Name}"),
                                  const Expanded(
                                      child: SizedBox(
                                        width: 10,
                                      )),
                                  Text(
                                      "₹${controller.productList[index].Price}"),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const CircularProgressIndicator(
                      color: Color(0xffE38800),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

