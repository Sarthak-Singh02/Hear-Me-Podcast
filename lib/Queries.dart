class Queries {
  String trending_Podcasts = """query {
    podcasts(
        first: 20
        searchTerm: "", filters: {
        language : "en"
        rating: {minRating: 1, maxRating: 5}}, sort: {sortBy: TRENDING, direction: DESCENDING}) {
        
        data {
            id,
            title,
            description,
            imageUrl,
          episodes(first: 3) {          
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
}
""";
}
