class RemoteEnvironment {
  static const apiKeyV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZTE0MTg5YTBiNmE2YjRlZWEzNDZlNzMxNzc1Y2FlMyIsInN1YiI6IjYyNjMwMzE3ZjQ5NWVlMGUxMjk5Nzg0MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hjkGjKyFyqvOyHZP_XR0ePyuuG4e-czUD24vSFbuCrs';

  static const baseUrl = 'https://api.themoviedb.org/3';

  static const tmdbDomain = 'https://www.themoviedb.org/';
  static const gravatar = 'https://www.gravatar.com/avatar/';
  static const tmdbImage = 'https://image.tmdb.org/t/p/';
  static const posterQuality = 'w342';
  static const backdropQuality = 'w780';

  static const authentication = '/authentication';
  static const session = '$authentication/session';
  static const newSession = '$authentication/session/new';
  static const newGuestSession = '$authentication/guest_session/new';
  static const createRequestToken = '$authentication/token/new';

  static const account = '/account';

  static const discover = '/discover';

  static const movie = '/movie';
  static const popularMovies = '$movie/popular';
  static const topRatedMovies = '$movie/top_rated';
  static const nowPlayingMovies = '$movie/now_playing';
  static const upcomingMovies = '$movie/upcoming';
  static const trendingMovies = '/trending/movie/day';

  static const series = '/tv';
  static const discoverSeries = '$discover$series';
  static const topRatedSeries = '$series/top_rated';
  static const trendingSeries = '/trending/$series/day';

  static const genre = '/genre';
  static const movieGenres = '$genre$movie/list';
  static const seriesGenres = '$genre$series/list';

  static const person = '/person';
  static const popularPersons = '$person/popular';
  static const trendingPersons = '/trending/$person';
}
