class User {
  int userId;
  String email;
  String userName;
  String firstName;
  String lastName;
  String token;
  Map<int, String> interests;

  User._(): userId = -1, email = "", userName = "", firstName = "", lastName = "", token = "", interests = {};

  static final User _user = User._();
  static User getInstance() {
    return _user;
  }

  void clearUser() {
    userId = -1;
    email = "";
    userName = "";
    firstName = "";
    lastName = "";
    token = "";
    interests.clear();
  }
}