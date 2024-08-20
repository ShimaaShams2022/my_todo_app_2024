class AppUser {
  String? authId;
  String? fullName;
  String? email;

  AppUser({this.authId, this.fullName, this.email});

  AppUser.fromFireStore(Map<String, dynamic>? dataFromDataBase)
      : this(
          authId: dataFromDataBase?['authId'],
          fullName: dataFromDataBase?['fullName'],
          email: dataFromDataBase?['email'],
        );
  Map<String, dynamic> toFireStore() {
    return {
      "authId": authId,
      "fullName": fullName,
      "email": email,
    };
  }
}
