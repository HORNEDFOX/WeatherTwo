import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/pages/weather.dart';

import '../bloc/city_bloc.dart';
import '../models/city.dart';
import '../repository/city_repository.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  Widget appBarTitle = const Text(
    "Search City",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5,
      shadows: <Shadow>[
        Shadow(
          color: Colors.black26,
          offset: Offset(3, 3),
          blurRadius: 20,
        ),
      ],
    ),
  );
  Icon icon = const Icon(
    Icons.search_rounded,
    color: Colors.white,
  );
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();

  //Флаг. Используется для отслеживания нажатия кнопки поиска и закрытия поиска в AppBar
  late bool _isSearching;

  //Текст при поиске города
  String _searchText = "";

  //Лист, в котором хранится список городов, удовлетворяющих условию поиска
  List searchresult = [];

  _CityPageState() {
    //Слушатель для контроллера TextField
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
        CityBloc(
          cityRepository:
          RepositoryProvider.of<CityRepository>(context),
        )
          ..add(LoadCityEvent()),
        child: Scaffold(
            key: globalKey,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(54),
              child: BlocBuilder<CityBloc, CityState>(
                  builder: (BuildContext, state) {
                    if (state is CityLoadedState) {
                      return buildAppBar(context, state.city);
                    }
                    return buildAppBar(context, []);
                  }
              ),
            ),
            body: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Colors.deepPurple,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: BlocBuilder<CityBloc, CityState>(
                          builder: (context, state) {
                            if (state is CityLoadedState) {
                              //Если текст в TextField не пуст или список городов удовлетворяющих условию не пуст, то выводим список найденных городов
                              return searchresult.isNotEmpty ||
                                  _controller.text.isNotEmpty
                                  ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: searchresult.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: InkWell(
                                      child: Text(
                                        "${searchresult[index]}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString('city', searchresult[index]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => WeatherPage(prefs: prefs,)),
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                                  : ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.city.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: InkWell(
                                      child: Text(
                                        "${state.city
                                            .elementAt(index)
                                            .city}, ${state.city
                                            .elementAt(index)
                                            .country}",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () async{
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString('city', "${state.city
                                            .elementAt(index)
                                            .city}, ${state.city
                                            .elementAt(index)
                                            .country}");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => WeatherPage(prefs: prefs)),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                            if (state is CityErrorState) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: Text("Ошибка получения данных"),
                                ),
                              );
                            }
                            if (state is CityLoadingState) {
                              return SizedBox(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: CircularProgressIndicator(color: Colors.white,),
                                ),
                              );
                            }
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            );
                          }
                      ),
                    ),
                  ],
                ))
        ));
}


Widget buildAppBar(BuildContext context, List<City> city) {
  return AppBar(
      centerTitle: true,
      title: appBarTitle,
      backgroundColor: Colors.deepPurple,
      elevation: 20,
      shadowColor: Colors.deepPurple[500],
      actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            setState(() {
              if (icon.icon == Icons.search_rounded) {
                icon = const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                );
                appBarTitle = TextField(
                  controller: _controller,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    shadows: <Shadow>[
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(3, 3),
                        blurRadius: 20,
                      ),
                    ],
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search...",
                      hintStyle:
                      TextStyle(color: Colors.white.withOpacity(0.5))),
                  onChanged: (context) { searchOperation(_searchText, city);},
                );
                _handleSearchStart();
              } else {
                //Отрисовываем первичный AppBar при завершении поиска
                _handleSearchEnd();
              }
            });
          },
        ),
      ]);
}

//Изменение флага поиска на "Истина"
void _handleSearchStart() {
  setState(() {
    _isSearching = true;
  });
}

void _handleSearchEnd() {
  setState(() {
    icon = const Icon(
      Icons.search_rounded,
      color: Colors.white,
    );
    appBarTitle = const Text(
      "Search City",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.5,
        shadows: <Shadow>[
          Shadow(
            color: Colors.black26,
            offset: Offset(3, 3),
            blurRadius: 20,
          ),
        ],
      ),
    );
    _isSearching = false;
    _controller.clear();
  });
}

//Функция поиска городов с писке, удовлетворяющих условию и загрузка их в новый список
void searchOperation(String searchText, List<City> city) {
  searchresult.clear();
  for (int i = 0; i < city.length; i++) {
    String data = "${city[i].city}, ${city[i].country}";
    if (data.toLowerCase().contains(searchText.toLowerCase())) {
      setState(() {
        searchresult.add(data);
      });
    }
  }
}}
