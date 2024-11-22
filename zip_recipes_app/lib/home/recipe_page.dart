import 'package:flutter/material.dart';
import 'package:zip_recipes_app/firebase/services/recipe.dart';
import 'package:zip_recipes_app/home/GuidePage.dart';
import 'package:zip_recipes_app/widgets/custom_pill_button.dart';
import 'package:zip_recipes_app/widgets/custom_recipe_detail_element.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;

  const RecipePage({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo branco na base
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Fundo superior cinzento
            Container(
              width: double.infinity,
              height: 400, // Define a altura do fundo cinzento
              color: const Color(0xFFF5F5F5), // Cor cinzenta
            ),
            // Círculo decorativo branco sobre o fundo cinzento
            Positioned(
              top: 110,
              left: -150,
              child: Container(
                width: 700,
                height: 700,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Conteúdo
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Espaço para o botão de voltar
                // Imagem da Receita
                Center(
                  child: Image.asset(
                    recipe.image,
                    width: 170,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
                // Adiciona espaço maior abaixo da imagem da receita
                const SizedBox(height: 20), // Aumente o valor para mais espaço
                // Título da Receita
                Center(
                  child: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Seção de Detalhes
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRecipeDetailElement(topText: 'Salt', bottomText: recipe.salt),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Fat', bottomText: recipe.fat),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Energy', bottomText: recipe.energy),
                    const SizedBox(width: 8),
                    CustomRecipeDetailElement(topText: 'Protein', bottomText: recipe.protein),
                  ],
                ),
                const SizedBox(height: 16),
                // Seção de Informações da Receita
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Text(
                    'Recipe',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    recipe.information,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Botão Cook It
                Center(
                  child: CustomPillButton(
                    text: 'COOK IT',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuidePage(
                            guide: recipe.guide,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Ingredientes
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Wrap(
                    spacing: 8.0, // Espaço entre os "pills" horizontalmente
                    runSpacing: 8.0, // Espaço entre as linhas
                    alignment: WrapAlignment.center, // Centraliza os ingredientes
                    children: recipe.ingredients.map((ingredient) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ingredient.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
            // Botão Voltar Fixo
            Positioned(
              top: MediaQuery.of(context).padding.top + 10, // Ajuste para o status bar
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
