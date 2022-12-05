// ignore_for_file: file_names

class Queries {
  // ignore: non_constant_identifier_names
  String trending_Podcasts = """query {
    podcasts(
        first: 20
        searchTerm: "", filters: {
        language : "en"
        rating: {minRating: 1, maxRating: 5}}, sort: {sortBy: TRENDING, direction: DESCENDING}) {
        
        data {
            id,
            title,
            imageUrl,
            description
        }
    }
}
""";
  String PodcastEpisodes = """
query {
    podcast(identifier:{\$id : , type : PODCHASER}) {
        episodes(
              page: 0,
              first: 3) {          
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
""";
}
