import 'package:flutter/material.dart';
import 'package:practice_five/src/pages/tabs_pages.dart';
import 'package:practice_five/src/services/news_service.dart';
import 'package:practice_five/src/theme/tema.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>new NewsService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: miTema,
        home: TabsPage()
      ),
    );
  }
}