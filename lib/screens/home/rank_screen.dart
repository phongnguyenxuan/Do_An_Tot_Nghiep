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
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});
  static const String id = "rank screen";

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();

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
          .orderBy('score', descending: true).snapshots(),
      builder: (context, snapshot) {
        debugPrint("state: ${snapshot.connectionState.name}");
        List<UserModel> listUser = [];
        if (snapshot.data != null) {
          for (var element in snapshot.data!.docs) {
            listUser.add(UserModel.fromMap(element.data()));
          }
          return listUser.isNotEmpty ? Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(color: kBorderColor, offset: Offset(0, 2))
                ], borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.circular(30),
                  ),
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
                            boderColor: kColorBrightCyan,
                            index: 1,
                            nameTextStyle: TextStyle(
                                fontFamily: kfontFamily,
                                color: kColorBlack,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp),
                            scoreTextStyle: TextStyle(
                                fontFamily: kfontFamily,
                                color: kColorBrightCyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp),
                            radius: 30,
                          ),
                          LeaderBoard(
                            user: listUser[0],
                            boderColor: kColorOrange,
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
                            boderColor: kBorderColor,
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
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemCount: listUser.length,
                  itemScrollController: itemScrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (listUser[index]
                        .uid!
                        .contains(FirebaseAuth.instance.currentUser!.uid)) {
                      Future.delayed(const Duration(milliseconds: 300), () {
                        itemScrollController.scrollTo(
                            index: index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      });
                    }
                    return (index == 0 || index == 1 || index == 2)
                        ? Container()
                        : UserCard(
                            user: listUser[index],
                            index: index,
                          );
                  },
                ),
              ),
            ],
          ) : Container(
            color: kColorWhite,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
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
