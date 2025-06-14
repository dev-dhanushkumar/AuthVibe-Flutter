import 'dart:core';

class User {
  String email;
  String password;
  User(this.email, this.password);
}
class SignupUser {
  String name;
  String email;
  String password;
  String confirmPassword;
  SignupUser(this.name, this.email, this.password, this.confirmPassword);
}
