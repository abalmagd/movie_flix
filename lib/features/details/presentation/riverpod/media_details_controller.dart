import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_flix/utils/utils.dart';

import '../../data/media_details_service.dart';
import 'media_details_state.dart';

final mediaDetailsControllerProvider =
    StateNotifierProvider<MediaDetailsController, MediaDetailsState>(
  (ref) {
    return MediaDetailsController(
      const MediaDetailsState(
        mediaDetails: AsyncLoading(),
      ),
      ref.read(baseMediaDetailsServiceProvider),
    );
  },
);

class MediaDetailsController extends StateNotifier<MediaDetailsState> {
  late final BaseMediaDetailsService _mediaDetailsService;

  MediaDetailsController(MediaDetailsState state, this._mediaDetailsService)
      : super(state) {
    Utils.logPrint(message: 'Building $runtimeType');
  }

  Future<void> test({required int id}) async {
    final result = await _mediaDetailsService.getMovieDetails(movieId: id);

    result.fold(
      (failure) => print(failure.message),
      (details) => state = state.copyWith(mediaDetails: AsyncData(details)),
    );
  }
}
