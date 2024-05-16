import 'package:codehero/app/profile/view/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = Modular.get<ProfileCubit>();

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 50,
              color: Theme.of(context).hintColor.withOpacity(0.1),
            ),
            Theme(
              data: Theme.of(context).copyWith(
                dividerTheme: const DividerThemeData(color: Colors.transparent),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).hintColor.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(35)),
                  border: const Border.fromBorderSide(BorderSide.none),
                ),
                accountName: Text(
                  profileCubit.state!.user_name ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                accountEmail: Text(
                  profileCubit.state!.email ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                currentAccountPicture: Image.asset(
                  "assets/images/marvel_logo.png",
                  width: 60,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Modular.to.navigate('/home/');
              },
              leading: Icon(
                Icons.home_max,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Heroes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              onTap: () {
                Modular.to.navigate('/profile/');
              },
              leading: Icon(
                Icons.person_3,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Profile",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ListTile(
              onTap: () {
                profileCubit.setUserProfile(null);

                Modular.to.navigate("/auth/login");
              },
              leading: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).focusColor.withOpacity(1),
              ),
              title: Text(
                "Exit",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
