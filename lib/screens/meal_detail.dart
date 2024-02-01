import 'package:flutter/material.dart';
import 'package:receipts/models/meal.dart';
import 'package:receipts/widgets/meal_item_detail.dart';

// ignore: must_be_immutable
class MealDetailScreen extends StatefulWidget {
  MealDetailScreen({
    super.key,
    required this.meal,
    this.isFavorite = false,
    required this.setFavoriteStats,
  });

  final Meal meal;
  bool isFavorite;
  final Function(Meal meal) setFavoriteStats;

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.setFavoriteStats(widget.meal);
              setState(() {
                widget.isFavorite = !widget.isFavorite;
              });
            },
            icon: Icon(
              widget.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            widget.meal.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
          MealItemDetail(
              details: widget.meal.ingredients, titleDetail: 'Ingredients'),
          MealItemDetail(
              details: widget.meal.steps,
              titleDetail: 'Steps',
              usePadding: true),
        ],
      ),
    );
  }
}
