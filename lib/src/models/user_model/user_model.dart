class UserModel {
  final String uid;
  final String name;
  final String email;
  final List<String> exams;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final String loginMode;
  final String profilePic;
  final bool isActive;

  const UserModel({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.exams = const [],
    this.createdAt,
    this.lastLogin,
    this.loginMode = '',
    this.profilePic = '',
    this.isActive = false,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const UserModel();
    }

    return UserModel(
      uid: json['uid']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',

      exams: (json['exams'] as List?)?.map((e) => e.toString()).toList() ?? const [],

      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'].toString()) : null,

      lastLogin: json['last_login'] != null ? DateTime.tryParse(json['last_login'].toString()) : null,

      loginMode: json['login_mode']?.toString() ?? '',
      profilePic: json['profile_pic']?.toString() ?? '',
      isActive: json['is_active'] is bool ? json['is_active'] as bool : false,
    );
  }

  /// Optional: convert back to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'exams': exams,
      'created_at': createdAt?.toIso8601String(),
      'last_login': lastLogin?.toIso8601String(),
      'login_mode': loginMode,
      'profile_pic': profilePic,
      'is_active': isActive,
    };
  }
}
