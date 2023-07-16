import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_flix/features/auth/data/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/data/environment_variables.dart';
import '../../../../shared/data/local_storage.dart';
import '../../../../utils/utils.dart';
import '../../domain/session.dart';
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

    Utils.logPrint(message: 'Building $runtimeType');
    logData(session: session);
    return AuthState(session: session);
  }

  void logData({Session? session}) {
    Utils.logPrint(message: (session ?? state.value?.session).toString());
  }

  void setSession({Session? session}) {
    if (session != null) {
      state = AsyncData(state.value!.copyWith(session: session));
      _sharedPrefs.set(
        key: SharedPrefsKeys.session,
        value: session.toRawJson(),
      );

      logData();
      return;
    }

    final sessionRequestJson =
        _sharedPrefs.get(key: SharedPrefsKeys.sessionRequest) as String?;

    if (sessionRequestJson != null) {
      final sessionRequest = jsonDecode(sessionRequestJson);
      final String expiresAt = sessionRequest['expires_at'];
      state = AsyncData(
        state.value!.copyWith(
          requestToken: sessionRequest['request_token'],
          expiresAt: sessionRequest['expires_at'],
        ),
      );
      final now = DateTime.now();
      final dateString = expiresAt.replaceAll(' UTC', 'Z').trim();
      if (DateTime.parse(dateString).toLocal().isAfter(now)) {
        login();
      }
    }
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

  void requestToken() async {
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

        state = AsyncData(
          state.value!.copyWith(
            requestToken: sessionRequest['request_token'],
            expiresAt: sessionRequest['expires_at'],
          ),
        );

        final Uri url = Uri.parse(
          '${RemoteEnvironment.tmdbDomain}'
          'authenticate/${sessionRequest['request_token']}',
        );

        await launchUrl(url, mode: LaunchMode.externalApplication)
            ? null
            : Utils.toast(
                message:
                    'Failed to redirect, please make sure you have a browser',
                severity: ToastSeverity.danger,
                length: Toast.LENGTH_LONG,
              );
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
      Utils.toast(message: 'Logout Success!');
      return;
    }

    final result =
        await _authService.logout(sessionId: state.value!.session.sessionId);

    result.fold(
          (failure) {
        state = AsyncError(failure, StackTrace.current);
        failure.toast();
      },
      (success) {
        setSession(session: Session.empty);
        Utils.toast(message: 'Logout Success!');
      },
    );
  }
}
