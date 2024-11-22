class Ingredient {
  final String id;
  final String name;
  final String type;

  Ingredient({
    required this.id,
    required this.name,
    required this.type,
  });
}

// Used as ingredient structure for an unadded ingredient
class IngredientWithQuantity extends Ingredient {
  final String quantity;

  IngredientWithQuantity({
    required String id,
    required String name,
    required String type,
    required this.quantity,
  }) : super(
          id: id,
          name: name,
          type: type,
        );
}