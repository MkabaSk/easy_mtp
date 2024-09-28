import 'package:easy_mtp/config.dart';
import 'package:easy_mtp/models/evenement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'create.dart';
import 'details.dart';



class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Event> _events = [
    Event(
      title: 'Evenement D',
      date: DateTime(2026, 08, 29),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'Salle de réunion 1',
      description: 'Discussion des objectifs du projet.',
    ),
    Event(
      title: 'Evenement A',
      date: DateTime(2024, 08, 29),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'Salle de réunion 1',
      description: 'Discussion des objectifs du projet.',
    ),
    Event(
      title: 'Evenement B',
      date: DateTime(2025, 08, 29),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'Salle de réunion 1',
      description: 'Discussion des objectifs du projet.',
    ),
    Event(
      title: 'Evenement F',
      date: DateTime(2022, 08, 29),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'Salle de réunion 1',
      description: 'Discussion des objectifs du projet.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(

        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Événements',
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
        backgroundColor: Config.myBackgroundColor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            final events = _events[index];
            return ScaleTransition(
              scale: _animation,
              child: GestureDetector(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(event: events,),
                      ),
                    );
                  },
                  child: Card(
                    color: Config.myBackgroundColor,
                    elevation: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            events.title,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 8.0),

                          // Statut de l'événement
                          Row(
                            children: [
                              Icon(
                                events.getStatusIcon(), // Méthode pour obtenir l'icône du statut
                                color: events.getStatusColor(), // Méthode pour obtenir la couleur du statut
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                events.getStatus(), // Méthode pour obtenir le texte du statut
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: events.getStatusColor(),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),

                          Text(
                            'Date: ${DateFormat('dd/MM/yyyy').format(events.date)}',
                            style: Config.mySmallTextSlyele,
                          ),
                          Text(
                            'Heure: ${events.time.format(context)}',
                            style: Config.mySmallTextSlyele,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Lieu: ${events.location}',
                            style: Config.mySmallTextSlyele,
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Description: ${events.description}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                overflow: TextOverflow.ellipsis
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                )
              ),
            );
          },
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventPage()),
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
}
