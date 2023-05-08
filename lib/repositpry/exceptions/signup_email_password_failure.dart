class SignUpWithEmailAndPasswordFailure {
  final String message;
  const SignUpWithEmailAndPasswordFailure(
      [this.message = "حدث خطأ غير متوقع"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            ' الرجاء ادخال كلمة مرور اقوى.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'البريد غير صالح. الرجاء ادخال بريد صحيح.');
      case "email-already-in-use":
        return const SignUpWithEmailAndPasswordFailure(
            'هذا البريد مسجل مسبقا.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            "This user has been disabled. Please contact support for help.");
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
