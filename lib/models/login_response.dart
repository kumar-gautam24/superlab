

import 'user_model.dart';

class LoginResponse {
  final UserModel user;

  LoginResponse({required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
   
    final userJson = json['data']['user']; 
    if (userJson == null) {
      print('User data not found in response');
    }

    return LoginResponse(
      user: UserModel.fromJson(userJson), 
    );
  }
}
