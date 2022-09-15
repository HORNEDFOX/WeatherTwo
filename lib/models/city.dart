class City {
  final int id; //Код города
  final String city; //Название города
  final String country; //Название страны

  //Конструктор с параметрами
  City({required this.id, required this.city, required this.country});

  //Фабричный конструктор, принимающий json и десериализующий их
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