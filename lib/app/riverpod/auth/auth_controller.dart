import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/remote/api/auth/auth_service.dart';
import 'package:movie_flix/remote/environment_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

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

  void checkRequestToken() {
    final requestToken =
        _sharedPrefs.get(key: SharedPrefsKeys.requestToken) as String?;

    if (requestToken != null) {}
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

    const uuid = Uuid();

    await Future.delayed(const Duration(seconds: 2));

    setSession(session: Session.guest(uid: uuid.v1()));
  }

  Future<void> requestToken() async {
    state = state.copyWith(session: const AsyncValue.loading());

    final result = await _authService.requestToken();

    result.fold(
      (failure) => failure.toast(),
      (requestToken) async {
        _sharedPrefs.set(
            key: SharedPrefsKeys.requestToken, value: requestToken);
        final Uri url = Uri.parse(
          '${RemoteEnvironment.tmdbDomain}${RemoteEnvironment.auth}'
          '/access?request_token=$requestToken',
        );

        await launchUrl(url);
        setSession(session: Session.empty);
      },
    );
  }

  /// The [success] (Right) is always true because the false case is handled
  /// inside the repository
  Future<void> login() async {
    state = state.copyWith(session: const AsyncValue.loading());

    final result = await _authService.requestToken();
  }

  /// The [success] (Right) is always true because the false case is handled
  /// inside the repository
  void logout() async {
    if (state.session.value!.isGuest) {
      setSession(session: Session.empty);
      return;
    }

    state = state.copyWith(session: const AsyncValue.loading());

    final result = await _authService.logout(
        accessToken: state.session.value!.accessToken);

    result.fold(
      (failure) => failure.toast(),
      (success) => setSession(session: Session.empty),
    );
  }
}
