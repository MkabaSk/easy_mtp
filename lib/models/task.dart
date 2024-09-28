import 'package:easy_mtp/screens/others/animatedAvatar.dart';
import 'package:flutter/material.dart';

class Tasks {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String description;

  Tasks({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });

  String getStatus() {
    final now = DateTime.now();
    final meetingDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);

    if (meetingDate.isBefore(now)) {
      return 'Finalisée'; // Statut pour les réunions passées
    } else if (meetingDate.isAfter(now) && meetingDate.isBefore(now.add(Duration(days: 1)))) {
      return 'En cours'; // Statut pour les réunions d'aujourd'hui
    } else if (meetingDate.isAfter(now)) {
      return 'En attente'; // Statut pour les réunions futures
    } else {
      return 'Finalisée'; // Par défaut, considère 'Finalisée'
    }
  }

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

  Color getStatusColor() {
    switch (getStatus()) {
      case 'En cours':
        return Colors.orange;
      case 'En attente':
        return Colors.blue;
      case 'Finalisée':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
