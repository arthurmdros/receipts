import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipts/providers/favorites_provider.dart';
import 'package:receipts/providers/filters_provider.dart';
import 'package:receipts/screens/categories.dart';
import 'package:receipts/screens/filters.dart';
import 'package:receipts/screens/meals.dart';
import 'package:receipts/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedIndexPage = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement(
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(context) {
    final avaliableMeals = ref.watch(filteredMealsProvider);

    var activePageTitle = 'Categories';
    Widget activePage = CategoriesScreen(
      avaliableMeals: avaliableMeals,
    );

    if (_selectedIndexPage == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePageTitle = 'Your favorites';
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectedPage(index);
        },
        currentIndex: _selectedIndexPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal_outlined), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: 'Favorites'),
        ],
      ),
    );
  }
}
