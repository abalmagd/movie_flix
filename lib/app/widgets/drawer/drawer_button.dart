import 'package:flutter/material.dart';

import '../../environment/spacing.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(text),
      leading: Icon(icon, color: color),
      trailing: Icon(Icons.arrow_forward_ios, size: Spacing.s16, color: color),
      splashColor: theme.colorScheme.primary,
      onTap: onTap,
    );
  }
}
