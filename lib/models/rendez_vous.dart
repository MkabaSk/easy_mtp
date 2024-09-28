import 'package:flutter/material.dart';

import '../screens/others/animatedAvatar.dart';

class Appointment {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  final String location;
  final List<Person> participants;
  final String description;

  Appointment({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.participants,
    required this.description
  });
}

String getStatus(Appointment appointment) {
  final now = DateTime.now();
  final appointmentDate = DateTime(
    appointment.date.year,
    appointment.date.month,
    appointment.date.day,
    appointment.time.hour,
    appointment.time.minute,
  );

  if (appointmentDate.isBefore(now)) {
    return 'Finalisé'; // Statut pour les rendez-vous passés
  } else if (appointmentDate.isAfter(now) && appointmentDate.isBefore(now.add(Duration(days: 1)))) {
    return 'En cours'; // Statut pour les rendez-vous d'aujourd'hui
  } else if (appointmentDate.isAfter(now)) {
    return 'En attente'; // Statut pour les rendez-vous futurs
  } else {
    return 'En attente'; // Par défaut, considère 'En attente'
  }
}

