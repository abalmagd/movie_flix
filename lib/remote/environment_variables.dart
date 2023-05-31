class RemoteEnvironment {
  static const apiKeyV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZTE0MTg5YTBiNmE2YjRlZWEzNDZlNzMxNzc1Y2FlMyIsInN1YiI6IjYyNjMwMzE3ZjQ5NWVlMGUxMjk5Nzg0MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hjkGjKyFyqvOyHZP_XR0ePyuuG4e-czUD24vSFbuCrs';

  static const baseUrl = 'https://api.themoviedb.org/3';

  static const tmdbDomain = 'https://www.themoviedb.org/';
  static const gravatar = 'https://www.gravatar.com/avatar/';
  static const tmdbImage = 'https://image.tmdb.org/t/p/w1280';

  static const authentication = '/authentication';
  static const session = '$authentication/session';
  static const newSession = '$authentication/session/new';
  static const newGuestSession = '$authentication/guest_session/new';
  static const createRequestToken = '$authentication/token/new';

  static const account = '/account';

  static const movie = '/movie';
  static const popularMovies = '$movie/popular';
  static const topRatedMovies = '$movie/top_rated';
  static const nowPlayingMovies = '$movie/now_playing';
  static const upcomingMovies = '$movie/upcoming';
  static const latestMovie = '$movie/latest';
}
