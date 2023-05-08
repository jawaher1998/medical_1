class LogInWithEmailAndPasswordFailure {
  final String message;
  const LogInWithEmailAndPasswordFailure(
      [this.message = "البريد غير مسجل "]);
  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
            ' كلمة مرور خاطئة.');
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
            'البريد غير صالح. الرجاء ادخال بريد صحيح.');
      case "email-already-in-use":
        return const LogInWithEmailAndPasswordFailure(
            'هذا البريد مسجل مسبقا.');
      case 'operation-not-allowed':
        return const LogInWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support.');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
            "This user has been disabled. Please contact support for help.");
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}
