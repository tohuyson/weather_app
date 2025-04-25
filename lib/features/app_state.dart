part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({this.status = BlocStatus.initial});

  final BlocStatus status;

  @override
  List<Object?> get props => [status];

  AppState copyWith({BlocStatus? status}) {
    return AppState(status: status ?? this.status);
  }
}
