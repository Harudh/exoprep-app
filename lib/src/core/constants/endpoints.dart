class AppEndpoints {
  AppEndpoints._();

  // static const String baseURL = 'http://3.109.221.178:5432';
  static const String baseURL = 'https://exoprep-server.harudh.in';

  /*----------------- Auth Endpoints -------------------*/
  static String get user => '$baseURL/api/v1/users';

  static String get getUser => '$baseURL/api/v1/users/me';

  /*----------------- Select Exams Endpoints -------------------*/
  static String get getExams => '$baseURL/api/v1/exams';

  static String get getUserExams => "$baseURL/api/v1/users/get-user-exams";

  static String getLeafExams({String? query}) => '$baseURL/api/v1/exams/leaf?search=${query ?? ""}';
  /*----------------- Papers Endpoints -------------------*/

  static String getPapers(String query) => '$baseURL/api/v1/papers?$query';

  static String getPaperDetails(String paperID) => '$baseURL/api/v1/papers/$paperID';

  static String getRecentAttempts(String query) => '$baseURL/api/v1/quiz/attempts?$query';

  static String getRecentlyAttemptedPaper(String attemptedPaperId) => '$baseURL/api/v1/quiz/attempts/$attemptedPaperId';

  static String getStreakHeatmap(String examId, String query) => '$baseURL/api/v1/leaderboard/exam/$examId/heatmap?$query';

  /*----------------- Subjects Endpoints -------------------*/
  static String getSubjects(String query) => '$baseURL/api/v1/subjects?$query';

  /*----------------- Questions Endpoints -------------------*/
  static String getQuestions(String query) => '$baseURL/api/v1/questions?$query';

  static String get submitPaper => '$baseURL/api/v1/quiz/submit';

  /*----------------- Leaderboard Endpoints -------------------*/
  static String getStreakLeaderBoardByExam(String examID) =>
      '$baseURL/api/v1/leaderboard/exam/$examID/streak?limit=10&include_user_stats=true';

  static String getScoreLeaderBoardByExam(String examID) =>
      '$baseURL/api/v1/leaderboard/exam/$examID/points?limit=10&include_user_stats=true';
}
