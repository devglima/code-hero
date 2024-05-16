import 'package:codehero/utils/drawer_widget.dart';
import 'package:codehero/app/profile/view/widget/profile_avatar_widget.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Image.asset(
          "assets/images/marvel_logo.png",
          fit: BoxFit.fitHeight,
          height: 40,
        ),
      ),
      body: Column(
        children: <Widget>[
          ProfileAvatarWidget(),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Favorite Hero Character\n\n\nComing soon...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.merge(
                  const TextStyle(fontSize: 25, color: Colors.black),
                ),
          ),
        ],
      ),
    );
  }
}
