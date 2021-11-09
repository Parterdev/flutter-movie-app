import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_movie_app/models/models.dart';
import 'package:flutter_movie_app/providers/movies_provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards({
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCasting(movieId),
      builder: ( _, AsyncSnapshot<List<Cast>> snapshot ) {

        if(!snapshot.hasData) {
          return Container(
            height: 150,
            child: CupertinoActivityIndicator(
              radius: 40.0,
            ),
          );
        }

        final cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 0),
          width: double.infinity,
          height: 150,
          //color: Colors.amber,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (BuildContext context, int index) {
              return _CastCard(
                actor: cast[index],
              );
            }
          ),
        );
      }
    );
  }
}

class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({
    required this.actor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      //color: Colors.blueAccent,
      child: Column(
        children: [
          SizedBox(height: 5,),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullProfilePath),
              height: 100,
              width: 90,
              fit: BoxFit.cover
            ),
          ),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}