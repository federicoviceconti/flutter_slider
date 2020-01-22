class Author {
  String name;
  String surname;

  Author({this.name, this.surname});

  static List<Author> fromSliderJson(Map<String, dynamic> result) {
    return result['authors'].map((item) {
      return Author(
        name: item['name'],
        surname: item['surname'],
      );
    }).toList()
      .cast<Author>();
  }
  
}