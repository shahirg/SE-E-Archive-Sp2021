// written by: Malena, Nirav
// tested by: Michael
// debugged by: Daniel
// Recipe data model

class Recipe {
  final int id, readyInMinutes;
  final String title, summary, imgLink;
  final List<String> cuisines, dishTypes, diets;
  final List<RecipeStep> steps;
  final List<RecipeIngredient> ingredients;
  final bool vegetarian,
      vegan,
      glutenFree,
      dairyFree,
      veryHealthy,
      cheap,
      veryPopular,
      sustainable;

  Recipe({
    this.id,
    this.title,
    this.readyInMinutes,
    this.summary = "",
    this.steps,
    this.ingredients,
    this.imgLink = "",
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.cuisines,
    this.dishTypes,
    this.diets,
  });

  Map<String, dynamic> toMap() {
    List<dynamic> ingreds = [];
    List<dynamic> storeSteps = [];

    ingredients.forEach((ingredient) => ingreds.add(ingredient.toMap()));
    steps.forEach((step) => storeSteps.add(step.toMap()));

    return {
      'id': id,
      'title': title,
      'readyInMinutes': readyInMinutes,
      'summary': summary,
      'steps': storeSteps,
      'ingredients': ingreds,
      'imgLink': imgLink,
      'vegetarian': vegetarian,
      'vegan': vegan,
      'glutenFree': glutenFree,
      'dairyFree': dairyFree,
      'veryHealthy': veryHealthy,
      'cheap': cheap,
      'veryPopular': veryPopular,
      'sustainable': sustainable,
      'cuisines': cuisines,
      'dishTypes': dishTypes,
      'diets': diets
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    //Recipe Object
    List<RecipeStep> tempSteps = [];
    // map['analyzedInstructions'][0]['steps'].forEach(
    //   (step) => tempSteps.add(
    //     RecipeStep.fromMap(step),
    //   ),
    // );
    List<RecipeIngredient> tempIngredients = [];
    map['extendedIngredients'].forEach(
      (ingredient) => tempIngredients.add(
        RecipeIngredient.fromMap(ingredient),
      ),
    );
    return Recipe(
      id: map['id'],
      title: map['title'],
      summary: map['summary'],
      steps: tempSteps,
      ingredients: tempIngredients,
    );
  }

  @override
  String toString() {
    // TODO: implement toString for Recipe
    return super.toString();
  }
}

class RecipeIngredient {
  final String name, units, original;
  final double amount;

  RecipeIngredient({
    this.name,
    this.original = "",
    this.units = "",
    this.amount = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'original': original,
      'units': units,
      'amount': amount,
    };
  }

  factory RecipeIngredient.fromMap(Map<String, dynamic> map) {
    return RecipeIngredient(
      name: map['name'],
      original: map['original'],
      units: map['units'],
      amount: map['amount'],
    );
  }
}

class RecipeStep {
  final int number;
  final String step;
  final List<String> ingredients;

  RecipeStep({this.number, this.step, this.ingredients});

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'step': step,
      'ingredients': ingredients,
    };
  }

  factory RecipeStep.fromMap(Map<String, dynamic> map) {
    List<String> usedIngredients = [];
    map['steps'].forEach(
      (step) => step['ingredients'].forEach(
        (ingredient) => usedIngredients.add(ingredient),
      ),
    );
    return RecipeStep(
      number: map['number'],
      step: map['step'],
      ingredients: map["ingredients"],
    );
  }
}
