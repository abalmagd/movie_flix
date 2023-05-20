import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppLifeCyclesWrapper extends ConsumerStatefulWidget {
  const AppLifeCyclesWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  ConsumerState<AppLifeCyclesWrapper> createState() =>
      _AppLifeCyclesWrapperState();
}

class _AppLifeCyclesWrapperState extends ConsumerState<AppLifeCyclesWrapper>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
