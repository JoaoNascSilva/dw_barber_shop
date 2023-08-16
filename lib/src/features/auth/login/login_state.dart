import 'package:flutter/material.dart';

enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus status;
  final String? errorMessage;

  LoginState({
    required this.status,
    this.errorMessage,
  });

  LoginState.initial()
      : this(
          status: LoginStateStatus.initial,
        );

  LoginState copyWith({
    LoginStateStatus? status,
    ValueGetter<String?>? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}
