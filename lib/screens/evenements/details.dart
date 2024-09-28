import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/evenement.dart';
import '../others/animatedAvatar.dart';
import 'create.dart';
class EventDetailPage extends StatelessWidget {
  final Event event;

  EventDetailPage({required this.event});

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
                  color: Config.myBackgroundColor,
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
                    // Titre de l'événement
                    Text(
                      event.title,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                    SizedBox(height: 8),

                    // Date et Heure
                    Text(
                      'Date: ${DateFormat('dd/MM/yyyy').format(event.date)}',
                      style: Config.mySmallTextSlyele,
                    ),
                    Text(
                      'Heure: ${event.time.format(context)}',
                      style: Config.mySmallTextSlyele,
                    ),
                    SizedBox(height: 8),

                    // Lieu
                    Text(
                      'Lieu: ${event.location}',
                      style: Config.mySmallTextSlyele,
                    ),
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
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Aucune remarque pour cet événement.',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  overflow: TextOverflow.ellipsis
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    Container(),

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
                              foregroundColor: Colors.white, backgroundColor: Color(0xffff7f50),
                            ),
                            onPressed: () {
                              // Action pour modifier l'événement
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateEventPage(),
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
                              foregroundColor: Colors.white, backgroundColor: Colors.red,
                              padding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              // Action pour supprimer l'événement
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
              'Êtes-vous sûr de vouloir supprimer cet événement ?',
              style: TextStyle()
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Annuler',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Action pour supprimer l'événement
                Navigator.pop(context);
                // Ajoutez ici le code pour la suppression de l'événement
              },
              child: const Text(
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
