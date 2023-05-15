import 'package:flutter/material.dart';

import '../environment/spacing.dart';

class PrimaryDrawer extends StatelessWidget {
  const PrimaryDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: theme.colorScheme.primary,
            width: Spacing.s2,
          ),
        ),
      ),
      child: const Drawer(),
    );
  }
}
