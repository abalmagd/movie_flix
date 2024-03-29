import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/features/auth/presentation/riverpod/auth_controller.dart';


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
  late final AuthController authController;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    authController = widget.ref.read(authControllerProvider.notifier);
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
        authController.setSession();
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
