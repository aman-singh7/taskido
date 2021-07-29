const signInErrorCodes = <String, String>{
  'user-not-found': 'User not Found',
  'wrong-password': 'Either eamil or password is wrong',
};

const signUpErrorCodes = <String, String>{
  'weak-password': 'The password is too weak',
  'email-already-in-use': 'An account already exists for this email',
};

const passwordResetErrorCodes = <String, String>{
  'auth/invalid-email': 'Enter a valid email',
  'auth/user-not-found': 'User not found',
};

const String taskKey = 'task';
const String userKey = 'user';
const String taskMapKey = 'taskMap';

const Map<int, String> weekDays = {
  1: 'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun',
};
