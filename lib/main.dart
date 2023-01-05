import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hear_me/BloC/InternetBloc/internet_bloc.dart';
import 'package:hear_me/activity/Tabs/ExploreTab.dart';
import 'Token.dart';
import 'activity/HomePage.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MaterialApp(home: MyApp()));
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

    return BlocProvider(
      create: (context) => InternetBloc(),
      child: GraphQLProvider(
        client: client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hear Me',
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: CupertinoColors.black,
              primaryTextTheme: const TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                ),
                bodyText2: TextStyle(
                  color: Colors.white,
                ),
              ),
              textTheme: GoogleFonts.nunitoTextTheme()),
          home: HomePage(),
          
        ),
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
