import 'package:flutter/material.dart';
import 'package:tyba_great_app/screens/history_screen/history_presenter.dart';

class HistoryScreen extends StatefulWidget {

  final Function(String) onClickSearch;

  const HistoryScreen({required this.onClickSearch, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();

}

class _HistoryScreenState extends HistoryScreenDelegate<HistoryScreen> {

  final HistoryPresenter presenter = HistoryPresenter();

  @override
  void initState() {
    presenter.mView = this;
    presenter.getSearchs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de búsqueda")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return _createSearch(presenter.searchs[index]);
              },
              itemCount: presenter.searchs.length,
            ),
          )
        ],
      ),
    );
  }

  Widget _createSearch(String text) {
    return GestureDetector(
      onTap: () {
        goBack();
        widget.onClickSearch(text);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 1
            )
          )
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Text(text, style: Theme.of(context).textTheme.headline4),
      ),
    );
  }

}