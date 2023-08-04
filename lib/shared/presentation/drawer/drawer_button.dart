import 'package:flutter/material.dart';

import '../../../config/theme/palette.dart';

class PrimaryDrawerButton extends StatelessWidget {
  const PrimaryDrawerButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.route,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;

  /// Send the route name of the screen and it will be compared internally
  /// then change icon colors to theme default if current route matches passed
  /// route.
  final String? route;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;
    return ListTile(
      title: Text(text),
      leading: CircleAvatar(
        backgroundColor: Palette.transparent,
        child: Icon(
          icon,
          color: currentRoute == route
              ? theme.colorScheme.primary
              : theme.iconTheme.color,
        ),
      ),
      visualDensity: VisualDensity.compact,
      trailing: isLoading
          ? SizedBox(
              width: 18,
              height: 18,
              child:
                  CircularProgressIndicator(color: theme.colorScheme.primary),
            )
          : Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: currentRoute == route ? theme.colorScheme.primary : null,
            ),
      splashColor: theme.colorScheme.primary,
      onTap: onTap,
    );
  }
}
