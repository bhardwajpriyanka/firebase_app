import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/login_helper.dart';
import '../controller/cart_controller.dart';
import '../model/cart_model.dart';


class Cart_screen extends StatefulWidget {
  const Cart_screen({Key? key}) : super(key: key);

  @override
  State<Cart_screen> createState() => _Cart_screenState();
}

class _Cart_screenState extends State<Cart_screen> {
  cartcontroller cc = Get.put(
    cartcontroller(),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leading: const Icon(Icons.arrow_back_ios_outlined,color: Colors.black),centerTitle: true,title: const Text("My Cart",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),backgroundColor: Colors.white),
        backgroundColor: Colors.grey.shade100,
        body:  StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.cartread(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData) {
              QuerySnapshot? snapData = snapshot.data as QuerySnapshot<Object?>?;

              cc.cartlist.clear();

              for (var x in snapData!.docs) {
                Map? data = x.data() as Map;

                cmodel c1 = cmodel(
                    Price: data['price'],
                    Name: data['name'],
                    Category: data['category'],
                    image: data['image'],
                    key: x.id);

                cc.cartlist.add(c1);

                print(
                    "============${data['name']} ${data['price']} ${data['category']} ${data['image']}");
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: cc.cartlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      FirebaseHelper.firebaseHelper.cartdelete(key: cc.cartlist[index].key);
                    },
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.all(5),
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15),boxShadow: [const BoxShadow(color: Colors.black,blurStyle: BlurStyle.outer,blurRadius:1)]),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                              child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network("${cc.cartlist[index].image}",fit: BoxFit.cover)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${cc.cartlist[index].Name}",style: TextStyle(letterSpacing: 2)),
                              const SizedBox(height: 4,),
                              Text("₹ ${cc.cartlist[index].Price}", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Expanded(child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 25,
                                width: 30,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.blue.shade100),
                                child: const Center(child: Icon(Icons.add,color: Colors.blue,size: 17,)),
                              ),
                              const SizedBox(width: 3,),
                              const Text("1",style: TextStyle(fontSize: 15)),
                              const SizedBox(width: 3,),
                              Container(
                                height: 25,
                                width: 30,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.blue.shade100),
                                child: const Center(child: Text("-",style: TextStyle(color: Colors.blue,fontSize: 17)),),
                              ),
                              const SizedBox(width: 3,)
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator(
              color: Colors.blue
            );
          },
        ),
      ),
    );
  }
}