class City {
  final int id;
  final String city;
  final String country;

  City({required this.id, required this.city, required this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: double.parse(json['id'].toString()).toInt(),
      city: json['name'] as String,
      country: json['country'] as String,
    );
  }

  void display() {
    print("ID: $id");
    print("Город: $city");
    print("Страна: $country");
    print("\n______________________________________________\n");
  }
}