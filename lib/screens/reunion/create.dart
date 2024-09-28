import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/user.dart';

class CreateTaskPage extends StatefulWidget {
  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _status = 'À venir';
  String _type = 'Réunion';
  List<User> _users = [
    User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/6.jpeg', role: Role.users),
    User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/9.jpeg', role: Role.users),
    User(id: '3', name: 'Charlie', email: 'charlie@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
  ];
  Set<String> _selectedUsers = {}; // Pour stocker les utilisateurs sélectionnés
  String? _fileName;






  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      barrierColor: Color(0xffff7f50)
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }



  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      barrierColor: Color(0xffff7f50)
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }



  _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,


      appBar: AppBar(
        centerTitle: true,
        title: Text(
            'Création',
          style: Config.myTileTextSlyle,
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
          decoration: BoxDecoration(
            color: Config.myButtonColors,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
                bottom:  Radius.circular(50)
            ),
          ),
          child:  Center(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Config.myAppBarBackgroundColor,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Config.myBackgroundColor,
      ),


      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextField(
              controller: _titleController,
              label: 'Titre de la reunion',
            ),
            SizedBox(height: 20.0),
            _buildTextField(
              controller: _locationController,
              label: 'Lieu',
            ),
            SizedBox(height: 20.0),
            _buildTextField(
              controller: _descriptionController,
              label: 'Description',
              maxLines: 3,
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: _buildButton(
                    label: _selectedDate == null
                        ? 'Sélectionner la Date'
                        : 'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                    onPressed: _selectDate,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _buildButton(
                    label: _selectedTime == null
                        ? 'Sélectionner l\'Heure'
                        : 'Heure: ${_selectedTime!.format(context)}',
                    onPressed: _selectTime,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            _buildDropdown(
              value: _status,
              items: ['À venir', 'Confirmé', 'Annulé'],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              hint: 'Sélectionner un statut',
            ),
            SizedBox(height: 20.0),
            _buildDropdown(
              value: _type,
              items: ['Réunion', 'Entretien', 'Appel'],
              onChanged: (value) {
                setState(() {
                  _type = value!;
                });
              },
              hint: 'Sélectionner un type',
            ),
            SizedBox(height: 20.0),
            Text('Assigné à:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: _users.map((user) {
                final isSelected = _selectedUsers.contains(user.id);
                return _buildAvatar(user, isSelected);
              }).toList(),
            ),
            SizedBox(height: 20.0),

            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text(_fileName == null ? 'Ajouter un Fichier' : 'Fichier: $_fileName'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffff7f50),
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Action pour sauvegarder la tâche avec les utilisateurs sélectionnés
                // Vous pouvez construire un objet Task ici et le sauvegarder
              },
              child: Text('Enregistrer la Tâche'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffff7f50),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffff7f50), width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      maxLines: maxLines,
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffff7f50),
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: DropdownButton<String>(
        dropdownColor: Color(0xffff7f50),
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        underline: SizedBox(), // To hide the default underline
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAvatar(User user, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedUsers.remove(user.id);
          } else {
            _selectedUsers.add(user.id);
          }
        });
      },
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.5,
        duration: Duration(milliseconds: 300),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.green : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            backgroundImage: AssetImage(user.avatarUrl),
            radius: 25,
            child: isSelected
                ? Icon(Icons.check_circle, color: Colors.green, size: 30)
                : null,
          ),
        ),
      ),
    );
  }
}
