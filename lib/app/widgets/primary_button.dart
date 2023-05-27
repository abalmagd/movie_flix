import 'package:flutter/material.dart';
import 'package:movie_flix/app/environment/spacing.dart';

import '../environment/constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final double? width;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s16),
      child: ElevatedButton(
        style: theme.elevatedButtonTheme.style?.copyWith(
          minimumSize: MaterialStateProperty.all(
            Size(
              this.width ?? width / 2,
              Constants.defaultButtonHeight,
            ),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: Spacing.s18,
                width: Spacing.s18,
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: theme.elevatedButtonTheme.style?.textStyle?.resolve(
                  Set.identity(),
                ),
              ),
      ),
    );
  }
}
