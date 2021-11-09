import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/models.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movie_app/providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Type a movie name';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Return a Widget List
    return [
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Return a Widget
    return IconButton(
      icon: Icon(Icons.keyboard_return),
      onPressed: () {
        close(context, null);
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Return a Widget
    return Text('builResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No data founded :('),
            Icon(
              Icons.movie_creation_outlined,
                color: Colors.grey,
                size: 150
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Return a Widget
    if(query.isEmpty) {
      return _emptyContainer();
    }

    //print('Http request');

    final moviesProvider = Provider.of<MoviesProvider>(context, listen:false);
    //Call when user are typing letters 
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) {
          return _emptyContainer();
        }else {
          final movies = snapshot.data!;
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (_, int index) {
              return _MovieSuggestionItem(
                movies[index],
                'search-${movies[index].id}'
              );
            }
          );
        }
      },
    );
  }
}

class _MovieSuggestionItem extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MovieSuggestionItem(
    this.movie,
    this.heroId,
  );

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Hero(
          tag: heroId,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterPath),
            width: 50,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(movie.title),
        onTap: () {
          Navigator.pushNamed(context, 'details', arguments: movie);
        },
      ),
    );
  }
}

