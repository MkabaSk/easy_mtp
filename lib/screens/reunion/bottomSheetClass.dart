import 'package:easy_mtp/config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/reunion.dart';
import '../../models/user.dart';

class TaskEditBottomSheet extends StatefulWidget {
  final Meeting task;
  final List<User> availableUsers; // Liste des utilisateurs disponibles

  TaskEditBottomSheet({required this.task, required this.availableUsers});

  @override
  _TaskEditBottomSheetState createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends State<TaskEditBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedStartDate;
  DateTime? _selectedDueDate;
  String _status = 'En cours';
  Set<User> _selectedUsers = {};

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _selectedStartDate = widget.task.startDate;
    _selectedDueDate = widget.task.dueDate;
    _status = widget.task.status;
    _selectedUsers = widget.task.assignedUsers.toSet();
  }

  void _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      barrierColor: Color(0xffff7f50),
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  void _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      barrierColor: Color(0xffff7f50),
    );
    if (picked != null && picked != _selectedDueDate) {
      setState(() {
        _selectedDueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          )
        ),
        padding: EdgeInsets.only(top: 25.0, left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTextField(
              controller: _titleController,
              label: 'Titre de la Tâche',
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
                    label: _selectedStartDate == null
                        ? 'Sélectionner la Date de Début'
                        : 'Début: ${DateFormat('dd/MM/yyyy').format(_selectedStartDate!)}',
                    onPressed: _selectStartDate,
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: _buildButton(
                    label: _selectedDueDate == null
                        ? 'Sélectionner la Date d\'Échéance'
                        : 'Échéance: ${DateFormat('dd/MM/yyyy').format(_selectedDueDate!)}',
                    onPressed: _selectDueDate,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            _buildDropdown(
              value: _status,
              items: ['En cours', 'En attente', 'Finalisée'],
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              hint: 'Sélectionner un statut',
            ),
            SizedBox(height: 20.0),

            Text('Assigné à:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: _selectedUsers.map((user) {
                return Chip(
                  avatar: CircleAvatar(backgroundImage: AssetImage(user.avatarUrl)),
                  label: Text(
                    user.name,
                    style: Config.mySmallTextSlyele,
                  ),
                  onDeleted: () {
                    setState(() {
                      _selectedUsers.remove(user);
                    });
                  },
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xffff7f50)), // Bordure de la même couleur que les boutons
                );
              }).toList(),
            ),
            SizedBox(height: 10.0),

            Text('Ajouter des utilisateurs à la tâche:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.0),
            Container(
              height: 60.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.availableUsers.map((user) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      avatar: CircleAvatar(backgroundImage: AssetImage(user.avatarUrl)),
                      label: Text(user.name),
                      selected: _selectedUsers.contains(user),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedUsers.add(user);
                          } else {
                            _selectedUsers.remove(user);
                          }
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Color(0xffff7f50), // Couleur lorsque sélectionné
                      side: BorderSide(color: Color(0xffff7f50)), // Bordure de la même couleur que les boutons
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20.0),



            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.task.title = _titleController.text;
                  widget.task.description = _descriptionController.text;
                  widget.task.startDate = _selectedStartDate!;
                  widget.task.dueDate = _selectedDueDate!;
                  widget.task.status = _status;
                  widget.task.assignedUsers = _selectedUsers.toList();
                });
                Navigator.pop(context, widget.task);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff7f50),
              ),
              child: const Text(
                'Enregistrer la Tâche',
                style: TextStyle(color: Colors.white),
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
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffff7f50),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
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
      ),
      child: DropdownButton<String>(
        dropdownColor: Color(0xffff7f50),
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
