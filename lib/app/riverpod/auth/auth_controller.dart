import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/remote/api/auth/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/local_storage.dart';
import '../../../core/utils.dart';
import '../../../remote/environment_variables.dart';
import '../../models/auth/session.dart';
import 'auth_state.dart';

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthState>(AuthController.new);

class AuthController extends AsyncNotifier<AuthState> {
  late final SharedPrefs _sharedPrefs;
  late final BaseAuthService _authService;

  @override
  FutureOr<AuthState> build() {
    _sharedPrefs = ref.read(sharedPrefsProvider);
    _authService = ref.read(baseAuthServiceProvider);

    final sessionString = _sharedPrefs.get(key: SharedPrefsKeys.session) ?? '';

    final session = (sessionString as String).isNotEmpty
        ? Session.fromRawJson(sessionString)
        : Session.empty;

    logData(session: session);
    return AuthState(session: session);
  }

  void logData({Session? session}) {
    Utils.logPrint(message: (session ?? state.value?.session).toString());
  }

  void setLocalSession() {
    state = const AsyncLoading();
    final sessionString = _sharedPrefs.get(key: SharedPrefsKeys.session) ?? '';

    final session = (sessionString as String).isNotEmpty
        ? Session.fromRawJson(sessionString)
        : Session.empty;

    state = AsyncData(state.value!.copyWith(session: session));
  }

  void setSession({Session? session}) {
    if (session != null) {
      state = AsyncData(state.value!.copyWith(session: session));
      _sharedPrefs.set(
        key: SharedPrefsKeys.session,
        value: session.toRawJson(),
      );
      Utils.toast(
        message: session == Session.empty ? 'Logout Success' : 'Login Success',
        severity: ToastSeverity.ok,
      );
      logData();
      return;
    }

    final requestToken =
        _sharedPrefs.get(key: SharedPrefsKeys.sessionRequest) as String?;

    if (requestToken != null) {
      final sessionRequest = jsonDecode(requestToken);
      state = AsyncData(
        state.value!.copyWith(
          requestToken: sessionRequest['request_token'],
          expiresAt: sessionRequest['expires_at'],
        ),
      );

      final now = DateTime.now();

      if (DateTime.parse(state.value!.expiresAt).isAfter(now)) login();
      return;
    }

    setLocalSession();
  }

  void loginAsGuest() async {
    state = const AsyncLoading();

    final result = await _authService.loginAsGuest();

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        failure.toast();
      },
      (session) => setSession(session: session),
    );
  }

  Future<void> requestToken() async {
    state = const AsyncLoading();

    final result = await _authService.createRequestToken();

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        failure.toast();
      },
      (sessionRequest) async {
        _sharedPrefs.set(
          key: SharedPrefsKeys.sessionRequest,
          value: jsonEncode(sessionRequest),
        );

        final Uri url = Uri.parse(
          '${RemoteEnvironment.tmdbDomain}'
          'auth/access?request_token=${sessionRequest['request_token']}',
        );
        await launchUrl(url, mode: LaunchMode.externalApplication);

        state = AsyncData(
          state.value!.copyWith(
            requestToken: sessionRequest['request_token'],
            expiresAt: sessionRequest['expires_at'],
          ),
        );

        setSession(session: Session.empty);
      },
    );
  }

  void login() async {
    state = const AsyncLoading();

    final result =
        await _authService.login(requestToken: state.value!.requestToken);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        failure.toast();
      },
      (session) {
        setSession(session: session);
        _sharedPrefs.remove(key: SharedPrefsKeys.sessionRequest);
        Utils.toast(message: 'Login Success!');
      },
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    if (state.value!.session.isGuest) {
      setSession(session: Session.empty);
      return;
    }

    final result =
        await _authService.logout(sessionId: state.value!.session.sessionId);

    result.fold(
      (failure) {
        state = AsyncError(failure, StackTrace.current);
        failure.toast();
      },
      (success) => setSession(session: Session.empty),
    );
  }
}
