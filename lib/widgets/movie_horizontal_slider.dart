import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/models.dart';

class MovieHorizontalSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieHorizontalSlider({
    required this.movies,
    required this.onNextPage,
    this.title
  });

  @override
  _MovieHorizontalSliderState createState() => _MovieHorizontalSliderState();
}

class _MovieHorizontalSliderState extends State<MovieHorizontalSlider> {

  bool _getMoreData = false;
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    //Execute this code: First render widget
    super.initState();
    scrollController.addListener(() { 
      final int pixelPosition = scrollController.position.pixels.toInt();
      final int maxScroll     = scrollController.position.maxScrollExtent.toInt();
      final int result = (maxScroll/2).toInt(); 

      /* print("Pixel position is $pixelPosition");
      print("The result is $result");
      print("Max scroll $maxScroll"); */

      if(pixelPosition == result) {
        _getMoreData = true;
        if(_getMoreData) {
          //print('Loading data...');
          this.widget.onNextPage();
        }
      }else {
        _getMoreData = false;
        if(!_getMoreData && pixelPosition == maxScroll) {
          //print('Loading data again...');
          this.widget.onNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    //When widget will be destroy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.indigoAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(this.widget.title != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(this.widget.title!, 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, 
                color: Colors.white
              )
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.movies.length,
              itemBuilder: ( _, int index) => _MovieCard(
                this.widget.movies[index], 
                '${this.widget.title}-$index-${this.widget.movies[index].id}}'
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MovieCard(
    this.movie,
    this.heroId
  );

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    //To get platform dimensions
    final size = MediaQuery.of(context).size;


    return Container(
      width: 130,
      height: 100,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal:10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'), 
                    image: NetworkImage(movie.fullPosterPath),
                    width: size.width,
                    height: 175,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          //SizedBox(height: 5),
          /* Text(movie.title, 
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ), */
        ],
      ),
    );
  }
}