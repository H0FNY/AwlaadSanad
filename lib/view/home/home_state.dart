import '../../model/group_model.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Group> groups;
  const HomeSuccess(this.groups);
}

class HomeFailure extends HomeState {
  final String error;
  const HomeFailure(this.error);
}
