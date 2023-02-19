import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hear_me/database_helper.dart';

import '../../model.dart';
import '../Episodes.dart';

class FavouritesTab extends StatelessWidget {
   FavouritesTab({super.key});
List<Model> list=<Model>[];
  @override
  Widget build(BuildContext context) {
     _getAllItems().then((value) {
      
        list= value;
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text(
                "Favourites",
                style: TextStyle(
                  color: CupertinoColors.systemGrey6,
                  fontSize: 25,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded
            (
              child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      print(list[index].image);
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              Episodes(
                                            podcast_image: list[index].image,
                                            podcast_id: list[index].id,
                                            podcast_description: list[index].description,
                                            podcast_title: list[index].title,
                                          ),
                                        ),
                                      );
                                    },
                                    child: GridTile(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].image
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
                            ),
            )
          ],
        ),

      ),
      
      floatingActionButton: FloatingActionButton(onPressed: ()async{ 
        await _getAllItems();
            
       },

      ),
    );

  }
   Future<List<Model>>_getAllItems() async {
    var data=await SQLHelper.getItems();
    print(data.length);
    return List.generate(data.length, (i) {
      return Model(id: data[i]['id'].toString(), description:data[i]['description'], image: data[i]['image'], title: data[i]['title']
        
        
      );
    });
  }


}
