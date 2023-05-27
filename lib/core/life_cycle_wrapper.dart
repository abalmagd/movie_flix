import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';

import '../app/riverpod/auth/auth_state.dart';

class AppLifeCycleWrapper extends ConsumerStatefulWidget {
  const AppLifeCycleWrapper({
    Key? key,
    required this.child,
    required this.ref,
  }) : super(key: key);

  final Widget child;
  final WidgetRef ref;

  @override
  ConsumerState<AppLifeCycleWrapper> createState() =>
      _AppLifeCycleWrapperState();
}

class _AppLifeCycleWrapperState extends ConsumerState<AppLifeCycleWrapper>
    with WidgetsBindingObserver {
  late final AuthController authCall;
  late final AsyncValue<AuthState> authWatch;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    authCall = widget.ref.read(authControllerProvider.notifier);
    final authWatch = widget.ref.watch(authControllerProvider);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        authCall.setSession();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
}
