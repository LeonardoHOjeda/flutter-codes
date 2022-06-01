import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:practice_five/src/theme/tema.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/news_models.dart';


class MorePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final noticia = ModalRoute.of(context)!.settings.arguments as Article;
    final url = Uri.parse(noticia.url);
    return Scaffold(
      appBar: AppBar(
        title: Text(noticia.title),
        backgroundColor: Colors.grey[800],
      ),
      body: Container(
        child: Column(
          children: [
            _ImageMore(noticia: noticia),
            SizedBox(height: 20.0),
            _DescriptionMore(noticia: noticia),
            Container(
              child: ElevatedButton.icon(
                onPressed: () async {
                  if(await canLaunchUrl(url)){
                    await launchUrl(url);
                  } else {
                    print('No se pudo');
                  }
                },
                icon: Icon(Icons.link, color: Colors.black,),
                label: Text('Leer noticia completa', style: TextStyle(color: Colors.black),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class _DescriptionMore extends StatelessWidget {
  const _DescriptionMore({required this.noticia,});

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text('Autor: ${noticia.source.name}'),
          Text(
              noticia.title, 
              style: TextStyle(fontSize: 25)
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Descripcion Corta', 
              style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold), 
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: (noticia.description != null)
            ? Text(noticia.description!)
            : Text('Sin descripcion en la noticia')
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Descripcion Larga', 
              style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold), 
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: (noticia.description != null)
            ? Text(noticia.content!)
            : Text('Sin descripcion en la noticia')
          )
        ]
      ),
    );
  }
}

class _ImageMore extends StatelessWidget {
  final Article noticia;

  const _ImageMore({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (noticia.urlToImage != null)
        ? FadeInImage(
          placeholder: AssetImage('assets/giphy.gif'),
          image: NetworkImage(noticia.urlToImage!)
        )
        : Image(image: AssetImage('assets/no-image.png')),
    );
  }
}