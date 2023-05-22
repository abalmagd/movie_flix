import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/remote/api/auth/auth_service.dart';
import 'package:movie_flix/remote/environment_variables.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../core/local_storage.dart';
import '../../../core/utils.dart';
import '../../models/auth/session.dart';
import 'auth_state.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) {
    return AuthController(
      const AuthState(session: Session.empty),
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
    _sharedPrefs.clear();
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
      message: state.session.toString(),
      name: 'Session Data',
    );
  }

  void setSession({Session? session}) {
    if (session != null) {
      state = state.copyWith(session: session);
      _sharedPrefs.set(
        key: SharedPrefsKeys.session,
        value: session.toRawJson(),
      );
      state = state.copyWith(isLoading: false);
      logData();
      return;
    }

    final requestToken =
        _sharedPrefs.get(key: SharedPrefsKeys.requestToken) as String?;

    if (requestToken != null) {
      state = state.copyWith(requestToken: requestToken);
      login();
      return;
    }

    final sessionString = _sharedPrefs.get(key: SharedPrefsKeys.session);
    if (sessionString != null) {
      state = state.copyWith(
        session: Session.fromRawJson(sessionString as String),
        isLoading: false,
      );
    }
  }

  Future<void> loginAsGuest() async {
    state = state.copyWith(isLoading: true);

    const uuid = Uuid();

    setSession(session: Session.guest(uid: uuid.v1()));
    Utils.toast(message: 'Login Success!');
  }

  Future<void> requestToken() async {
    state = state.copyWith(isLoading: true);

    final result = await _authService.getRequestToken();

    result.fold(
      (failure) {
        failure.toast();
        state = state.copyWith(isLoading: false);
      },
      (requestToken) async {
        _sharedPrefs.set(
          key: SharedPrefsKeys.requestToken,
          value: requestToken,
        );

        final Uri url = Uri.parse(
          '${RemoteEnvironment.tmdbDomain}'
          'auth/access?request_token=$requestToken',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);

        state = state.copyWith(requestToken: requestToken);
        setSession(session: Session.empty);
      },
    );
  }

  /// The [success] (Right) is always true because the false case is handled
  /// inside the repository
  Future<void> login() async {
    state = state.copyWith(isLoading: true);

    final result = await _authService.login(requestToken: state.requestToken);

    result.fold(
      (failure) {
        setSession(session: Session.empty);
        failure.toast();
      },
      (session) {
        setSession(session: session);
        _sharedPrefs.remove(key: SharedPrefsKeys.requestToken);
        Utils.toast(message: 'Login Success!');
      },
    );
  }

  /// The [success] (Right) is always true because the false case is handled
  /// inside the repository
  void logout() async {
    state = state.copyWith(isLoading: true);

    Future.delayed(const Duration(seconds: 5));

    if (state.session.isGuest) {
      setSession(session: Session.empty);
      return;
    }

    final result =
        await _authService.logout(accessToken: state.session.accessToken);

    result.fold(
      (failure) {
        failure.toast();
        state = state.copyWith(isLoading: false);
      },
      (success) {
        setSession(session: Session.empty);
        Utils.toast(message: 'Logout Success!');
      },
    );
  }
}
