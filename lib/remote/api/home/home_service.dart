import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_repository.dart';

abstract class BaseHomeService {}

final baseHomeServiceProvider = Provider<BaseHomeService>((ref) {
  return HomeService(ref.watch(baseHomeRepositoryProvider));
});

class HomeService implements BaseHomeService {
  HomeService(this._baseHomeRepository);

  final BaseHomeRepository _baseHomeRepository;
}
