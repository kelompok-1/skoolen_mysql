class Movie {
  String title;
  String description;
  String imageUrl;
  int year;

  Movie(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.year});
}

List<Movie> movieList = [
  Movie(
      title: 'The Godfather',
      description:
          'he aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son',
      year: 1972,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/pt/a/af/The_Godfather%2C_The_Game.jpg'),
  Movie(
      title: 'The Godfather',
      description:
          'he aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son',
      year: 1972,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/pt/a/af/The_Godfather%2C_The_Game.jpg'),
  Movie(
      title: 'The Godfather',
      description:
          'he aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son',
      year: 1972,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/pt/a/af/The_Godfather%2C_The_Game.jpg'),
];
