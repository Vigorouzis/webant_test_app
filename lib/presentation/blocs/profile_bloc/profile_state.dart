import 'package:webant_test_app/data/models/user.dart';

abstract class ProfileState {
  const ProfileState();
}

class InitProfileState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final User user;

  ProfileSuccess({required this.user});
}

class ProfileFailed extends ProfileState {}