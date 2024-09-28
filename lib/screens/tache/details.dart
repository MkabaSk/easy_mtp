import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config.dart';
import '../../models/task.dart';
import 'create.dart';

class MeetingDetailPage extends StatelessWidget {
  final Tasks meeting;

  MeetingDetailPage({required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Config.myIconColor),
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

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Animation d'entrée pour le titre
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: ModalRoute.of(context)!.animation!,
                  curve: Curves.easeInOut,
                )),
                child: Text(
                  meeting.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Date et Heure
              FadeTransition(
                opacity: CurvedAnimation(
                  parent: ModalRoute.of(context)!.animation!,
                  curve: Curves.easeIn,
                ),
                child: Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(meeting.date)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Text(
                'Heure: ${meeting.time.format(context)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),

              // Lieu
              Text(
                'Lieu: ${meeting.location}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),

              // Liste des participants avec animation
              Text(
                'Participants:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),


              SizedBox(height: 24),

              // Autres informations (Remarques)
              Text(
                'Remarques:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Text(
                  'Aucune remarque pour cette réunion.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Boutons d'action avec animation
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.edit),
                      label: Text('Modifier'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xffff7f50),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Action pour modifier la réunion
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateMeetingPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.delete),
                      label: Text('Supprimer'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
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
}
