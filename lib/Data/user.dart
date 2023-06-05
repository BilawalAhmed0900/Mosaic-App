class User {
  int userId;
  String email;
  String userName;
  String oAuth2;
  String firstName;
  String lastName;

  User._(): userId = -1, email = "", userName = "", oAuth2 = "", firstName = "", lastName = "";

  static final User _user = User._();
  static User getInstance() {
    return _user;
  }
}