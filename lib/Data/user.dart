class User {
  String email;
  String userName;
  String oAuth2;
  String firstName;
  String lastName;

  User._(): email = "", userName = "", oAuth2 = "", firstName = "", lastName = "";

  static final User _user = User._();
  static User getInstance() {
    return _user;
  }
}