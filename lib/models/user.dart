class User {
  final String uid;

  User({this.uid});
}

class UserProfileInfo {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String state;
  final String city;
  final String phoneNumber;

  UserProfileInfo(
      {this.uid,
      this.firstName,
      this.lastName,
      this.email,
      this.address,
      this.state,
      this.city,
      this.phoneNumber});

  factory UserProfileInfo.initialData() {
    return UserProfileInfo(
      firstName: '',
      lastName: '',
      phoneNumber: '',
      state: '',
      city: '',
      address: '',
    );
  }
}
