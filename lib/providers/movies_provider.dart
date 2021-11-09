import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/models/models.dart';
import 'package:flutter_movie_app/helpers/debouncer.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl  = 'api.themoviedb.org';
  String _apiKey   = '';
  String _language = 'en-US';

  List<Movie> onDisplayCardMovies = [];
  List<Movie> onDisplayCardPopularMovies = [];
  List<Movie> onDisplayCardTopRatedMovies = [];
  Map<int, List<Cast>> moviesCasting = {};

  //To increment pagination for Popular movies
  int _popularPage = 0;
  int _topRatedPage = 0;

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  //Streams
  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    print('MoviesProvider Running');
    this.getOnDisplayNowPlayingMovies();
    this.getOnDisplayPopularMovies();
    this.getOnDisplayTopRatedMovies();
    //_suggestionStreamController.close();
  }

  Future<String> _getJsonData(String segmentUrl, [int page=1]) async {
    final url = Uri.https(this._baseUrl, segmentUrl, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page',
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayNowPlayingMovies() async {

    final jsonData = await this._getJsonData('3/movie/now_playing');
    
    //Call movie instance (Model)
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    //final Map<String, dynamic> decodedData = json.decode(response.body);
    //print(nowPlayingResponse.results[2].title);
    
    this.onDisplayCardMovies = nowPlayingResponse.results;
    
    //Notify widgets when data are changing
    notifyListeners();
  }

  getOnDisplayPopularMovies() async {

    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    //Call movie instance (Model)
    final popularResponse = PopularResponse.fromJson(jsonData);

    this.onDisplayCardPopularMovies = [...onDisplayCardMovies, ...popularResponse.results];

    //Notify widgets when data are changing
    notifyListeners();
  }

  getOnDisplayTopRatedMovies() async {

    _topRatedPage++;

    final jsonData = await this._getJsonData('3/movie/top_rated', _topRatedPage);
    //Call model
    final topRatedResponse = TopRatedResponse.fromJson(jsonData);
    this.onDisplayCardTopRatedMovies = topRatedResponse.results;

    //Notify widgets when data are changing
    notifyListeners();

  }

  Future<List<Cast>> getMovieCasting(int movieId) async {
    
    //Check map to load info without another request
    if(moviesCasting.containsKey(movieId)) return moviesCasting[movieId]!;

    print('Requesting casting info');

    final jsonData = await this._getJsonData('3/movie/$movieId/credits'); 
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCasting[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  //To seach movies via query param
  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(this._baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query': query
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final searchResponse = SearchMovieResponse.fromJson(response.body);

    return searchResponse.results;
  }

  //To debouncer query
  void getSuggestionsByQuery(String searchWord) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      //When deboucer emit a value
      //print('Have a value to search: $value');
      final results = await this.searchMovie(value);
      //Add event with results for stream
      this._suggestionStreamController.add(results);
    };

    //When stop debouncer typing
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchWord;
    });

    //Cancel timer periodic execution
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

}