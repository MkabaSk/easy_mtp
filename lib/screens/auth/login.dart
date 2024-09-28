import 'package:easy_mtp/config.dart';
import 'package:easy_mtp/screens/auth/sing.dart';
import 'package:easy_mtp/screens/others/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _selectedRole = "users"; // Valeur par défaut
  String? _selectedDepartment; // Valeur par défaut null pour le département
  File? _selectedImage; // Fichier de l'image sélectionnée

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff7f50), // Couleur de fond similaire à l'image
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: SingleChildScrollView( // Ajout du SingleChildScrollView pour rendre le contenu défilable
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  height: 400,
                  width: 500,
                  child:  Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 10, right: 50, bottom: 10),
                          child: Column(
                            children: [

                              Lottie.asset(
                                'assets/lottie/loginLottie.json',
                                width: 400, // Largeur réduite
                                height: 300, // Hauteur réduite
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            Positioned(
              top: 280,
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5.0,
                  color: Config.myBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 250,
                    child: SingleChildScrollView( // Ajout d'un autre SingleChildScrollView pour cette section
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
                            child: Center(
                              child: Text(
                                "CONNEXION",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 80),

                          _buildTextField(
                            controller: _emailController,
                            icon: const Icon(Icons.email),
                            label: "Addresse mail",
                          ),
                          const SizedBox(height: 20),

                          const SizedBox(height: 40),
                          _buildTextField(
                            controller: _passwordController,
                            icon: const Icon(Icons.lock),
                            label: "Votre Mot de passe",
                          ),

                          const SizedBox(height: 40),

                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DashboardPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Config.myBackgroundColor,
                                backgroundColor: Config.myButtonColors,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                "Se connecter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          const SizedBox(height: 10,),
                          TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpPage()),
                                );
                              },
                              child: const Center(
                                child: Text(
                                    "Vous n'avez pas de compte? Crée-Un",
                                  style: TextStyle(),
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          /*  Positioned(
              top: 0,
              bottom: 550,
              right: 0,
              left: 0,
              child:  Container(
                padding: EdgeInsets.only(bottom: 50),
                child: Lottie.asset(
                  'assets/lottie/loginLottie.json',
                  width: 400, // Largeur réduite
                  height: 300, // Hauteur réduite
                ),
              ),
            ),*/
          ],
        ),
      ),

    );
  }



  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required Icon icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: label,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffff7f50), width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
    );
  }

}
