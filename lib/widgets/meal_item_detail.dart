import 'package:flutter/material.dart';

class MealItemDetail extends StatelessWidget {
  const MealItemDetail({
    super.key,
    required this.titleDetail,
    required this.details,
    this.usePadding = false,
  });

  final String titleDetail;
  final List<String> details;
  final bool usePadding;

  @override
  Widget build(context) {
    Widget content(String detail) {
      if (usePadding) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            detail,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        );
      } else {
        return Text(
          detail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        );
      }
    }

    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          titleDetail,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 14,
        ),
        for (final detail in details) content(detail)
      ],
    );
  }
}
