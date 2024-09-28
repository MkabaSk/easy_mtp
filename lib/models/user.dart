import 'package:easy_mtp/models/reunion.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final Role role;
  final Department? department; // Peut être null pour les chefs d'entreprise qui ne sont pas affectés à un département
  final List<Meeting> assignedTasks; // Les tâches assignées à cet utilisateur

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.role,
    this.department,
    this.assignedTasks = const [],
  });

  // Méthode pour ajouter une tâche à l'utilisateur
  void assignTask(Meeting task) {
    assignedTasks.add(task);
  }

  // Méthode pour retirer une tâche de l'utilisateur
  void removeTask(Meeting task) {
    assignedTasks.remove(task);
  }

  // Méthode pour mettre à jour le statut d'une tâche
  void updateTaskStatus(Meeting task, String newStatus) {
    final taskIndex = assignedTasks.indexOf(task);
    if (taskIndex != -1) {
      assignedTasks[taskIndex].updateStatus(newStatus);
    }
  }
}

enum Role {
  CEO, // Chef d'entreprise
  users
}

class Department {
  final String id;
  final String name;
  final String description;

  Department({
    required this.id,
    required this.name,
    required this.description,
  });
}
