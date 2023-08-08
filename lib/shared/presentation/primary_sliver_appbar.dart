import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_flix/shared/presentation/theme_icon_button.dart';

import '../../config/constants.dart';
import '../../config/riverpod/config_controller.dart';
import '../../config/theme/palette.dart';
import '../../utils/assets.dart';
import 'frosted_container.dart';

class PrimarySliverAppBar extends ConsumerWidget {
  const PrimarySliverAppBar({
    Key? key,
    this.collapsedTitle,
    this.expandedTitle,
    this.collapsedImage,
    this.expandedImage,
    this.collapseMode,
    this.isLoading = false,
    this.inverseColors = false,
    this.bottom,
  }) : super(key: key);

  final Widget? collapsedTitle;
  final Widget? expandedTitle;
  final Widget? collapsedImage;
  final Widget? expandedImage;
  final CollapseMode? collapseMode;
  final bool isLoading;
  final bool inverseColors;
  final PreferredSize? bottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final call = ref.read(configControllerProvider.notifier);
    final maxHeight = (size.height * Constants.sliverAppBarMaxHeightFactor) +
        MediaQuery.of(context).padding.top;
    final appBarHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
    return SliverAppBar(
      pinned: true,
      bottom: bottom,
      systemOverlayStyle: inverseColors ? null : SystemUiOverlayStyle.light,
      leading: FrostedContainer(
        outerPadding: const EdgeInsets.all(8),
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.drawerIcon,
            colorFilter: ColorFilter.mode(
              inverseColors ? theme.iconTheme.color! : Palette.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: Scaffold.of(context).openDrawer,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      expandedHeight: size.height * Constants.sliverAppBarMaxHeightFactor,
      title: isLoading
          ? SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : collapsedTitle,
      actions: [
        FrostedContainer(
          outerPadding: const EdgeInsets.symmetric(vertical: 8),
          borderRadius: 20,
          child: ThemeIconButton(
            color: inverseColors ? theme.iconTheme.color : Palette.white,
          ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: isLoading
          ? null
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double height = constraints.maxHeight;
                return Stack(
                  children: [
                    if (collapsedImage != null)
                      Positioned.fill(child: collapsedImage!),
                    FlexibleSpaceBar(
                      expandedTitleScale: 1.3,
                      title: AnimatedOpacity(
                        duration: const Duration(milliseconds: 0),
                        opacity: height == appBarHeight
                            ? 0
                            : (height - appBarHeight) /
                                (maxHeight - appBarHeight),
                        child: expandedTitle,
                      ),
                      titlePadding: EdgeInsets.zero,
                      collapseMode: collapseMode ?? CollapseMode.parallax,
                      background: expandedImage,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
