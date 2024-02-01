import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receipts/models/meal.dart';
import 'package:receipts/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.selectedMeal,
  });

  final Meal meal;
  final Function(Meal meal) selectedMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String getCharacteristics(Meal meal) {
    String msg = '';
    if (meal.isGlutenFree) msg += 'Gluten Free |';
    if (meal.isVegan) msg += ' Vegan |';
    if (meal.isVegetarian) msg += ' Vegetarian |';
    if (meal.isLactoseFree) msg += ' Lactose Free';
    return msg;
  }

  @override
  Widget build(context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          selectedMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(children: [
                  Text(
                    meal.title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.comicNeue(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealItemTrait(
                        icon: Icons.schedule_outlined,
                        label: '${meal.duration} min',
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      MealItemTrait(
                        icon: Icons.handyman_outlined,
                        label: complexityText,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      MealItemTrait(
                        icon: Icons.attach_money_outlined,
                        label: affordabilityText,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    getCharacteristics(meal),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comicNeue(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
