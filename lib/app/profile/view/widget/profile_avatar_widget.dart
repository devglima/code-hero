import 'package:codehero/app/profile/view/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileAvatarWidget extends StatelessWidget {
  ProfileAvatarWidget({
    Key? key,
  }) : super(key: key);

  final ProfileCubit _profileCubit = Modular.get<ProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 30),
      decoration: const BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                    child: Icon(Icons.person, color: Colors.white, size: 150)),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            _profileCubit.state!.user_name ?? " ",
            style: Theme.of(context).textTheme.headlineMedium!.merge(
                  const TextStyle(fontSize: 24, color: Colors.white),
                ),
          ),
          Text(
            _profileCubit.state!.email ?? " ",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .merge(const TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
