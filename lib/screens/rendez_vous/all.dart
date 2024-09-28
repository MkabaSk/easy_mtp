import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config.dart';
import '../../models/rendez_vous.dart';
import '../others/animatedAvatar.dart';
import 'create.dart';
import 'details.dart';

class AppointmentListPage extends StatelessWidget {
  final List<Appointment> _appointments = [
    Appointment(
        title: 'Réunion de projet',
        date: DateTime(2024, 9, 15),
        time: TimeOfDay(hour: 10, minute: 0),
        location: 'Salle de conférence A',
        participants: [
          Person('Alice', 'assets/images/6.jpeg'),
          Person('Bob', 'assets/images/9.jpeg'),
          Person('Charlie', 'assets/images/15.jpeg'),
        ],
        description: 'Un exemple de description du rendez-vous'
    ),
    Appointment(
      title: 'Entretien de recrutement',
      date: DateTime(2024, 9, 16),
      time: TimeOfDay(hour: 14, minute: 30),
      location: 'Bureau RH',
      participants: [
        Person('Charlie', 'assets/images/9.jpeg'),
        Person('David', 'assets/images/6.jpeg'),
      ],
      description: 'Rendez-vous avec le chef de projet pour voir l\'evolution du projet',
    ),
    // Ajoute d'autres rendez-vous ici
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Config.myIconColor),
        centerTitle: true,
        backgroundColor: Config.myBackgroundColor,
        title: Text(
          'Rendez-vous',
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
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final appointment = _appointments[index];
          final status = getStatus(appointment); // Utilisation de la méthode getStatus

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimatedAppointmentCard(
              appointment: appointment,
              status: status,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateAppointmentPage()),
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

class AnimatedAppointmentCard extends StatefulWidget {
  final Appointment appointment;
  final String status;

  AnimatedAppointmentCard({required this.appointment, required this.status});

  @override
  _AnimatedAppointmentCardState createState() => _AnimatedAppointmentCardState();
}

class _AnimatedAppointmentCardState extends State<AnimatedAppointmentCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 5.0,
          child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.appointment.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(widget.appointment.date)}',
                  style: Config.mySmallTextSlyele,
                ),
                Text(
                  'Heure: ${widget.appointment.time.format(context)}',
                  style: Config.mySmallTextSlyele,
                ),
                Text(
                  'Lieu: ${widget.appointment.location}',
                  style: Config.mySmallTextSlyele,
                ),
                Text(
                  'Description:',
                  style: Config.mySmallTextSlyele,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '${widget.appointment.description}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      overflow: TextOverflow.ellipsis
                  ),
                  ),
                ),
                SizedBox(height: 25),
                AnimatedAvatars(participants: widget.appointment.participants),
              ],
            ),
            trailing: Chip(
              label: Text(widget.status),
              backgroundColor: widget.status == 'En cours' ? Colors.orange : widget.status == 'Finalisé' ? Colors.red : Colors.green,
              labelStyle: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppointmentDetailPage(appointment: widget.appointment),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
