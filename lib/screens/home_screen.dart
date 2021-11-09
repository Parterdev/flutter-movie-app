import 'package:flutter/material.dart';
import 'package:flutter_movie_app/providers/movies_provider.dart';
import 'package:flutter_movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movie_app/search/search_delegate.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //Provider
    final moviesProvider = Provider.of<MoviesProvider>(context);

    //print(moviesProvider.onDisplayCardMovies);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie App'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => showSearch(
              context: context, delegate: MovieSearchDelegate()
            ), 
            icon: Icon(Icons.search)
          )
        ],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Swiper cards
            CardSwiper(
              movies : moviesProvider.onDisplayCardMovies
            ),
            //Horizontal movies container
            MovieHorizontalSlider(
              movies: moviesProvider.onDisplayCardPopularMovies,
              title: 'Populars',
              onNextPage: () => {
                //print('Here: Execute another fetch'),
                moviesProvider.getOnDisplayPopularMovies(),
              }, //populars
            ),
            MovieHorizontalSlider(
              movies: moviesProvider.onDisplayCardTopRatedMovies,
              title: 'Top Rated',
              onNextPage: () => {
                //print('Here: Execute another fetch'),
                moviesProvider.getOnDisplayTopRatedMovies(),
              }, //populars
            ),
          ],
        ),
      )
    );
  }
}