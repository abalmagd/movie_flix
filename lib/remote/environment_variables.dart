class RemoteEnvironment {
  static const apiKeyV4 =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZTE0MTg5YTBiNmE2YjRlZWEzNDZlNzMxNzc1Y2FlMyIsInN1YiI6IjYyNjMwMzE3ZjQ5NWVlMGUxMjk5Nzg0MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.hjkGjKyFyqvOyHZP_XR0ePyuuG4e-czUD24vSFbuCrs';

  static const tmdbDomain = 'https://www.themoviedb.org/';
  static const gravatar = 'https://www.gravatar.com/avatar/';

  static const baseUrl = 'https://api.themoviedb.org';
  static const v3 = '/3';
  static const v4 = '/4';

  static const v4Auth = '$v4/auth';
  static const v3Auth = '$v3/authentication';
  static const requestToken = '$v4Auth/request_token';
  static const accessToken = '$v4Auth/access_token';
  static const createSession = '$v3Auth/session/convert/4';

  static const account = '$v3/account';
}
