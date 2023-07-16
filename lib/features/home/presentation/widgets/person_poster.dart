import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/shared/data/environment_variables.dart';
import 'package:movie_flix/shared/presentation/frosted_container.dart';

import '../../../../config/theme/palette.dart';
import '../../../../utils/strings.dart';
import '../../domain/person.dart';

class PersonPoster extends ConsumerStatefulWidget {
  const PersonPoster({
    Key? key,
    required this.person,
  }) : super(key: key);

  final Person person;

  @override
  ConsumerState<PersonPoster> createState() => _PersonPosterState();
}

class _PersonPosterState extends ConsumerState<PersonPoster> {
  int t = 0;
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GestureDetector(
          onTap: () => setState(() {
            showInfo = !showInfo;
          }),
          child: Stack(
            children: [
              Image.network(
                '${RemoteEnvironment.tmdbImage}${RemoteEnvironment.posterQuality}${widget.person.profilePath}?t=$t',
                errorBuilder: (_, __, ___) {
                  Timer(const Duration(seconds: 5), () {
                    setState(() {
                      t++;
                    });
                  });
                  return const SizedBox.shrink();
                },
                filterQuality: FilterQuality.none,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              AnimatedOpacity(
                opacity: showInfo ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: FrostedContainer(
                  tightPadding: true,
                  borderRadius: 0,
                  blurStrength: 12,
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4,
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.person.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Palette.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Strings.knownFor,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodySmall
                                    ?.copyWith(color: Palette.white),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 4,
                                    runSpacing: 8,
                                    children: widget.person.knownFor
                                        .map(
                                          (media) => Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Palette.white
                                                  .withOpacity(0.24),
                                              border: Border.all(
                                                color: Palette.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              media.title,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: Palette.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              Text(
                                widget.person.knownForDepartment,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Palette.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: theme.elevatedButtonTheme.style?.copyWith(
                          minimumSize: MaterialStateProperty.all(
                            const Size.fromHeight(32),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(Strings.explore),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
