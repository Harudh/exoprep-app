enum AuthenticationMode { login, signup }

enum AuthLoadingType { login, signup, google, resetPassword }

enum AuthSuccessType { login, signup, google, resetPassword }

enum AuthErrorType { login, signup, google, resetPassword }

enum SelectExamSuccessType { examFetched, examUpdated }

enum SelectExamErrorType { examFetchError, examUpdateError }

enum ExamDashboardStates { streak, left, recents, practice }

enum TimeGoalFrequency { onetime, recurring }

enum TimeGoalRepeatingFrequency { daily, weekly, monthly }

enum AttemptPaperStates { fetchingData, dataFetched, dataFetchError }
