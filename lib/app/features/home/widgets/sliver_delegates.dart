import 'package:flutter/material.dart';

/// Used with the [SliverAppBar] inside [HomeScreen] main widget
/// Main purpose is the [TabBar] nested scroll & headers
class SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  SliverPersistentDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentDelegate oldDelegate) => true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: _tabBar,
    );
  }
}
