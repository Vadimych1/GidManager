class Town {
  const Town({
    required this.id,
    required this.imagePath,
    required this.description,
    required this.previewPlaces,
    required this.favorite,
  });

  final String id;
  final String imagePath;
  final Description description;
  final bool favorite;
  final List<Place> previewPlaces;
}

class Place {
  const Place({
    required this.id,
    required this.imagePath,
    required this.description,
    required this.stars,
  });

  final String id;
  final String imagePath;
  final Description description;
  final int stars;
}

class Description {
  final String title;
  final List<String> paragraphs;
  final List<String> links;

  const Description({
    required this.title,
    required this.paragraphs,
    required this.links,
  });
}
