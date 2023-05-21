import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/app/riverpod/auth/auth_controller.dart';

class AppLifeCyclesWrapper extends ConsumerStatefulWidget {
  const AppLifeCyclesWrapper({
    Key? key,
    required this.child,
    required this.ref,
  }) : super(key: key);

  final Widget child;
  final WidgetRef ref;

  @override
  ConsumerState<AppLifeCyclesWrapper> createState() =>
      _AppLifeCyclesWrapperState();
}

class _AppLifeCyclesWrapperState extends ConsumerState<AppLifeCyclesWrapper>
    with WidgetsBindingObserver {
  late final AuthController auth;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        auth.setSession();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    auth = widget.ref.read(authControllerProvider.notifier);
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
}
