import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/task.dart';
import 'create.dart';
import 'details.dart';

class MeetingPlanningPage extends StatelessWidget {
  final List<Tasks> _meetings = [
    Tasks(
      title: 'Tâches A',
      date: DateTime(2024, 9, 2),
      time: TimeOfDay(hour: 14, minute: 30),
      location: 'Salle de réunion 1',
      description: 'Discussion sur le projet X et autres projets',
    ),
    Tasks(
      title: 'Tâches B',
      date: DateTime(2023, 9, 2),
      time: TimeOfDay(hour: 10, minute: 0),
      location: 'Salle de réunion 2',
      description: 'Planification des tâches prochaines',
    ),
    Tasks(
      title: 'Tâches D',
      date: DateTime(2024, 8, 30),
      time: TimeOfDay(hour: 12, minute: 47),
      location: 'Salle de réunion 2',
      description: 'Planification des tâches prochaines',
    ),
    Tasks(
      title: 'Tâches C',
      date: DateTime(2024, 7, 30),
      time: TimeOfDay(hour: 12, minute: 51),
      location: 'Salle de réunion 2',
      description: 'Planification des tâches prochaines',
    ),
    // Ajoutez d'autres réunions ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        backgroundColor: Config.myAppBarBackgroundColor,
        centerTitle: true,
        title: Text(
          'Tâches',
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
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _meetings.length,
        itemBuilder: (context, index) {
          final meeting = _meetings[index];
          final status = meeting.getStatus();
          final icon = meeting.getStatusIcon();
          final color = meeting.getStatusColor();

          return FadeIn(
            duration: Duration(milliseconds: 500 + index * 100), // Délais progressif pour chaque élément
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                color: Config.myBackgroundColor,
                elevation: 5.0,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(
                    meeting.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${DateFormat('dd/MM/yyyy').format(meeting.date)}'),
                      Text('Heure: ${meeting.time.format(context)}'),
                      Text('Lieu: ${meeting.location}'),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Description: ${meeting.description}',
                          style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                          overflow: TextOverflow.ellipsis
                        ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: color,
                        size: 28.0,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        status,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeetingDetailPage(meeting: meeting),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateMeetingPage()),
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

class FadeIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  FadeIn({required this.child, required this.duration});

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
