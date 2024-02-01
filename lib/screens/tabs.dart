import 'package:flutter/material.dart';
import 'package:receipts/data/dummy_data.dart';
import 'package:receipts/models/meal.dart';
import 'package:receipts/screens/categories.dart';
import 'package:receipts/screens/filters.dart';
import 'package:receipts/screens/meals.dart';
import 'package:receipts/widgets/main_drawer.dart';

final kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends State<TabsScreen> {
  final List<Meal> _favorites = [];
  int _selectedIndexPage = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndexPage = index;
    });
  }

  void _showInfoMessage(
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

  void _toggleMealAsFavorite(Meal meal) {
    final isExisting = _favorites.contains(meal);
    setState(() {
      if (isExisting) {
        _favorites.remove(meal);
        _showInfoMessage(
          2,
          Colors.green,
          '${meal.title} is no longer a favorite!',
          'X',
          () {},
          Colors.black,
        );
      } else {
        _favorites.add(meal);
        _showInfoMessage(
          2,
          Colors.green,
          '${meal.title} marked as a favorite!',
          'X',
          () {},
          Colors.black,
        );
      }
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      // Navigator.of(context).pushReplacement(
      // TODO: CAPTURA INFORMAÇÕES DE POP DO NAVIGATION POR CAUSA DO FUTURE OBJ
      // COM ISSO PODEMOS POR MEIO DE UM ASYNC-AWAIT RESGATAR VALORES QUE FORAM JOGADOS ENTRE TELAS
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currenFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(context) {
    final avaliableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    var activePageTitle = 'Categories';
    Widget activePage = CategoriesScreen(
      setFavoriteStats: _toggleMealAsFavorite,
      avaliableMeals: avaliableMeals,
      favoriteList: _favorites,
    );

    if (_selectedIndexPage == 1) {
      activePageTitle = 'Your favorites';
      activePage = MealsScreen(
        meals: _favorites,
        setFavoriteStats: _toggleMealAsFavorite,
        favoriteList: _favorites,
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
