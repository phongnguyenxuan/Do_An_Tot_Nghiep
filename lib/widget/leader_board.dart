import 'package:cached_network_image/cached_network_image.dart';
import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard(
      {super.key,
      required this.user,
      required this.boderColor,
      this.scoreTextStyle,
      this.nameTextStyle,
      required this.index,
      this.radius});
  final UserModel user;
  final Color boderColor;
  final TextStyle? scoreTextStyle;
  final TextStyle? nameTextStyle;
  final int index;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index == 0
            ? Image.asset(
                "assets/images/crown.png",
                width: 35,
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "# ${index + 1}",
                  style: index == 1
                      ? TextStyle(
                          fontFamily: kfontFamily,
                          color: kBorderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp)
                      : TextStyle(
                          fontFamily: kfontFamily,
                          color: kBorderColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp),
                ),
              ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2, 
            color: boderColor),
          ),
          child: CircleAvatar(
            radius: radius,
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CachedNetworkImage(
                  imageUrl: user.photoURL!,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.score.toString(),
          style: scoreTextStyle,
        ),
        const SizedBox(height: 5,),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Text(
          !FirebaseAuth.instance.currentUser!.uid.contains(user.uid!) ? user.userName! : translate.you,
            textAlign: TextAlign.center,
            style: nameTextStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
