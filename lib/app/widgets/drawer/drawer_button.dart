import 'package:flutter/material.dart';

import '../../environment/spacing.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: color),
      trailing: isLoading
          ? SizedBox(
              width: Spacing.s18,
              height: Spacing.s18,
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : Icon(Icons.arrow_forward_ios, size: Spacing.s16, color: color),
      splashColor: theme.colorScheme.primary,
      onTap: () => onTap(),
    );
  }
}
