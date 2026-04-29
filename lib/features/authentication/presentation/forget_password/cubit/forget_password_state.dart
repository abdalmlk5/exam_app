import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base_state/base_state.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<String?> forgetPasswordState;

  const ForgetPasswordState({
    this.forgetPasswordState = const BaseState<String?>(isLoading: false),
  });

  ForgetPasswordState copyWith({BaseState<String?>? stateParam}) {
    return ForgetPasswordState(
      forgetPasswordState: stateParam ?? forgetPasswordState,
    );
  }

  @override
  List<Object?> get props => [forgetPasswordState];
}
