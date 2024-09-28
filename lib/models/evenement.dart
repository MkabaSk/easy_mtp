import 'package:flutter/material.dart';

class Event {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });

  String getStatus() {
    final now = DateTime.now();
    final eventDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);

    if (eventDate.isBefore(now)) {
      return 'Finalisé'; // Statut pour les événements passés
    } else if (eventDate.isAfter(now) && eventDate.isBefore(now.add(Duration(days: 1)))) {
      return 'En cours'; // Statut pour les événements d'aujourd'hui
    } else if (eventDate.isAfter(now)) {
      return 'À venir'; // Statut pour les événements futurs
    } else {
      return 'Finalisé'; // Par défaut, considère 'Finalisé'
    }
  }

  IconData getStatusIcon() {
    switch (getStatus()) {
      case 'En cours':
        return Icons.event;
      case 'À venir':
        return Icons.hourglass_empty;
      case 'Finalisé':
        return Icons.check_circle;
      default:
        return Icons.event;
    }
  }

  Color getStatusColor() {
    switch (getStatus()) {
      case 'En cours':
        return Colors.orange;
      case 'À venir':
        return Colors.blue;
      case 'Finalisé':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
