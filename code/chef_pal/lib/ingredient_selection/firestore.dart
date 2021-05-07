// written by: Azim, Shahir, Nirav
// tested by: Daniel
// debugged by: Nirav, Azim, Shahir
// Handles database logic for app

import 'package:chef_pal/profile/user_model.dart';
import 'package:chef_pal/recipe_search/recipe_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid;
  FirestoreService(this.uid);

  //create user
  Future<void> initUser(String username) async {
    Map<String, dynamic> userData = {
      'username': username,
      'ingredients': {
        "Meat": {
          "Chicken Breast": false,
          "Ground Beef": false,
          "Bacon": false,
          "Sausage": false,
          "Beef Steak": false,
          "Ham": false,
          "Hot Dog": false,
          "Pork Chops": false,
          "Chicken Thighs": false,
          "Ground Turkey": false,
          "Cooked Chicken": false,
          "Turkey": false,
          "Pork": false,
          "Pepperoni": false,
          "Whole Chicken": false,
          "Chicken Legs": false,
          "Ground Pork": false,
          "Chorizo": false,
          "Chicken Wings": false,
          "Beef Roast": false,
          "Polish Sausage": false,
          "Salami": false,
          "Pork Roast": false,
          "Ground Chicken": false,
          "Pork Ribs": false,
          "Spam": false,
          "Venison": false,
          "Pork Shoulder": false,
          "Bologna": false,
          "Bratwurst": false,
          "Prosciutto": false,
          "Lambcorned Beef": false,
          "Chicken Roast": false,
          "Lamb Chops": false,
          "Pancetta": false,
          "Ground Lamb": false,
          "Beef Ribs": false,
          "Duck": false,
          "Pork Belly": false,
          "Beef Liver": false,
          "Leg of Lamb": false,
          "Canadian Bacon": false,
          "Beef Shank": false,
          "Veal": false,
          "Chicken Giblets": false,
          "Cornish Hen": false,
          "Lamb Shoulder": false,
          "Lamb Shank": false,
          "Deer": false,
          "Ground Veal": false,
          "Pastrami": false,
          "Rabbit": false,
          "Sliced Turkey": false,
          "Pork Loin": false,
          "Elk": false,
          "Beef Suet": false,
          "Veal Cutlet": false,
          "Lamb Loin": false,
          "Marrow Bones": false,
          "Goose": false,
          "Chicken Tenders": false,
          "Veal Chops": false,
          "Quail": false,
          "Oxtail": false,
          "Pheasant": false,
          "Lamb Liver": false,
          "Moose": false,
          "Turkey Liver": false,
          "Pork Liver": false,
          "Veal Shank": false,
          "Foie Gras": false,
          "Beef Sirloin": false,
          "Liver Sausage": false,
          "Wild Boar": false,
          "Snail": false,
          "Pigeon": false,
          "Duck Liver": false,
          "Goose Liver": false,
          "Grouse": false,
          "Ostrich": false,
          "Soppressata": false,
          "Alligator": false
        },
        "Dairy": {
          "Butter": false,
          "Egg": false,
          "Milk": false,
          "Parmesan": false,
          "Cheddar": false,
          "American Cheese": false,
          "Sour Cream": false,
          "Cream Cheese": false,
          "Mozzarella": false,
          "Yogurt": false,
          "Cream": false,
          "Evaporated Milk": false,
          "Whipped Cream": false,
          "Half and Half": false,
          "Feta": false,
          "Monterey Jack Cheese": false,
          "Condensed Milk": false,
          "Cottage Cheese": false,
          "Ice Cream": false,
          "Swiss Cheese": false,
          "Velveeta": false,
          "Frosting": false,
          "Buttermilk": false,
          "Ricotta": false,
          "Goat Cheese": false,
          "Provolone": false,
          "Blue Cheese": false,
          "Powdered Milk": false,
          "Colby Cheese": false,
          "Pepper Jack": false,
          "Italian Cheese": false,
          "Gouda": false,
          "Pepperjack Cheese": false,
          "Romano": false,
          "Brie": false,
          "Pizza Cheese": false,
          "Ghee": false,
          "Gruyere": false,
          "Pecorino Cheese": false,
          "Custard": false,
          "Muenster": false,
          "Queso Fresco Cheese": false,
          "Havarti Cheese": false,
          "Asiago": false,
          "Mascarpone": false,
          "Neufchatel": false,
          "Halloumi": false,
          "Paneerbrick Cheese": false,
          "Camembert Cheese": false,
          "Goat Milk": false,
          "Garlic Herb Cheese": false,
          "Edam Cheese": false,
          "Manchego": false,
          "Fontina": false,
          "Stilton Cheese": false,
          "Emmenthaler Cheese": false,
          "Red Leicester Cheese": false,
          "Jarlsberg Cheese": false,
          "Bocconcini Cheese": false,
          "Farmer Cheese": false,
          "Creme de Cassis": false,
          "Wensleydale Cheese": false,
          "Longhorn Cheese": false,
          "Double Gloucester Cheese": false,
          "Raclette Cheese": false,
          "Lancashire Cheese": false,
          "Cheshire Cheese": false
        },
        "Fish": {
          "Amberjack": false,
          "Anchovy": false,
          "Arctic char": false,
          "Barramundi": false,
          "Bluefish": false,
          "Canned Salmon": false,
          "Canned Tuna": false,
          "Carp": false,
          "Catfish": false,
          "Caviar": false,
          "Cod": false,
          "Cuttlefish": false,
          "Eel": false,
          "Fish Fillets": false,
          "Flounder": false,
          "Grouper": false,
          "Haddock": false,
          "Halibut": false,
          "Herring": false,
          "John Dory": false,
          "Lemon Sole": false,
          "Mackerel": false,
          "Mahi Mahi": false,
          "Marlin": false,
          "Monkfish": false,
          "Perch": false,
          "Pike": false,
          "Pollock": false,
          "Pompano": false,
          "Red Snapper": false,
          "Rockfish": false,
          "Salmon": false,
          "Sardines": false,
          "Sea Bass": false,
          "Smoked Salmon": false,
          "Sole": false,
          "Sturgeon": false,
          "Swordfish": false,
          "Tilapia": false,
          "Trout": false,
          "Tuna Steak": false,
          "Whitefish": false
        },
        "Seafood": {
          "Calamari": false,
          "Clam": false,
          "Cockle": false,
          "Conch": false,
          "Crab": false,
          "Crawfish": false,
          "Lobster": false,
          "Mussel": false,
          "Octopus": false,
          "Oyster": false,
          "Prawns": false,
          "Scallop": false,
          "Sea Urchin": false,
          "Shrimp": false,
          "Squid": false
        },
        "Grains & Baking": {
          "Angel Food": false,
          "Angel Hair": false,
          "Bagel": false,
          "Baguette": false,
          "Baking Powder": false,
          "Baking soda": false,
          "Barley": false,
          "Biscuits": false,
          "Bisquick": false,
          "Bran": false,
          "Bread": false,
          "Bread Crumbs": false,
          "Bread Dough": false,
          "Bread Flour": false,
          "Breadsticks": false,
          "Brown Rice": false,
          "Buckwheat": false,
          "Cake Mix": false,
          "Cereal": false,
          "Challah": false,
          "Chips": false,
          "Ciabatta": false,
          "Coconut Flakes": false,
          "Coconut Flour": false,
          "Corn Tortillas": false,
          "Cornbread": false,
          "Cornflour": false,
          "Cornmeal": false,
          "Cornstarch": false,
          "Couscous": false,
          "Crackers": false,
          "Cream of Wheat": false,
          "Crescent Roll Dough": false,
          "Croissants": false,
          "Croutons": false,
          "English Muffin": false,
          "Filo Dough": false,
          "Flour": false,
          "Flour Tortillas": false,
          "Gnocchi": false,
          "Gram Flour": false,
          "Hot Dog Bun": false,
          "Lasagne": false,
          "Macaroni Cheese Mix": false,
          "Malt Extract": false,
          "Matzo Meal": false,
          "Muffin Mix": false,
          "Multigrain Bread": false,
          "Noodles": false,
          "Pancake Mix": false,
          "Pasta": false,
          "Pie Crust": false,
          "Pierogi": false,
          "Pita": false,
          "Pizza Dough": false,
          "Polenta": false,
          "Popcorn": false,
          "Potato": false,
          "Potato Starch": false,
          "Pretzelpuff Pastry": false,
          "Quinoa": false,
          "Ramen": false,
          "Ravioli": false,
          "Rice": false,
          "Rice Flour": false,
          "Risotto": false,
          "Rolled Oats": false,
          "Rye": false,
          "Saltines": false,
          "Self Rising Flour": false,
          "Semolina": false,
          "Shortcrust Pastry": false,
          "Sorghum Flour": false,
          "Sourdough Starter": false,
          "Spelt": false,
          "Sponge Cake": false,
          "Starch": false,
          "Stuffing Mix": false,
          "Tapioca Flour": false,
          "Tapioca Starch": false,
          "Vermicelli": false,
          "Wafer": false,
          "Wheat": false,
          "Wheat Germ": false,
          "Whole Wheat Flour": false,
          "Yeast": false,
          "Yeast flake": false
        },
        "Fruits": {
          "Apple": false,
          "Apple Butter": false,
          "Apricot": false,
          "Bananab": false,
          "Berries": false,
          "Blackberry": false,
          "Blueberry": false,
          "Boysenberry": false,
          "Canned Tomato": false,
          "Cantaloupe": false,
          "Cherry": false,
          "Clementine": false,
          "Coconut": false,
          "Crabapples": false,
          "Craisins": false,
          "Cranberry": false,
          "Currant": false,
          "Date": false,
          "Fig": false,
          "Grapes": false,
          "Grapefruit": false,
          "Guava": false,
          "Honeydew": false,
          "Kiwi": false,
          "Kumquat": false,
          "Lemon": false,
          "Lime": false,
          "Lingonberry": false,
          "Lychee": false,
          "Mandarin": false,
          "Mango": false,
          "Nectarine": false,
          "Orange": false,
          "Papaya": false,
          "Passionfruit": false,
          "Peach": false,
          "Pear": false,
          "Persimmons": false,
          "Pineapple": false,
          "Plantain": false,
          "Plum": false,
          "Pomegranate": false,
          "Prunes": false,
          "Quince": false,
          "Raisin": false,
          "Raspberry": false,
          "Rhubarb": false,
          "Starfruit": false,
          "Strawberry": false,
          "Sultanas": false,
          "Sun-dried Tomato": false,
          "Tangelos": false,
          "Tangerine": false,
          "Tomato": false,
          "Watermelon": false
        },
        "Vegetables": {
          "Artichoke": false,
          "Artichoke Heart": false,
          "Arugula": false,
          "Asparagus": false,
          "Avocado": false,
          "Bamboo Shoot": false,
          "Basil": false,
          "Bean Sprouts": false,
          "Beet": false,
          "Bell Pepper": false,
          "Bok Choy": false,
          "Broccoli": false,
          "Broccoli rabe": false,
          "Brussels Sprout": false,
          "Burdock": false,
          "Butternut": false,
          "Butternut Squash": false,
          "Cabbage": false,
          "Caper": false,
          "Capsicum": false,
          "Carrot": false,
          "Cauliflower": false,
          "Celery": false,
          "Celery root": false,
          "Chard": false,
          "Chayote": false,
          "Chia Seeds": false,
          "Chili Pepper": false,
          "Chinese Broccoli": false,
          "Cilantro": false,
          "Collard": false,
          "Corn": false,
          "Cress": false,
          "Cucumber": false,
          "Daikon": false,
          "Dill": false,
          "Dulse": false,
          "Eggplant": false,
          "Endive": false,
          "Fennel": false,
          "Frozen Vegetables": false,
          "Garlic": false,
          "Ginger": false,
          "Green Beans": false,
          "Hearts of Palm": false,
          "Horseradish": false,
          "Jerusalem Artichoke": false,
          "Jicama": false,
          "Kale": false,
          "Kohlrabi": false,
          "Leek": false,
          "Lettuce": false,
          "Micro Greens": false,
          "Mint": false,
          "Mixed Vegetables": false,
          "Mushroom": false,
          "Mustard Greens": false,
          "Okra": false,
          "Olive": false,
          "Onion": false,
          "Parsley": false,
          "Parsnip": false,
          "Pickle": false,
          "Pimiento": false,
          "Porcini": false,
          "Portobello Mushroom": false,
          "Potato": false,
          "Pumpkin": false,
          "Radicchio": false,
          "Radish": false,
          "Red Onion": false,
          "Rosemary": false,
          "Rutabaga": false,
          "Salad Greens": false,
          "Sauerkraut": false,
          "Scallion": false,
          "Seaweed": false,
          "Shallot": false,
          "Snow Peas": false,
          "Spaghetti Squash": false,
          "Spinach": false,
          "Squash": false,
          "Sweet Pepper": false,
          "Sweet Potato": false,
          "Turnip": false,
          "Water Chestnut": false,
          "Watercress": false,
          "Yam": false,
          "Zucchini": false
        },
        "Legumes": {
          "Black Beans": false,
          "Cannellini Beans": false,
          "Chickpeas": false,
          "Chili Beans": false,
          "Edamame": false,
          "Fava Beans": false,
          "French Beans": false,
          "Great Northern Beans": false,
          "Green Beans": false,
          "Hummus": false,
          "Kidney Beans": false,
          "Lentils": false,
          "Lima Beans": false,
          "Navy Beans": false,
          "Peas": false,
          "Pinto Beans": false,
          "Red Beans": false,
          "Refried Beans": false,
          "Snap Peas": false,
          "Soybeans": false,
          "Split Peas": false,
          "Tofu": false
        },
        "Spices": {
          "Allspice": false,
          "Aniseed": false,
          "Bay Leaf": false,
          "Cacao": false,
          "Cajun Seasoning": false,
          "Caraway": false,
          "Cardamom": false,
          "Cayenne": false,
          "Celery Salt": false,
          "Celery Seed": false,
          "Chile Powder": false,
          "Chili Paste": false,
          "Chili Powder": false,
          "Chinese Five Spice": false,
          "Chipotle": false,
          "Chive": false,
          "Cinnamon": false,
          "Clove": false,
          "Coriander": false,
          "Cumin": false,
          "Curry Powder": false,
          "Dill Seed": false,
          "Fennel Seed": false,
          "Fenugreek": false,
          "Garam Masala": false,
          "Garlic Powder": false,
          "Ground Coriander": false,
          "Ground Ginger": false,
          "Ground Nutmeg": false,
          "Herbes de Provence": false,
          "Herbs": false,
          "Italian Herbs": false,
          "Italian Seasoning": false,
          "Italian Spice": false,
          "Jamaican Jerk Spice": false,
          "Lavender": false,
          "Lemon Balm": false,
          "Marjoram": false,
          "Mustard Seed": false,
          "Nutmeg": false,
          "Old Bay Seasoning": false,
          "Onion Flakes": false,
          "Onion Powder": false,
          "Oregano": false,
          "Paprika": false,
          "Peppercorn": false,
          "Poultry Seasoning": false,
          "Red Pepper Flakes": false,
          "Saffron": false,
          "Sage": false,
          "Star Anise": false,
          "Steak Seasoning": false,
          "Taco Seasoning": false,
          "Tamarind": false,
          "Tarragon": false,
          "Thyme": false,
          "Turmeric": false,
          "Vanilla": false,
          "Vanilla Extract": false
        },
        "Condiments": {
          "Adobo Sauce": false,
          "Apple Cider Vinegar": false,
          "Balsamic Vinegar": false,
          "Barbecue Sauce": false,
          "Blue Cheese Dressing": false,
          "Buffalo Sauce": false,
          "Caesar Dressing": false,
          "Champagne Vinegar": false,
          "Chili Sauce": false,
          "Cider Vinegar": false,
          "Cocktail Sauce": false,
          "Cream Sauce": false,
          "Duck Sauce": false,
          "Enchilada Sauce": false,
          "Fish Sauce": false,
          "French Dressing": false,
          "Hoisin Sauce": false,
          "Honey Mustard": false,
          "Hot Sauce": false,
          "Italian Dressing": false,
          "Ketchup": false,
          "Marsala": false,
          "Mayonnaise": false,
          "Mirin": false,
          "Mustard": false,
          "Oyster Sauce": false,
          "Picante Sauce": false,
          "Pickapeppa Sauce": false,
          "Ponzu": false,
          "Ranch Dressing": false,
          "Rice Vinegar": false,
          "Salad Dressing": false,
          "Sesame Dressing": false,
          "Soy Sauce": false,
          "Sriracha": false,
          "Steak Sauce": false,
          "Sweet and Sour Sauce": false,
          "Tabasco": false,
          "Taco Sauce": false,
          "Tahini": false,
          "Tartar Sauce": false,
          "Teriyaki": false,
          "Thousand Island": false,
          "Tzatziki Sauce": false,
          "Vinaigrette Dressing": false,
          "Vinegar": false,
          "Wine Vinegar": false,
          "Worcestershire": false,
          "Yuzu Juice": false
        },
        "Seasoning": {
          "Accent Seasoning": false,
          "Adobo Seasoning": false,
          "Apple Cider": false,
          "Balsamic Glaze": false,
          "BBQ Rub": false,
          "Bouillon": false,
          "Brine": false,
          "Caribbean Jerk Seasoning": false,
          "Cassia": false,
          "Cream of Tartar": false,
          "Kasuri Methi": false,
          "Liquid Smoke": false,
          "Mango Powder": false,
          "Matcha Powder": false,
          "Miso": false,
          "Mustard Powder": false,
          "Pickling Salt": false,
          "Pickling Spice": false,
          "Poppy Seed": false,
          "Rice Wine": false,
          "Rose Water": false,
          "Sesame Seed": false,
          "Vegetable Bouillon": false,
          "Wasabi": false
        },
        "Oils": {
          "Almond Oil": false,
          "Avocado Oil": false,
          "Canola Oil": false,
          "Coconut Oil": false,
          "Cooking Spray": false,
          "Corn Oil": false,
          "Grape Seed Oil": false,
          "Hazelnut Oil": false,
          "Lard": false,
          "Mustard Oil": false,
          "Olive Oil": false,
          "Palm Oil": false,
          "Peanut Oil": false,
          "Pistachio Oil": false,
          "Safflower Oil": false,
          "Sesame Oil": false,
          "Shortening": false,
          "Soya Oil": false,
          "Soybean Oil": false,
          "Sunflower Oil": false,
          "Vegetable Oil": false,
          "Walnut Oil": false
        },
        "Added Sweetners": {
          "Agave Nectar": false,
          "Artificial Sweetener": false,
          "Brown Sugar": false,
          "Confectioners": false,
          "Sugarcorn Syrup": false,
          "Honey": false,
          "Maple Syrup": false,
          "Molasses": false,
          "Sugar": false
        },
        "Sauces": {
          "Alfredo Sauce": false,
          "Beef Gravy": false,
          "Chicken Gravy": false,
          "Cranberry Sauce": false,
          "Cream Gravy": false,
          "Curry Paste": false,
          "Giblet Gravy": false,
          "Mushroom Gravy": false,
          "Onion Gravy": false,
          "Pesto": false,
          "Pork Gravy": false,
          "Salsa": false,
          "Sausage Gravy": false,
          "Tomato Gravy": false,
          "Tomato Paste": false,
          "Tomato Sauce": false,
          "Turkey Gravy": false
        },
        "Soup": {
          "Beef Broth": false,
          "Celery Soup": false,
          "Chicken Broth": false,
          "Chicken Soup": false,
          "Dashi": false,
          "Fish Stock": false,
          "Lamb Stock": false,
          "Mushroom Soup": false,
          "Onion Soup": false,
          "Pork Stock": false,
          "Tomato Soup": false,
          "Veal Stock": false,
          "Vegetable Soup": false,
          "Vegetable Stock": false
        },
        "Nuts": {
          "Almond": false,
          "Almond Butter": false,
          "Almond Meal": false,
          "Almond Paste": false,
          "Cashew": false,
          "Cashew Butter": false,
          "Chestnut": false,
          "Flax": false,
          "Hazelnut": false,
          "Macadamia": false,
          "Macaroon": false,
          "Peanut": false,
          "Peanut Butter": false,
          "Pecan": false,
          "Pine Nut": false,
          "Pistachio": false,
          "Praline": false,
          "Walnut": false
        },
        "Dairy Alternatives": {
          "Almond Milk": false,
          "Coconut Milk": false,
          "Hemp Milk": false,
          "Margarine": false,
          "Non-dairy Creamer": false,
          "Oat Milk": false,
          "Rice Milk": false,
          "Soy Milk": false
        },
        "Desserts & Snacks": {
          "Amaretti Cookies": false,
          "Apple Jelly": false,
          "Apple Sauce": false,
          "Apricot Jam": false,
          "Biscotti": false,
          "Biscuit": false,
          "Bittersweet Chocolate": false,
          "Black Pudding": false,
          "Blackberry Preserves": false,
          "Blueberry Jam": false,
          "Brownie Mix": false,
          "Butterscotch": false,
          "Candy": false,
          "Caramel": false,
          "Cherry Jam": false,
          "Chilli Jam": false,
          "Chocolate": false,
          "Chocolate Bar": false,
          "Chocolate Chips": false,
          "Chocolate Cookies": false,
          "Chocolate Morsels": false,
          "Chocolate Powder": false,
          "Chocolate Pudding": false,
          "Chocolate Syrup": false,
          "Chocolate Wafer": false,
          "Cinnamon Roll": false,
          "Cookie Crumb": false,
          "Cookie Dough": false,
          "Cookies": false,
          "Corn Chips": false,
          "Currant Jelly": false,
          "Dark Chocolate": false,
          "Doritos": false,
          "Doughnuts": false,
          "Fig Jam": false,
          "Fudge": false,
          "Graham Crackers": false,
          "Grape Jelly": false,
          "Gummy Worms": false,
          "Jalapeno Jelly": false,
          "Jam": false,
          "Jello": false,
          "Lady Fingers": false,
          "Lemon Jelly": false,
          "Marshmallow": false,
          "Mint Jelly": false,
          "Nutella": false,
          "Orange Jelly": false,
          "Oreo": false,
          "Peach Preserves": false,
          "Plum Jam": false,
          "Potato Chips": false,
          "Pudding Mix": false,
          "Quince Jelly": false,
          "Raspberry Jam": false,
          "Red Pepper Jelly": false,
          "Strawberry Jam": false,
          "White Chocolate": false
        }
      },
      'diet': null,
      'intolerences': {
        'Dairy': false,
        'Egg': false,
        'Gluten': false,
        'Grain': false,
        'Peanut': false,
        'Seafood': false,
        'Sesame': false,
        'Shellfish': false,
        'Soy': false,
        'Sulfite': false,
        'Tree Nut': false,
        'Wheat': false,
      },
    };

    return await _db
        .collection('Users')
        .doc(this.uid)
        .set(userData)
        .then((value) => print('User created'))
        .catchError(
            (err) => print("Failed to create instance of user $uid : $err"));
  }

  //return map of userdata
  UserData _userdataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid.toString(),
      username: snapshot.get('username'),
      diet: snapshot.get('diet'),
      intolerences: snapshot.get('intolerences'),
    );
  }

  //UserData Stream
  Stream<UserData> get userdata {
    return _db
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map(_userdataFromSnapshot);
  }

  //Update userdata
  Future<void> updateUserData(UserData userdata) async {
    return await _db
        .collection('Users')
        .doc(uid)
        .update({
          'intolerences': userdata.userIntolerences,
          'diet': userdata.userDiet
        })
        .then((value) => print("userdata updated"))
        .catchError((err) => print(err));
  }

  //return map of ingredients to user
  Map<String, dynamic> _ingredientsFromSnapshot(DocumentSnapshot snapshot) {
    //print(snapshot.get('ingredients'));
    return snapshot.get('ingredients');
  }

  //ingredient Stream
  Stream<Map<String, dynamic>> get ingredients {
    return _db
        .collection('Users')
        .doc(uid)
        .snapshots()
        .map(_ingredientsFromSnapshot);
  }

  //saved Recipe Stream
  Stream<List<Recipe>> get savedRecipes {
    return _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .snapshots()
        .map(_savedRecipesFromSnapshot);
  }

  //List Recipe
  List<Recipe> _savedRecipesFromSnapshot(QuerySnapshot snapshot) {
    List<Recipe> recipes = [];
    List<RecipeIngredient> recipeIngredients;
    List<RecipeStep> recipeSteps;
    try {
      snapshot.docs.forEach((recipe) {
        recipeIngredients = [];
        recipeSteps = [];

        List<dynamic> stepsData = recipe.get('steps');
        stepsData.forEach((step) {
          recipeSteps.add(
            RecipeStep(
              number: step['number'],
              step: step['step'],
              ingredients:
                  step['ingredients'].cast<String>(), //fix this  type error
            ),
          );
        });

        List<dynamic> ingredientsData = recipe.get('ingredients');
        ingredientsData.forEach((ingredient) {
          recipeIngredients.add(
            RecipeIngredient(
              amount: double.parse(ingredient['amount'].toString()),
              name: ingredient['name'],
              original: ingredient['original'],
              units: ingredient['units'],
            ),
          );
        });

        recipes.add(
          Recipe(
            id: recipe.get('id'),
            title: recipe.get('title'),
            readyInMinutes: recipe.get('readyInMinutes'),
            summary: recipe.get('summary'),
            steps: recipeSteps,
            ingredients: recipeIngredients,
            imgLink: recipe.get('imgLink'),
            vegetarian: recipe.get('vegetarian'),
            vegan: recipe.get('vegan'),
            glutenFree: recipe.get('glutenFree'),
            dairyFree: recipe.get('dairyFree'),
            veryHealthy: recipe.get('veryHealthy'),
            cheap: recipe.get('cheap'),
            veryPopular: recipe.get('veryPopular'),
            sustainable: recipe.get('sustainable'),
          ),
        );
      });
    } catch (err) {
      throw err.toString();
    }

    return recipes;
  }

  //Stream of saved recipe ids
  Stream<List<int>> get savedRecipeIds {
    return _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .snapshots()
        .map(_savedRecipeIdsFromSnapshot);
  }

  //List recipeids
  List<int> _savedRecipeIdsFromSnapshot(QuerySnapshot snapshot) {
    List<int> recipeIds = [];
    snapshot.docs.forEach((doc) => recipeIds.add(int.parse(doc.id)));
    return recipeIds;
  }

  //update users inventory of ingredients
  Future<void> updateIngredients(Map<String, dynamic> data) async {
    return await _db
        .collection('Users')
        .doc(uid)
        .update({'ingredients': data})
        .then((value) => print("ingredients updated"))
        .catchError((err) => print(err));
  }

  // favorites recipe for user
  Future<void> favoriteRecipe(Recipe recipe) async {
    //favoriteRecipeList(recipe);
    return await _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .doc(recipe.id.toString())
        .set(recipe.toMap())
        .then((value) => print('Favorited recipe: ${recipe.id}'))
        .catchError((err) => print(err));
  }

  // unfavorites recipe for user
  Future<void> unfavoriteRecipe(Recipe recipe) async {
    //favoriteRecipeList(recipe);
    return await _db
        .collection('Users')
        .doc(uid)
        .collection('SavedRecipes')
        .doc(recipe.id.toString())
        .delete()
        .then((value) => print('unfavorited recipe: ${recipe.id}'))
        .catchError((err) => print(err));
  }

  
  Future<void> favoriteRecipeList(Recipe recipe, List<dynamic> recipes) async {
    return await _db
        .collection('Users')
        .doc(uid)
        .update(
          {
            'saved_recipe': [recipe.id]
          },
          // SetOptions(
          //   merge: true,
          // ),
        )
        .then((value) => print('Favorited recipe added to List: ${recipe.id}'))
        .catchError((err) => print(err));
  }
}
