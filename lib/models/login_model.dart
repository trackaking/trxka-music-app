class Login {
  final bool success;
  final bool validUserInfo;
  final bool validPassword;
  final String message;

  const Login({
    required this.success,
    required this.validUserInfo,
    required this.validPassword,
    required this.message,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      success: json['success'],
      validUserInfo: json['validUserInfo'],
      validPassword: json['validPassword'],
      message: json['message'],
    );
  }
}
