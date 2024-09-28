import 'package:easy_mtp/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart'; // Importation du package file_picker

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _fileName;

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      barrierColor: Color(0xffff7f50),
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
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }



  void _pickFile() async {
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
        backgroundColor: Config.myBackgroundColor,
        centerTitle: true,
        title: Text(
          'Planification',
          style: Config.myTileTextSlyle,
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
          decoration: BoxDecoration(
            color: Config.myButtonColors,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
                bottom: Radius.circular(50)
            ),
          ),
          child: Center(
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
      body: Padding(
        padding: const EdgeInsets.only(top: 38.0, left: 16.0, right: 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildTextField(
                    controller: _titleController,
                    label: 'Titre de l\'Evenement',
                  ),
                  SizedBox(height: 20.0),
                  _buildTextField(
                    controller: _titleController,
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
                      // Action pour sauvegarder l'événement
                    },
                    child: Text('Enregistrer l\'Evenement'),
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
        foregroundColor: Colors.white,
        backgroundColor: Color(0xffff7f50),
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
