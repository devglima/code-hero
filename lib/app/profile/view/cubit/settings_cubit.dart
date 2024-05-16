import 'package:codehero/app/profile/domain/models/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<Profile?> {
  ProfileCubit() : super(Profile());

  void setUserProfile(Profile? profile) {
    emit(profile);
  }
}
