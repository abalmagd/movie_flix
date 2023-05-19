import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/remote/api/auth/auth_service.dart';

import '../../../core/local_storage.dart';
import '../../../core/utils.dart';
import '../../models/session.dart';
import 'auth_state.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) {
    return AuthController(
      const AuthState(
        session: AsyncValue.data(Session.empty),
      ),
      ref.watch(sharedPrefsProvider),
      ref.watch(baseAuthServiceProvider),
    );
  },
);

class AuthController extends StateNotifier<AuthState> {
  AuthController(
    AuthState state,
    this._sharedPrefs,
    this._authService,
  ) : super(state) {
    setSession();
    logData();
  }

  final SharedPrefs _sharedPrefs;
  final BaseAuthService _authService;

  @override
  void dispose() {
    /*Comment to hide warning*/
    super.dispose();
  }

  void logData() {
    Utils.logPrint(
      message: state.session.asData?.value.toString() ?? '',
      name: 'Session Data',
    );
  }

  void setSession({Session? session}) {
    if (session != null) {
      state = state.copyWith(
        session: AsyncValue.data(session),
      );
      _sharedPrefs.set(
        key: SharedPrefsKeys.session,
        value: session.toRawJson(),
      );
      if (session == Session.empty) Utils.toast(message: 'Logout success!');
      if (session != Session.empty) Utils.toast(message: 'Login success!');
      return;
    }

    final sessionString = _sharedPrefs.get(key: SharedPrefsKeys.session);
    if (sessionString != null) {
      state = state.copyWith(
        session: AsyncValue.data(Session.fromRawJson(sessionString as String)),
      );
    }
  }

  Future<void> loginAsGuest() async {
    state = state.copyWith(session: const AsyncValue.loading());

    final result = await _authService.loginAsGuest();

    result.fold(
      (failure) {
        state = state.copyWith(
          session: AsyncValue.error(failure, StackTrace.current),
        );
        failure.toast();
      },
      (session) => setSession(session: session),
    );
  }

  /// The [success] (Right) is always true because the false case is handled
  /// inside the repository
  void logout() async {
    if (state.session.value!.isGuest) {
      setSession(session: Session.empty);
      return;
    }

    state = state.copyWith(session: const AsyncValue.loading());

    final result =
        await _authService.logout(sessionId: state.session.value!.sessionId);

    result.fold(
      (failure) => failure.toast(),
      (success) => setSession(session: Session.empty),
    );
  }
}
