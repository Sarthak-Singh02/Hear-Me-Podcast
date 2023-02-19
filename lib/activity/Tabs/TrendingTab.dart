import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hear_me/BloC/InternetBloc/internet_bloc.dart';
import 'package:hear_me/BloC/InternetBloc/internet_state.dart';
import 'package:hear_me/Queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:hear_me/activity/Episodes.dart';
import 'package:hear_me/main.dart';
import 'package:provider/provider.dart';

class TrendingTab extends StatelessWidget {
  const TrendingTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: ListView(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  "Trending",
                  style: TextStyle(
                    color: CupertinoColors.systemGrey6,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              BlocBuilder<InternetBloc, InternetState>(
                builder: (context, state) {
                  if (state is InternetGainedState) {
                    return Query(
                        options: QueryOptions(
                            document: gql(Queries().trending_Podcasts)),
                        builder: (QueryResult result,
                            {VoidCallback? refetch, FetchMore? fetchMore}) {
                          if (result.hasException) {
                            Text(result.exception.toString());
                          }
                          if (result.isLoading) {
                            const CircularProgressIndicator();
                          }
                          final response =
                              result.data!["podcasts"]["data"] as List;
    
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: response.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            Episodes(
                                          podcast_image: response[index]
                                              ["imageUrl"],
                                          podcast_id: response[index]["id"],
                                          podcast_description: response[index]
                                              ["description"],
                                          podcast_title: response[index]
                                              ["title"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: GridTile(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: CachedNetworkImage(
                                        imageUrl: response[index]["imageUrl"]
                                            .toString(),
                                        placeholder: (context, url) => Center(
                                            child:
                                                new CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  )),
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                            ),
                          );
                        });
                  } else if (state is InternetInitialState) {
                    return const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: const [
                          Icon(
                            CupertinoIcons.wifi_slash,
                            color: Colors.grey,
                            size: 60,
                          ),
                          Text(
                            "No internet",
                            style: TextStyle(color: Colors.grey, fontSize: 35),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
