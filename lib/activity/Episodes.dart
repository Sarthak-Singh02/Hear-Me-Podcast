import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';
import '../main.dart';
import 'AudioPlayer/Audioplayer.dart';

class Episodes extends StatefulWidget {
  final String podcast_image;
  final String podcast_id;
  final String podcast_description;
  final String podcast_title;
  const Episodes({super.key,required this.podcast_image,required this.podcast_description,required this.podcast_id,required this.podcast_title});

  @override
  State<Episodes> createState() => _EpisodesState();
}
List _audios = [];
String title = "Unable to load title";
var database;
class _EpisodesState extends State<Episodes> {


  @override
  Widget build(BuildContext context) {
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
                          widget.podcast_image,
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
                        widget.podcast_description,
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
                child: InkWell(
                    onTap: () => {
                          print("hue hue"),
                        },
                    child: Icon(Icons.favorite_border)),
              )
            ],
          ),
          ScrollConfiguration(
            behavior: MyBehavior(),
            child: Query(
                options: QueryOptions(
                  document: gql("""
    query {
    podcast(identifier:{id: "${widget.podcast_id}", type : PODCHASER}) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
              _addItem();
             // print(_audios[0].toString());
              //_deleteItem(int.parse(widget.podcast_id));
         },
        child: Icon(
          Icons.favorite_border,
        ),
      ),
    );
  }

   Future<void> _addItem() async {
    await SQLHelper.createItem(
      int.parse(widget.podcast_id),widget.podcast_title,widget.podcast_description,widget.podcast_image,_audios[0].toString().replaceAll('{', '').replaceAll('}', ''));
  }

   void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
  }
}
