class LoginResponse {
  final int id;
  final String token;

  const LoginResponse({required this.id, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
        id: json['id'],
        token: json['token']
    );
  }
}