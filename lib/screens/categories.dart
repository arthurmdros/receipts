import 'package:flutter/material.dart';
import 'package:receipts/data/dummy_categories.dart';
import 'package:receipts/models/category.dart';
import 'package:receipts/models/meal.dart';
import 'package:receipts/screens/meals.dart';
import 'package:receipts/widgets/category_grid_item.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({
    super.key,
    required this.setFavoriteStats,
    required this.avaliableMeals,
    this.favoriteList = const []
  });

  final Function(Meal meal) setFavoriteStats;
  final List<Meal> avaliableMeals;
  List<Meal> favoriteList;

  void _selectedCategory(BuildContext context, Category category) {
    final filteredMeals = avaliableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          setFavoriteStats: setFavoriteStats,
          favoriteList: favoriteList,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories
          .map((category) => CategoryGridItem(
              category: category,
              navigator: () {
                _selectedCategory(context, category);
              }))
          .toList(),
    );
  }
}
