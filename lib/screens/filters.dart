import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:receipts/providers/filters_provider.dart';
import 'package:receipts/widgets/filter_item.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  void setCheckedGlutenFilter(bool isChecked, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, isChecked);
  }

  void setCheckedVeganFilter(bool isChecked, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isChecked);
  }

  void setCheckedVegetarianFilter(bool isChecked, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isChecked);
  }

  void setCheckedLactoseFilter(bool isChecked, WidgetRef ref) {
    ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isChecked);
  }

  @override
  Widget build(context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Column(
        children: [
          FilterItem(
            filterValue: activeFilters[Filter.glutenFree]!,
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            changed: (isChecked) {
              setCheckedGlutenFilter(isChecked, ref);
            },
          ),
          FilterItem(
            filterValue: activeFilters[Filter.lactoseFree]!,
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            changed: (isChecked) {
              setCheckedLactoseFilter(isChecked, ref);
            },
          ),
          FilterItem(
            filterValue: activeFilters[Filter.vegan]!,
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            changed: (isChecked) {
              setCheckedVeganFilter(isChecked, ref);
            },
          ),
          FilterItem(
            filterValue: activeFilters[Filter.vegetarian]!,
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            changed: (isChecked) {
              setCheckedVegetarianFilter(isChecked, ref);
            },
          ),
        ],
      ),
    );
  }
}
