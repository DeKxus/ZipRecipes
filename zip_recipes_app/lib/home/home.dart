import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa o FirebaseAuth
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/firebase/services/recipe_service.dart';
import 'package:zip_recipes_app/firebase/services/user_service.dart';
import 'package:zip_recipes_app/home/personal_info.dart';
import 'package:zip_recipes_app/home/recipe_page.dart';
import 'package:zip_recipes_app/home/scan.dart';
import 'package:zip_recipes_app/home/groceries.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _dragOffset = 0.0; // Controla o deslocamento da imagem

  String userName = "User";
  int currentRecipeIndex = 0;

  // Create a sample Recipe object for testing
  List<Recipe> recipes = [];

  bool isLoading = true; // Track loading state

  void _fetchRecipes() async {
    final UserService userService = UserService();
    final RecipeService recipeService = RecipeService();

    setState(() {
      isLoading = true; // Start loading
    });

    try {
      final ingredients = await userService.getUserIngredients();
      final ingredientIds =
          ingredients.map((ingredient) => ingredient.id).toList();

      if (ingredientIds.isNotEmpty) {
        recipes = await recipeService.getRecipesWithIngredients(ingredientIds);
        print('Found ${recipes.length} recipes using user ingredients.');

        if (recipes.length == 0) {
          recipes = await recipeService.getAllRecipes();
          print(
              'User has ingredients but fetched all ${recipes.length} recipes.');
        }
      } else {
        recipes = await recipeService.getAllRecipes();
        print(
            'User has no ingredients. Fetched all ${recipes.length} recipes.');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading after fetching
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _fetchRecipes();
  }

  void _fetchUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      if (user != null) {
        userName = user.email ?? user.displayName ?? "User";
      }
    });
  }

  void _changeFoodImage(int direction) {
    setState(() {
      _dragOffset = 0; // Restaura o deslocamento ao mudar de imagem
      if (direction == -1) {
        currentRecipeIndex = (currentRecipeIndex + 1) % recipes.length;
      } else if (direction == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipePage(recipe: recipes[currentRecipeIndex]),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 812,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(245, 245, 245, 1),
      ),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(), // Show loading spinner
            )
          : Stack(
              children: <Widget>[
                // Circular background
                Center(
                  child: Container(
                    width: 225,
                    height: 225,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      _dragOffset += details.primaryDelta ??
                          0; // Atualiza o deslocamento horizontal
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      if ((details.primaryVelocity ?? 0).abs() > 300) {
                        // Detecta swipe rápido
                        if (details.primaryVelocity! > 0) {
                          _changeFoodImage(1); // Swipe para a direita
                        } else {
                          _changeFoodImage(-1); // Swipe para a esquerda
                        }
                      } else {
                        // Retorna a imagem ao centro
                        _dragOffset = 0;
                      }
                    });
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Botão "voltar"
                        GestureDetector(
                          onTap: () {
                            _changeFoodImage(-1); // Swipe para esquerda
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/icons/back.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        // Conteúdo principal (imagem e título)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 45),
                            Transform.translate(
                              offset: Offset(_dragOffset, 20),
                              // Baixa a imagem ajustando a posição
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        recipes[currentRecipeIndex].image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 60),
                            // Reduz a distância entre a imagem e o título
                            Text(
                              recipes[currentRecipeIndex].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        // Botão "avançar"
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipePage(
                                    recipe: recipes[currentRecipeIndex]),
                              ),
                            );
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/icons/forward.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),



                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Espaçamento superior para posicionar no topo
                    const SizedBox(height: 70),

                    // Linha com ícone circular, email e barra de progresso
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Ícone circular
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PersonalInfoPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/icons/user_black.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                        // Espaçamento entre o ícone e o restante
                        const SizedBox(width: 16),
                        // Coluna com email e barra de progresso
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email do usuário
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            // Espaçamento entre email e barra
                            const SizedBox(height: 0),

                            // Barra de progresso com "1000 cal"
                            Row(
                              children: [
                                // Barra de progresso
                                Container(
                                  width: 120,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FractionallySizedBox(
                                    alignment: Alignment.centerLeft,
                                    widthFactor: 0.7, // Progresso da barra (70% preenchido)
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(134, 210, 147, 1),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),

                                // Espaçamento entre barra e texto "1000 cal"
                                const SizedBox(width: 8),

                                // Texto "1000 cal"
                                const Text(
                                  '1000 cal',
                                  style: TextStyle(
                                    color: Color.fromRGBO(134, 210, 147, 1),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Espaçamento adicional após a linha superior
                    const SizedBox(height: 20),

                    // Restante do conteúdo (como imagem e botões)
                    const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Adicione os widgets restantes do layout aqui
                          ],
                        ),
                      ),
                    ),
                  ],
                ),





                Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Move o conteúdo para o rodapé
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40), // Ajuste para posicionar os botões
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround, // Alinha os botões horizontalmente
                        children: [
                          // Botão de scan
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ScanPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/icons/scan.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Botão de groceries
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GroceriesListPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/icons/groceries.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),



              ],
            ),
    );
  }
}
