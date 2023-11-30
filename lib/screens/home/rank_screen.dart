import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:do_an_tot_nghiep/widget/custom_appbar.dart';
import 'package:do_an_tot_nghiep/widget/leader_board.dart';
import 'package:do_an_tot_nghiep/widget/user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  static const String id = "rank screen";

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: CustomAppBar(title: translate.rank),
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
                              text: translate.needSign,
                              style: k15SizeW400BlackColorStyle)
                        ]))
              ],
            );
          } else {
            return mainBody();
          }
        },
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
          return Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: const Border(
                      top: BorderSide(color: kBorderColor, width: 0),
                      left: BorderSide(color: kBorderColor, width: 0),
                      right: BorderSide(color: kBorderColor, width: 0),
                      bottom: BorderSide(color: kBorderColor, width: 2),
                    ),
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LeaderBoard(
                          user: listUser[1],
                          index: 1,
                          nameTextStyle: TextStyle(
                              fontFamily: kfontFamily,
                              color: kColorBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp),
                          scoreTextStyle: TextStyle(
                              fontFamily: kfontFamily,
                              color: kColorBrightCyan,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                          radius: 30,
                        ),
                        LeaderBoard(
                          user: listUser[0],
                          nameTextStyle: TextStyle(
                              fontFamily: kfontFamily,
                              color: kColorBlack,
                              fontWeight: FontWeight.w900,
                              fontSize: 17.sp),
                          scoreTextStyle: TextStyle(
                              fontFamily: kfontFamily,
                              color: kColorOrange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                          index: 0,
                          radius: 45,
                        ),
                        LeaderBoard(
                          user: listUser[2],
                          index: 2,
                          nameTextStyle: TextStyle(
                              fontFamily: kfontFamily,
                              color: kColorBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp),
                          scoreTextStyle: TextStyle(
                              color: kBorderColor,
                              fontFamily: kfontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp),
                          radius: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: listUser.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          duration: const Duration(milliseconds: 375),
                          position: index,
                          child: (index == 0 || index == 1 || index == 2)
                              ? Container()
                              : ScaleAnimation(
                                  child: UserCard(
                                  user: listUser[index],
                                  index: index,
                                )));
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container(
            color: kColorWhite,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
