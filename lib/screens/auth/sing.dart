import 'package:easy_mtp/config.dart';
import 'package:easy_mtp/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0,  bottom: 30),
                        child: Column(
                          children: [
                            const Text(
                              "INSCRIPTION",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 25),
                            _buildImagePicker(),
                          ],
                        ),
                      ),
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
                            const SizedBox(height: 40),
                            _buildTextField(
                              controller: _usernameController,
                              icon: const Icon(Icons.person),
                              label: "Nom et Prénom",
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: _emailController,
                              icon: const Icon(Icons.email),
                              label: "Addresse mail",
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: _passwordController,
                              icon: const Icon(Icons.lock),
                              label: "Votre Mot de passe",
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: _confirmPasswordController,
                              icon: const Icon(Icons.lock),
                              label: "Confirmez votre Mot de passe",
                            ),
                            const SizedBox(height: 20),
                            _buildDropdown(
                              value: _selectedRole,
                              hint: "Sélectionnez votre rôle",
                              items: ["admin", "users", "guest"],
                              onChanged: (value) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              },
                              prefixIcon: const Icon(Icons.group),
                            ),
                            const SizedBox(height: 20),
                            _buildDropdown(
                              value: _selectedDepartment,
                              hint: "Département",
                              items: [
                                "Département 1",
                                'Département 2',
                                'Département 3'
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedDepartment = value;
                                });
                              },
                              prefixIcon: const Icon(Icons.business),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
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
                                  "S'inscrire",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                },
                                child: const Center(
                                  child: Text(
                                      "Vous avez un compte? Connectez-vous"
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

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required Icon prefixIcon,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox(), // Pour cacher la ligne par défaut
        dropdownColor: Color(0xffff7f50), // Couleur de fond du dropdown
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        selectedItemBuilder: (BuildContext context) {
          return items.map((String value) {
            return Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(color: Colors.black), // Couleur du texte pour l'élément sélectionné
                ),
              ],
            );
          }).toList();
        },
      ),
    );
  }

  Widget _buildImagePicker() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _selectedImage != null
                  ? FileImage(_selectedImage!)
                  : const AssetImage('assets/images/avatarman.png') as ImageProvider,
              child: _selectedImage == null
                  ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Sélectionnez une image",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }




}
