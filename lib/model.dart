class Model {
  final String image;
  final String description;
  final String title;
  final String id;



  Model({ required this.id, required this.title, required this.description, required this.image});

  // factory Model.fromJson(Map<String, dynamic> json) {
  //   return Model(
  //     title: json['title'] as String,
  //     description: json['description'] as String,
  //     audio: json['audio'] as String,
  //     image: json['image'] as String,
     
  //   );
  // }


  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'image': image,
  //     'audio': audio,
  //   };
  // }
}