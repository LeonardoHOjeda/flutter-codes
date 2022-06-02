import 'package:flutter/material.dart';
import 'package:progra_movil/widgets/widgets.dart';


class DetailsMovieScreen extends StatelessWidget {

  static const String routerName = 'DetailsMovie';



  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Description(),
              CastingCards()
            ])
          )
        ],
      )
    );
  }
}

class _Description extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text('Lorem Ipsum dolor Asimet', textAlign: TextAlign.justify)
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.green[800],
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black12,
          child: Text('movie.title', style: TextStyle(fontSize: 16),),
          padding: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpeg'),
          image: NetworkImage('http://placekitten.com/400/400'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}


class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpeg'),
              image: NetworkImage('http://placekitten.com/200/300'),
              height: 150,
            ),
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movie.release_date', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1),
              Row(
                children: [
                  Icon(Icons.heart_broken),
                  SizedBox(width: 5),
                  Text('4.5/10')
                ],
              )
            ],
          )

        ],
      ),
    );
  }
}