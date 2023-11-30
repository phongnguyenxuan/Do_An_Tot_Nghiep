import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final int index;
  const UserCard({super.key, required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    final userLogin = FirebaseAuth.instance.currentUser!;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: userLogin.uid.contains(user.uid!)
              ? primaryMaterialColor.shade200
              : kColorWhite,
          border: Border.all(color: kBorderColor, width: 2)),
      child: Row(
        children: [
          Text("# ${index + 1}", style: k17SizeW500BlackColorStyle,),
          //profile image
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: //avatar
                Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: kBorderColor),
              ),
              child: CircleAvatar(
                radius: 25,
                child: ClipOval(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: CachedNetworkImage(
                      imageUrl: user.photoURL!,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
          ),
          //username
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: userLogin.uid.contains(user.uid!)
                      ? translate.you
                      : user.userName!,
                  style: k17SizeW500BlackColorStyle,
                  children: [
                    TextSpan(
                        text: "\n${translate.score}: ${user.score}",
                        style: k15SizeW400BlackColorStyle)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
