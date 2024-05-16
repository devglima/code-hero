import 'package:codehero/app/profile/view/ui/profile.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfileModule extends Module {
  @override
  void routes(r) {
    r.child(
      '/',
      child: ((context) => const ProfileWidget()),
      transition: TransitionType.rightToLeft,
    );
  }
}
