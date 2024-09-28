import 'package:flutter/material.dart';
import 'package:easy_mtp/models/user.dart';

class Meeting {
  late final String title;
  late final String description;
  late final DateTime startDate;
  late final DateTime dueDate;
  List<User> assignedUsers;
  String status;

  Meeting({
    required this.title,
    required this.description,
    required this.startDate,
    required this.dueDate,
    this.status = 'En cours',
    required this.assignedUsers,
  });

  // Méthode pour ajouter un utilisateur à la tâche
  void assignUser(User user) {
    if (!assignedUsers.contains(user)) {
      assignedUsers.add(user);
    }
  }

  // Méthode pour retirer un utilisateur de la tâche
  void removeUser(User user) {
    assignedUsers.remove(user);
  }

  // Méthode pour mettre à jour le statut de la tâche
  void updateStatus(String newStatus) {
    status = newStatus;
  }

  // Méthode pour obtenir le statut basé sur les dates
  String getStatus() {
    final now = DateTime.now();
    if (dueDate.isBefore(now)) {
      return 'Finalisée';
    } else if (startDate.isBefore(now) && dueDate.isAfter(now)) {
      return 'En cours';
    } else {
      return 'En attente';
    }
  }

  // Méthode pour obtenir l'icône basée sur le statut
  IconData getStatusIcon() {
    switch (getStatus()) {
      case 'En cours':
        return Icons.access_time;
      case 'En attente':
        return Icons.hourglass_empty;
      case 'Finalisée':
        return Icons.check;
      default:
        return Icons.access_time;
    }
  }
}
