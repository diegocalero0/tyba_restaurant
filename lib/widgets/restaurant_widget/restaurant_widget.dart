import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tyba_great_app/models/get_nearby_restaurants_response_model.dart';
import 'package:tyba_great_app/utils/google_images_utils.dart';
import 'package:tyba_great_app/widgets/restaurant_widget/restaurant_presenter.dart';

class RestaurantWidget extends StatefulWidget {

  final PlaceModel placeModel;

  const RestaurantWidget({required this.placeModel, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RestaurantWidgetState();

}

class _RestaurantWidgetState extends RestaurantWidgetDelegate<RestaurantWidget> {

  RestaurantPresenter presenter = RestaurantPresenter();

  @override
  void initState() {
    presenter.mView = this;
    presenter.restaurant = widget.placeModel;
    presenter.getRestaurantImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _createPlaceImage(index);
              },
              itemCount: presenter.restaurant?.photos?.length,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(presenter.restaurant?.name ?? "", style: Theme.of(context).textTheme.headline3),
                _createRating(),
                Text(presenter.restaurant?.vicinity ?? "", style: Theme.of(context).textTheme.bodyText1),
                _createOpenNow()
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _createOpenNow() {
    bool open = presenter.restaurant?.openingHours?.openNow ?? false;

    return Text(open ? "Abierto" : "Cerrado", style: Theme.of(context).textTheme.bodyText2?.copyWith(
      color: open ? Colors.green : Colors.red
    ));
  }

  Widget _createRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("${presenter.restaurant?.rating}", style: Theme.of(context).textTheme.bodyText2),
        RatingBar.builder(
          initialRating: double.parse((presenter.restaurant?.rating ?? 0.0).toString()),
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 12,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          updateOnDrag: false,
          onRatingUpdate: (rating) {},
          ignoreGestures: true,
        )
      ],
    );
  }

  Widget _createPlaceImage(int index) {
    final photoReference = presenter.restaurant?.photos?[index].photoReference;
    if(photoReference != null) {
      return AspectRatio(
        aspectRatio: 1.7,
        child: SizedBox(
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(getPhotoUrlFromReference(photoReference), height: 100, fit: BoxFit.cover),
          )
        ),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 0.7,
        child: SizedBox(
          width: 200,
          child: Icon(Icons.photo),
        ),
      ); 
    }
    
  }
  
}