class RemoteEnvironment {
  static const apiKeyV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZTE0MTg5YTBiNmE2YjRlZWEzNDZlNzMxNzc1Y2FlMyIsInN1YiI6IjYyNjMwMzE3ZjQ5NWVlMGUxMjk5Nzg0MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hjkGjKyFyqvOyHZP_XR0ePyuuG4e-czUD24vSFbuCrs';

  static const baseUrl = 'https://api.themoviedb.org/';
  static const v3 = '3';
  static const v4 = '4';

  static const tmdbDomain = 'https://www.themoviedb.org/';

  static const auth = '$v4/auth';
  static const requestToken = '$auth/request_token';
  static const accessToken = '$auth/access_token';
}
