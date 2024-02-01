import 'package:flutter/material.dart';
import 'package:receipts/widgets/filter_item.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currenFilters,
  });

  final Map<Filter, bool> currenFilters;

  @override
  State<FiltersScreen> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _veganFreeFilterSet = false;
  var _vegetarianFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currenFilters[Filter.glutenFree]!;
    _veganFreeFilterSet = widget.currenFilters[Filter.vegan]!;
    _vegetarianFreeFilterSet = widget.currenFilters[Filter.vegetarian]!;
    _lactoseFreeFilterSet = widget.currenFilters[Filter.lactoseFree]!;
  }

  void setCheckedGlutenFilter(bool isChecked) {
    setState(() {
      _glutenFreeFilterSet = isChecked;
    });
  }

  void setCheckedVeganFilter(bool isChecked) {
    setState(() {
      _veganFreeFilterSet = isChecked;
    });
  }

  void setCheckedVegetarianFilter(bool isChecked) {
    setState(() {
      _vegetarianFreeFilterSet = isChecked;
    });
  }

  void setCheckedLactoseFilter(bool isChecked) {
    setState(() {
      _lactoseFreeFilterSet = isChecked;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.pop(context);
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: PopScope( 
        //TODO: WIDGET QUE PODE SER USADO EM QUALQUER PARTE DO PROJETO
        // COM ELE É POSSÍVEL CAPTURAR INFORMAÇÕES DE CALLBACKS QUANDO OCORRER O DISPOSE
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFreeFilterSet,
            Filter.vegetarian: _vegetarianFreeFilterSet,
          });
        },
        child: Column(
          children: [
            FilterItem(
              filterValue: _glutenFreeFilterSet,
              title: 'Gluten-free',
              subtitle: 'Only include gluten-free meals.',
              changed: setCheckedGlutenFilter,
            ),
            FilterItem(
              filterValue: _lactoseFreeFilterSet,
              title: 'Lactose-free',
              subtitle: 'Only include lactose-free meals.',
              changed: setCheckedLactoseFilter,
            ),
            FilterItem(
              filterValue: _veganFreeFilterSet,
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              changed: setCheckedVeganFilter,
            ),
            FilterItem(
              filterValue: _vegetarianFreeFilterSet,
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              changed: setCheckedVegetarianFilter,
            ),
          ],
        ),
      ),
    );
  }
}
