import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/rendez_vous.dart';
import '../others/animatedAvatar.dart';
import 'create.dart'; // Assurez-vous que ce chemin est correct

class AppointmentDetailPage extends StatelessWidget {
  final Appointment appointment;

  AppointmentDetailPage({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Config.myIconColor
        ),
        backgroundColor: Config.myAppBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Détails',
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
        padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
        child: Column(
          children: [
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre du rendez-vous
                    Text(
                      appointment.title,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                    SizedBox(height: 8),

                    // Date et Heure
                    Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(appointment.date)}',
                      style: Config.mySmallTextSlyele,
                    ),
                    Text(
                      'Heure: ${appointment.time.format(context)}',
                      style: Config.mySmallTextSlyele,
                    ),
                    SizedBox(height: 8),

                    // Lieu
                    Text(
                      'Lieu: ${appointment.location}',
                      style: Config.mySmallTextSlyele,
                    ),
                    SizedBox(height: 16),

                    // Liste des participants avec animation
                    Text(
                      'Participants:',
                      style: Config.mySmallTextSlyele,
                    ),
                    SizedBox(height: 18),
                    Wrap(
                      spacing: 8.0, // Espace entre les avatars
                      children: appointment.participants.map((participant) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xffff7f50),
                              width: 2.0,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(participant.imageUrl), // Assurez-vous que votre modèle Participant a un champ imageUrl
                            radius: 20.0, // Ajustez la taille de l'avatar
                          ),
                        );
                      }).toList(),
                    ),
                    // Autres informations (optionnel)
                    SizedBox(height: 8),
                    Text(
                      'Remarques:',
                      style: Config.mySmallTextSlyele,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            child:  Text(
                              'Aucune remarque pour ce rendez-vous.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Boutons d'action
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.edit),
                            label: Text('Modifier'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xffff7f50),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAppointmentPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.delete),
                            label: Text('Supprimer'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
          content: const Text(
              'Êtes-vous sûr de vouloir supprimer ce rendez-vous ?',
              style: TextStyle()
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Annuler',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Ajoutez ici le code pour la suppression de la réunion
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
