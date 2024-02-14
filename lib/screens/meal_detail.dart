import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipts/models/meal.dart';
import 'package:receipts/providers/favorites_provider.dart';
import 'package:receipts/widgets/meal_item_detail.dart';

// ignore: must_be_immutable
class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    void showInfoMessage(
      int duration,
      Color panelClass,
      String contentMsg,
      String actionMsg,
      Function() action,
      Color actionColor,
    ) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: duration),
          backgroundColor: panelClass,
          content: Text(
            contentMsg,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          action: SnackBarAction(
            label: actionMsg,
            textColor: actionColor,
            onPressed: action,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  ref.read(favoriteMealsProvider.notifier).toggleFavorite(meal);

              if (wasAdded) {
                showInfoMessage(
                    2,
                    const Color.fromARGB(255, 0, 200, 10),
                    'Meal added as a favorite!',
                    'X',
                    () {},
                    const Color.fromARGB(255, 255, 255, 255));
              } else {
                showInfoMessage(
                    2,
                    const Color.fromARGB(255, 0, 200, 10),
                    'Meal removed!',
                    'X',
                    () {},
                    const Color.fromARGB(255, 255, 255, 255));
              }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            meal.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
          MealItemDetail(details: meal.ingredients, titleDetail: 'Ingredients'),
          MealItemDetail(
              details: meal.steps, titleDetail: 'Steps', usePadding: true),
        ],
      ),
    );
  }
}
