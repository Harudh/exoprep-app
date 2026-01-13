class AppEndpoints {
  AppEndpoints._();

  // static const String baseURL = 'http://3.109.221.178:5432';
  static const String baseURL = 'http://localhost:4000';

  /*----------------- Auth Endpoints -------------------*/
  static String get user => '$baseURL/api/v1/users';

  static String get getUser => '$baseURL/api/v1/users/me';

  /*----------------- Select Exams Endpoints -------------------*/
  static String get getExams => '$baseURL/api/v1/exams';

  /*----------------- Papers Endpoints -------------------*/
  static String getPapers(String query) => '$baseURL/api/v1/papers?$query';
}
