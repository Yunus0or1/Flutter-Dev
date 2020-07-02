import 'package:axiluniv/src/configs/server_config.dart';

class AuthCredential {
  final int userId;
  final String domain;
  final String jwtToken;
  final String jwtAlgorithm;
  final String tokenExpiredTime;

  AuthCredential({
    this.userId,
    this.domain,
    this.jwtToken,
    this.jwtAlgorithm,
    this.tokenExpiredTime,
  });


  AuthCredential.blank()
      : userId = 0,
        domain = ServerConfig.SERVER_HOST,
        jwtToken = "dummyToken",
        jwtAlgorithm = "SHA256",
        tokenExpiredTime = '01-07-2100';


  factory AuthCredential.fromJson(Map<String, dynamic> json) {
    return AuthCredential(
      userId: json['userId'],
      domain: json['domain'],
      jwtToken: json['jwtToken'],
      jwtAlgorithm: json['jwtAlgorithm'],
      tokenExpiredTime: json['tokenExpiredTime'],
    );
  }

  Map<String, dynamic> toJsonMap() {
    final data = Map<String, dynamic>();
    data['userId'] = userId;
    data['domain'] = domain;
    data['jwtToken'] = jwtToken;
    data['jwtAlgorithm'] = jwtAlgorithm;
    data['tokenExpiredTime'] = tokenExpiredTime;
    return data;
  }
}
