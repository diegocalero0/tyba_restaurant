import 'package:flutter/material.dart';
import 'package:tyba_great_app/screens/home_screen/home_presenter.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();

}

class _HomeScreenState extends HomeScreenDelegate<HomeScreen> {

  HomePresenter presenter = HomePresenter();

  @override
  void initState() {
    presenter.mView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Restaurantes")),
    );
  }

  @override
  void navigateToHistory() {
    // TODO: implement navigateToHistory
  }

  @override
  void navigateToLogin() {
    // TODO: implement navigateToLogin
  }
  
}