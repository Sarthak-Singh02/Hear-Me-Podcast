import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hear_me/activity/AudioPlayer/Audioplayer.dart';
import 'package:hear_me/main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

class Episodes extends StatelessWidget {
  Episodes(
      {super.key,
      required this.podcast_id,
      required this.podcast_description,
      required this.podcast_title,
      required this.podcast_image});
  final String podcast_image;
  final String podcast_id;
  final String podcast_description;
  final String podcast_title;

  List _audios = [];
  String title = "Unable to load title";

  @override
  Future<void> initState() async {
    final applicationDocumentDir=await getApplicationDocumentsDirectory();
    await Hive.initFlutter(applicationDocumentDir.path);
    await Hive.openBox("myBox");
  }
  @override
  Widget build(BuildContext context) {
    var box;
    bool _isfavourites=false;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7), BlendMode.dstATop),
                        image: NetworkImage(
                          podcast_image,
                        ),
                        onError: (exception, stackTrace) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        podcast_description,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        print(_audios[0].toString());
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => MyAudioPlayer(
                              audios: _audios[0].toString(),
                              title: title,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.podcasts_rounded,
                        color: Colors.black,
                      ),
                    )),
              ),
              Container(
                alignment: Alignment.centerRight,
                child:IconButton(
                icon: Icon(Icons.favorite,
                    color: box!.isEmpty ? Colors.white : Colors.red),
                onPressed: () {
                  
                    _isfavourites = !_isfavourites;
                     (context as Element).markNeedsBuild();
                  if (box!.isEmpty)
                    box!.put(podcast_id,podcast_image);
                  else
                    box!.delete(podcast_id);
                },
              )
              ),
            ],
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Query(
                options: QueryOptions(
                  document: gql("""
query {
    podcast(identifier:{id: "$podcast_id", type : PODCHASER}) {
        episodes(
              page: 0,
              first: 1) {          
  data {
      id,
      guid,
      title,
      description,
      imageUrl,
      audioUrl  
  }
}        
    }
}
"""),
                ),
                builder: (QueryResult result,
                    {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    const CircularProgressIndicator();
                  }
                  final response =
                      result.data!["podcast"]["episodes"]["data"] as List;
                  _audios.clear();
                  for (int i = 0; i < response.length; i++) {
                    _audios.add({response[i]["audioUrl"]});
                  }
                  title = response[0]["title"];
                  return (response.isNotEmpty)
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: response.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.podcasts,
                                  color: Colors.deepOrange,
                                  size: 30,
                                ),
                                title: Text(
                                  response[index]["title"],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          })
                      : const CircularProgressIndicator();
                }),
          )
        ],
      ),
    );
  }
}
