import 'package:flutter/material.dart';
import 'package:easy_mtp/models/reunion.dart';
import 'package:easy_mtp/models/user.dart';

import '../../config.dart';
import 'create.dart';
import 'details.dart';

class TaskTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,


      appBar: AppBar(
        backgroundColor: Config.myBackgroundColor,
        centerTitle: true,
        title: Text(
            'Reunios',
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


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTaskProgressCard(
              context,
              Meeting(
                title: 'Reunion A',
                description: 'Description de la tâche A',
                startDate: DateTime(2024, 8, 25),
                dueDate: DateTime(2024, 9, 1),
                assignedUsers: [
                  User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/14.jpeg', role: Role.users),
                  User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/9.jpeg', role: Role.users),
                  User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/6.jpeg', role: Role.users),
                  User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
                  User(id: '3', name: 'Charlie', email: 'charlie@example.com', avatarUrl: 'assets/images/28.jpeg', role: Role.users),
                ],
              ),
            ),
            _buildTaskProgressCard(
              context,
              Meeting(
                title: 'Reunion B',
                description: 'Description de la tâche B',
                startDate: DateTime(2024, 9, 1),
                dueDate: DateTime(2024, 9, 7),
                assignedUsers: [
                  User(id: '4', name: 'Diana', email: 'diana@example.com', avatarUrl: 'assets/images/14.jpeg', role: Role.users),
                  User(id: '5', name: 'Edward', email: 'edward@example.com', avatarUrl: 'assets/images/15.jpeg', role: Role.users),
                  User(id: '6', name: 'Frank', email: 'frank@example.com', avatarUrl: 'assets/images/28.jpeg', role: Role.users),
                ],
              ),
            ),

            _buildTaskProgressCard(
              context,
              Meeting(
                title: 'Reunion C',
                description: 'Description de la tâche C',
                startDate: DateTime(2022, 9, 1),
                dueDate: DateTime(2023, 9, 7),
                assignedUsers: [
                  User(id: '4', name: 'Diana', email: 'diana@example.com', avatarUrl: 'assets/images/9.jpeg', role: Role.users),
                  User(id: '5', name: 'Edward', email: 'edward@example.com', avatarUrl: 'assets/images/6.jpeg', role: Role.users),
                  User(id: '6', name: 'Frank', email: 'frank@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
                ],
              ),
            ),
            _buildTaskProgressCard(
              context,
              Meeting(
                title: 'Reunion A',
                description: 'Description de la tâche A',
                startDate: DateTime(2024, 8, 25),
                dueDate: DateTime(2024, 9, 1),
                assignedUsers: [
                  User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/14.jpeg', role: Role.users),
                  User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/9.jpeg', role: Role.users),
                  User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/6.jpeg', role: Role.users),
                  User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
                  User(id: '3', name: 'Charlie', email: 'charlie@example.com', avatarUrl: 'assets/images/28.jpeg', role: Role.users),
                ],
              ),
            ),
            // Ajoutez d'autres tâches ici
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTaskPage()),
          );
        },
        child: Icon(
          Icons.add,
          color: Config.myIconColor,
        ),
        elevation: 15.0,
      ),

    );
  }







  Widget _buildTaskProgressCard(
      BuildContext context,
      Meeting task,
      ) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: Offset(2, 4),
            ),
          ],
        ),
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
            Container(
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
            SizedBox(height: 8.0),
            Container(
              height: 50.0,
              child: Stack(
                children: [
                  for (int i = 0; i < task.assignedUsers.length; i++)
                    Positioned(
                      left: i * 25.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xffff7f50).withOpacity(0.7),
                            width: 2.0,
                          ),
                        ),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(task.assignedUsers[i].avatarUrl),
                          radius: 20.0,
                        ),
                      ),
                    ),
                ],
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
            SizedBox(height: 8.0),
            Container(
              height: 4.0,
              color: _getStatusColor(task.getStatus()),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(task: task),
          ),
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
