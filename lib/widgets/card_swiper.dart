import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_movie_app/models/models.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    //To get platform dimensions
    final size = MediaQuery.of(context).size;

    if(this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.50,
        child: Center(
          child: CircularProgressIndicator(),
        )
      );
    }

    return Container(
      width: double.infinity,
      height: size.height * 0.50,
      color: Colors.indigo,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.60,
        itemHeight: size.height * 0.40,
        itemBuilder: (BuildContext context, int index) {

          final movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';
          
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterPath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}