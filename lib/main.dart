import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hear_me/activity/TestPage.dart';
import 'Token.dart';
import 'activity/HomePage.dart';

void main() async {
  await initHiveForFlutter();
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
     final HttpLink httpLink = HttpLink(
    'https://api.podchaser.com/graphql',
  );
  final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer ${Token.graphQL_Token}',
  );
  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: const TestPage(),
          );
        },
        debugShowCheckedModeBanner: false,
        title: 'Hear Me',
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: CupertinoColors.black,
            textTheme: GoogleFonts.nunitoTextTheme()),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
