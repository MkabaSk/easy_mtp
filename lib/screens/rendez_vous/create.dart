import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config.dart';
import '../others/animatedAvatar.dart';

class CreateAppointmentPage extends StatefulWidget {
  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> with SingleTickerProviderStateMixin {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _status = 'À venir';
  String _type = 'Réunion';
  List<Person> _people = [
    Person('Alice', 'assets/images/6.jpeg'),
    Person('Bob', 'assets/images/9.jpeg'),
    Person('Charlie', 'assets/images/15.jpeg'),
  ];
  Set<String> _selectedPeople = {}; // Pour stocker les personnes sélectionnées

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      barrierColor:  Color(0xffff7f50),
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
      barrierColor: Color(0xffff7f50),
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        backgroundColor: Config.myAppBarBackgroundColor,
        iconTheme: IconThemeData(
          color: Config.myIconColor
        ),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0, bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField(
                controller: _titleController,
                label: 'Titre du Rendez-vous',
              ),
              const SizedBox(height: 20.0,),
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
              Text('Participants:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _people.map((person) {
                  final isSelected = _selectedPeople.contains(person.name);
                  return _buildAvatar(person, isSelected);
                }).toList(),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Action pour sauvegarder le rendez-vous avec les participants sélectionnés
                },
                child: Text('Enregistrer le Rendez-vous'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xffff7f50),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
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
        focusedBorder: Config.focusBorder,
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
        foregroundColor: Colors.white, backgroundColor: Color(0xffff7f50),
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
        border: Config.focusBorder,
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

  Widget _buildAvatar(Person person, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedPeople.remove(person.name);
          } else {
            _selectedPeople.add(person.name);
          }
        });
      },
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
          backgroundImage: AssetImage(person.imageUrl),
          radius: 25,
          child: isSelected
              ? Icon(Icons.check_circle, color: Colors.green, size: 30)
              : null,
        ),
      ),
    );
  }
}
