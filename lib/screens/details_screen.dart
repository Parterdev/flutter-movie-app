import 'package:flutter/material.dart';
import 'package:flutter_movie_app/widgets/widgets.dart';
import 'package:flutter_movie_app/models/models.dart';

class DetailsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    //Receive args
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        //Widgets that have specific actitude when scrooll is active
        slivers: [
          _CustomAppBar(
            movie: movie,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                movie: movie,
              ),
              _Overview(
                movie: movie,
              ),
              Column(
                children: [
                  SizedBox(height: 50),
                  CastingCards(
                    movieId: movie.id,
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              movie.title,
              style: TextStyle(fontSize: 20),
            ),
          )
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover
        ),
      ),

    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    required this.movie,
  });

  

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterPath),
                height: 150,
                width: 100,
              ),
            ),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.originalTitle, style : textTheme.headline5, 
                    overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalLanguage.toUpperCase(), style : textTheme.headline5, 
                overflow: TextOverflow.ellipsis, maxLines: 2),
                Row(
                  children: [
                    Icon(Icons.star_border_outlined, size: 25, color: Colors.amber),
                    SizedBox(width: 5),
                    Text(movie.voteAverage),
                  ],
                ),
                Row(
                  children: [
                    
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        (movie.adult) ? 'Adult' : 'All public',
                        style: TextStyle(fontSize: 15)
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            child: Text('Synopsis', textAlign: TextAlign.left),
          ),
          Text(movie.overview,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle1),
        ],
      )
    );
  }
}