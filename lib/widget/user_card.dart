import 'package:do_an_tot_nghiep/configs/style_config.dart';
import 'package:do_an_tot_nghiep/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

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
          //profile image
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kBorderColor, width: 2)),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    user.photoURL!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      //loading image
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.white60,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                )),
              ),
            ),
          ),
          //username
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: user.userName!,
                    style: k17SizeW500BlackColorStyle,
                    children: [
                      TextSpan(
                          text: "\nScore: ${user.score}",
                          style: k15SizeW400BlackColorStyle
                          // style: GoogleFonts.nunitoSans(
                          //     color: Colors.white54, fontSize: 12),
                          )
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
