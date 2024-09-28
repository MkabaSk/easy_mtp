import 'package:easy_mtp/config.dart';
import 'package:flutter/material.dart';
import 'package:easy_mtp/models/reunion.dart';
import 'package:easy_mtp/models/user.dart';

import 'bottomSheetClass.dart';

class TaskDetailPage extends StatefulWidget {
  final Meeting task;

  TaskDetailPage({required this.task});

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  bool _showParticipants = true;

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Config.myBackgroundColor,
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
        title: Text(
            'Détails',
          style: Config.myTileTextSlyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                color: Colors.white,
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Début : ${task.startDate.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Fin : ${task.dueDate.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Description : ${task.description}',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(
                            task.getStatusIcon(),
                            color: _getStatusColor(task.getStatus()),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            task.getStatus(),
                            style: TextStyle(
                              color: _getStatusColor(task.getStatus()),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => TaskEditBottomSheet(task: task, availableUsers: [
                                  User(id: '4', name: 'Diana', email: 'diana@example.com', avatarUrl: 'assets/images/9.jpeg', role: Role.users),
                                  User(id: '5', name: 'Edward', email: 'edward@example.com', avatarUrl: 'assets/images/15.jpeg', role: Role.users),
                                  User(id: '5', name: 'Edward', email: 'edward@example.com', avatarUrl: 'assets/images/28.jpeg', role: Role.users),
                                  User(id: '5', name: 'Edward', email: 'edward@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
                                ],),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffff7f50)
                            ),
                            child: const Text(
                                'Modifier    ',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text(
                                'Supprimer',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _showParticipants
                  ? Card(
                color: Colors.white,
                key: ValueKey<bool>(_showParticipants),
                elevation: 5.0,
                child: Container(
                  color: Colors.white,
                  height: 80.0,
                  padding: EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: task.assignedUsers.length,
                    itemBuilder: (context, index) {
                      final user = task.assignedUsers[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xffff7f50),
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(user.avatarUrl),
                            radius: 25.0,
                            child: user.name.isNotEmpty
                                ? null
                                : Text(
                              user.id[0].toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
                  : SizedBox.shrink(),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showParticipants = !_showParticipants;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffff7f50),
              ),
              child: Text(
                  _showParticipants
                  ? 'Cacher les Participants'
                  : 'Afficher les Participants',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xffff7f50),
          title: Text(
            'Confirmer la Suppression',
            style: Config.myTileTextSlyle,
          ),
          content: Text(
              'Êtes-vous sûr de vouloir supprimer cette réunion ?',
              style: TextStyle()
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Annuler',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Action pour supprimer la réunion
                Navigator.pop(context);
                // Ajoutez ici le code pour la suppression de la réunion
              },
              child: Text(
                'Supprimer',
                style: TextStyle(
                    color: Colors.red
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours':
        return Colors.orange;
      case 'En attente':
        return Colors.blue;
      case 'Finalisée':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
