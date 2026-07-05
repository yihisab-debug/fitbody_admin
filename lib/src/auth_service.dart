import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'constants.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _google = GoogleSignIn.instance;
  bool _initialized = false;

  Stream<User?> authStateChanges() => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<void> _ensureInit() async {
    if (_initialized) return;
    await _google.initialize(serverClientId: AppConstants.serverClientId);
    _initialized = true;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureInit();
    final account = await _google.authenticate(scopeHint: ['email']);
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw FirebaseAuthException(
          code: 'no-id-token', message: 'Не получен idToken от Google.');
    }
    final cred = GoogleAuthProvider.credential(idToken: idToken);
    return _auth.signInWithCredential(cred);
  }

  Future<void> signOut() async {
    await _ensureInit();
    await _google.signOut();
    await _auth.signOut();
  }
}
