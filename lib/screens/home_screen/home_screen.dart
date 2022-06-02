import 'package:flutter/material.dart';
import 'package:tyba_great_app/models/get_nearby_restaurants_response_model.dart';
import 'package:tyba_great_app/screens/history_screen/history_screen.dart';
import 'package:tyba_great_app/screens/home_screen/home_presenter.dart';
import 'package:tyba_great_app/screens/login_screen/login_screen.dart';
import 'package:tyba_great_app/screens/register_screen/register_screen.dart';
import 'package:tyba_great_app/widgets/restaurant_widget/restaurant_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends HomeScreenDelegate<HomeScreen> {

  HomePresenter presenter = HomePresenter();

  final TextEditingController _searchTextEditingController = TextEditingController();
  bool searchingInUserLocation = false;

  DateTime? changeText;

  @override
  void initState() {
    presenter.mView = this;
    presenter.getNearbyRestaurants(showInUserLocation: true);
    setState(() {
      searchingInUserLocation = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurantes"),
        actions: [
          IconButton(
            onPressed: presenter.logout,
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          _createSearchCityContainer(),
          Expanded(
            child: _createRestaurantsList(),
          )
        ],
      ),
    );
  }

  Widget _createRestaurantsList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return RestaurantWidget(placeModel: presenter.restaurants[index], key: Key(presenter.restaurants[index].placeId ?? ""));
      },
      itemCount: presenter.restaurants.length,
    );
  }

  Widget _createSearchCityContainer() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 0),
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: _createInputSearch()),
              IconButton(
                onPressed: () {
                  setState(() {
                    searchingInUserLocation = true;
                  });
                  presenter.getNearbyRestaurants(showInUserLocation: true);
                }, icon: const Icon(Icons.location_on_rounded, color: Colors.white, size: 32)
              )
            ],
          ),
          if(searchingInUserLocation)
            Text("Mostrando restaurantes cercanos a tu ubicación", style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.white
            )),
          const SizedBox(height: 24),
          TextButton(
            onPressed: _navigateToHistory,
            child: Text("Ver historial de búsqueda", style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: Colors.white
            )),
          )
        ],
      ),
    );
  }

  Widget _createInputSearch() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Pereira",
      ),
      textInputAction: TextInputAction.search,
      onChanged: (String text) {
        changeText = DateTime.now();
        Future.delayed(const Duration(milliseconds: 1600), () {
          if(changeText != null) {
            final diference = DateTime.now().difference(changeText ?? DateTime.now()).inMilliseconds ?? -1;
            if(diference > 1500) {
              presenter.getNearbyRestaurants(text: _searchTextEditingController.text);
            }
          }
        });        
      },
      controller: _searchTextEditingController,
    );
  }

  @override
  void navigateToHistory() {
    // TODO: implement navigateToHistory
  }

  @override
  void navigateToLogin() {
    navigatePushReplacement(const LoginScreen(key: Key("LoginScreen")));
  }

  @override
  void resetSearch() {
    setState(() {
      searchingInUserLocation = false;
    });
  }

  void _navigateToHistory() {
    navigatePush(
      HistoryScreen(
        key: const Key("HistoryScreen"),
        onClickSearch: (String text) {
          setState(() {
            _searchTextEditingController.text = text;
          });
          presenter.getNearbyRestaurants(text: text);
        },
      )
    );
  }

}