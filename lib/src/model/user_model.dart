import 'dart:convert';

sealed class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelAdm.fromMap(json),
      _ => throw ArgumentError('User profile not found')
    };
  }
}

class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;

  UserModelAdm({
    this.workDays,
    this.workHours,
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
  });

  Map<String, dynamic> toMap() {
    return {
      'workDays': workDays,
      'workHours': workHours,
    };
  }

  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdm(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModelAdm.fromJson(String source) =>
      UserModelAdm.fromMap(json.decode(source));
}

class UserModelEmployee extends UserModel {
  final List<String> workDays;
  final List<int> workHours;
  final int barberShopId;

  UserModelEmployee({
    required this.workDays,
    required this.workHours,
    required this.barberShopId,
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barberShopId': final int barberShopId,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          barberShopId: barberShopId,
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError('Invalid Json'),
    };
  }
}
