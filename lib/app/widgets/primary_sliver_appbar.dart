import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_flix/app/widgets/theme_icon_button.dart';

import '../environment/assets.dart';
import '../environment/constants.dart';
import '../environment/spacing.dart';
import '../riverpod/config/config_controller.dart';
import '../theme/palette.dart';
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
  }) : super(key: key);

  final Widget? collapsedTitle;
  final Widget? expandedTitle;
  final Widget? collapsedImage;
  final Widget? expandedImage;
  final CollapseMode? collapseMode;
  final bool isLoading;
  final bool inverseColors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery
        .of(context)
        .size;
    final call = ref.read(configControllerProvider.notifier);
    final maxHeight = (size.height * Constants.sliverAppBarMaxHeightFactor) +
        MediaQuery
            .of(context)
            .padding
            .top;
    final appBarHeight = kToolbarHeight + MediaQuery
        .of(context)
        .padding
        .top;
    return SliverAppBar(
      pinned: true,
      systemOverlayStyle: inverseColors ? null : SystemUiOverlayStyle.light,
      leading: FrostedContainer(
        tightPadding: true,
        borderRadius: Spacing.s14,
        child: IconButton(
          icon: SvgPicture.asset(
            Assets.drawerIcon,
            colorFilter: ColorFilter.mode(
              inverseColors ? theme.iconTheme.color! : Palette.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: Scaffold
              .of(context)
              .openDrawer,
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      expandedHeight: size.height * Constants.sliverAppBarMaxHeightFactor,
      title: isLoading
          ? SizedBox(
        width: Spacing.s22,
        height: Spacing.s22,
        child: CircularProgressIndicator(
          color: theme.colorScheme.primary,
        ),
      )
          : FrostedContainer(child: collapsedTitle),
      actions: [
        FrostedContainer(
          tightPadding: true,
          child: ThemeIconButton(
            onPressed: () => call.changeThemeMode(context),
            color: inverseColors ? theme.iconTheme.color : Palette.white,
          ),
        ),
        FrostedContainer(
          tightPadding: true,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
            color: inverseColors ? theme.iconTheme.color : Palette.white,
          ),
        ),
      ],
      flexibleSpace: isLoading
          ? null
          : LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double height = constraints.maxHeight;
          return Stack(
            children: [
              Opacity(
                opacity:
                (collapsedImage != null && height <= appBarHeight * 2)
                    ? 1
                    : 0,
                child: Positioned.fill(child: collapsedImage!),
              ),
              FlexibleSpaceBar(
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
