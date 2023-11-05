import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:do_an_tot_nghiep/widget/custom_appbar.dart';
import 'package:do_an_tot_nghiep/widget/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  static const String id = "rank screen";

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kColorWhite,
          image: DecorationImage(
              image: AssetImage(
                "assets/images/bg.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: const CustomAppBar(title: "Rank"),
        body: Builder(
          builder: (context) {
            if (FirebaseAuth.instance.currentUser!.isAnonymous) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    "assets/images/unlogin.png",
                    width: 150.w,
                  )),
                  SizedBox(
                    height: 15.h,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Oopss!!\n",
                          style: k25SizeBlackColorStyle,
                          children: [
                            TextSpan(
                                text:
                                    "You need to be signed in to use this feature",
                                style: k15SizeW400BlackColorStyle)
                          ]))
                ],
              );
            } else {
              return mainBody();
            }
          },
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> mainBody() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .orderBy('score', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          List<UserModel> listUser = [];
          for (var element in snapshot.data!.docs) {
            listUser.add(UserModel.fromMap(element.data()));
          }
          return ListView.builder(
            itemCount: listUser.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return UserCard(user: listUser[index]);
            },
          );
        }
        return Container();
      },
    );
  }
}
