class Ingredient{
  final String id;
  final String name;
  final String type;
  
  Ingredient({
    required this.id,
    required this.name,
    required this.type});
}

class IngredientWithAmount extends Ingredient{
  final String amount;
  
   IngredientWithAmount({
    required String id,
    required String name,
    required String type,
    required this.amount,
  }) : super(
          id: id,
          name: name,
          type: type,
        );
}