import 'package:flutter/material.dart';

class NetworkFadingImage extends StatelessWidget {
  const NetworkFadingImage({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      path,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 2),
          curve: Curves.easeOut,
          child: child,
        );
      },
      errorBuilder: (_, __, ___) {
        return const SizedBox.shrink();
      },
      filterQuality: FilterQuality.none,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
