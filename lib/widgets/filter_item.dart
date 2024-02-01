import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem(
      {super.key,
      required this.filterValue,
      required this.title,
      required this.subtitle,
      required this.changed});

  final bool filterValue;
  final String title;
  final String subtitle;
  final void Function(bool isChecked) changed;

  @override
  Widget build(context) {
    return SwitchListTile(
      value: filterValue,
      onChanged: (isChecked) {
        changed(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 32,
        right: 22,
      ),
    );
  }
}
