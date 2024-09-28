import 'dart:async';
import 'dart:ui';
import 'package:easy_mtp/config.dart';
import 'package:easy_mtp/screens/auth/login.dart';
import 'package:flutter/material.dart';
import '../../models/evenement.dart';
import '../../models/rendez_vous.dart';
import '../../models/task.dart';
import '../../models/reunion.dart';
import '../../models/user.dart';
import '../evenements/all.dart';
import '../evenements/details.dart';
import '../rendez_vous/all.dart';
import '../rendez_vous/details.dart'; // Assurez-vous que le chemin est correct
import '../reunion/all.dart';
import '../reunion/details.dart';
import '../tache/all.dart';
import '../tache/details.dart';
import 'animatedAvatar.dart';
import '../notifications/notifications.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _items = [
    {'title': 'Événement', 'icon': Icons.event, 'color': Colors.red, 'info': 'Informations sur Événement'},
    {'title': 'Rendez-vous', 'icon': Icons.calendar_month, 'color': Colors.blue, 'info': 'Informations sur Rendez-vous'},
    {'title': 'Réunion', 'icon': Icons.meeting_room, 'color': Colors.green, 'info': 'Informations sur Réunion'},
    {'title': 'Tâches', 'icon': Icons.track_changes, 'color': Colors.purple, 'info': 'Informations sur Tâches'},
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late Timer _timer;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_items.isNotEmpty) {
        final item = _items.removeAt(0);
        _items.add(item);
        _listKey.currentState?.removeItem(
          0,
              (context, animation) => _buildItem(context, item, animation),
        );
        Future.delayed(const Duration(milliseconds: 300), () {
          _listKey.currentState?.insertItem(_items.length - 1);
        });
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Config.myIconColor,
          size: 30
        ),
        backgroundColor: Config.myAppBarBackgroundColor,
        centerTitle: true,
        title: Text(
            'Accueil',
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
            child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu_outlined,
                color: Config.myAppBarBackgroundColor,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Config.myBackgroundColor,
        child: Column(
          children: <Widget>[
            // Drawer Header
            Container(
              height: 250,
              width: 310,// Réduisez la hauteur si nécessaire
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xffff7f50).withOpacity(0.9),
                ),
                child:  SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2), // Espace entre l'image et la bordure
                        decoration: BoxDecoration(
                          color: Colors.white, // Couleur du cercle extérieur (optionnel, pour le contraste)
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:  Colors.white, // Couleur de la bordure
                            width: 3.0, // Épaisseur de la bordure
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            'assets/images/9.jpeg',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                          'sK junior',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                      ),
                      const Text(
                          'mkaba8248@gmail.com',
                          style: TextStyle(
                              fontSize: 16,
                            color: Colors.black54
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            // Liste des éléments du Drawer
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                        Icons.event,
                    ),
                    title: const Text('Événements'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailPage(
                            event: Event(
                              title: 'Événement Spécial',
                              date: DateTime.now().add(const Duration(days: 5)),
                              location: 'Salle de Conférence',
                              description: 'Description de l\'événement.',
                              time: TimeOfDay.now(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(color: Color(0xffff7f50).withOpacity(0.5), thickness: 1,),
                  ListTile(
                    leading: const Icon(Icons.schedule),
                    title: const Text('Rendez-vous'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AppointmentDetailPage(
                            appointment: Appointment(
                              title: 'Réunion Importante',
                              date: DateTime.now(),
                              time: TimeOfDay.now(),
                              location: 'Bureau Principal',
                              participants: [
                                Person('Alice', 'assets/images/6.jpeg'),
                                Person('Bob', 'assets/images/9.jpeg'),
                              ],
                              description: 'Détails du rendez-vous.',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(color: Color(0xffff7f50).withOpacity(0.5), thickness: 1,),
                  ListTile(
                    leading: const Icon(Icons.meeting_room),
                    title: const Text('Réunions'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeetingDetailPage(
                            meeting: Tasks(
                              title: 'Réunion d\'Équipe',
                              date: DateTime.now(),
                              time: TimeOfDay.now(),
                              location: 'Salle de Réunion',
                              description: 'Description de la réunion.',
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(color: Color(0xffff7f50).withOpacity(0.5), thickness: 1,),
                  ListTile(
                    leading: const Icon(Icons.task),
                    title: const Text('Tâches'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetailPage(
                            task: Meeting(
                              title: 'Tâche Critique',
                              description: 'Description de la tâche.',
                              startDate: DateTime.now(),
                              dueDate: DateTime.now().add(const Duration(days: 2)),
                              assignedUsers: [
                                User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: '', role: Role.users),
                                User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: '', role: Role.users),
                              ],
                              status: 'En cours',
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                ],
              ),
            ),
            Divider(color: Color(0xffff7f50).withOpacity(0.5), thickness: 1,),
            ListTile(
              leading: const Icon(
                  Icons.logout,
                color: Colors.red,
              ),
              title:   const Text(
                  'Déconnexion',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            Divider(color: Color(0xffff7f50).withOpacity(0.5), thickness: 1,),


          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true, // S'adapte à la taille des enfants
              physics: const NeverScrollableScrollPhysics(), // Désactive le scrolling pour la grille
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildDashboardCard('Rendez-vous', Icons.calendar_month, Colors.grey[50]!, context, AppointmentListPage()),
                _buildDashboardCard('Taches', Icons.meeting_room, Colors.grey[50]!, context, MeetingPlanningPage()),
                _buildDashboardCard('Evenements', Icons.event, Colors.grey[50]!, context, EventListPage()),
                _buildDashboardCard('Runions', Icons.track_changes, Colors.grey[50]!, context, TaskTrackingPage()),
              ],
            ),

            Container(
              height: 350.0, // Ajustez la hauteur selon vos besoins
              child: ScrollConfiguration(
                behavior: NoScrollBehavior(),
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(context, _items[index], animation);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }




  Widget _buildItem(BuildContext context, Map<String, dynamic> item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: Card(
          elevation: 4.0,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: ListTile(
            leading: Icon(item['icon'], size: 40.0, color: Colors.black),
            title: Text(item['title'], style:  Config.myTileTextSlyle),
            subtitle: Text(
              item['info'],
              style: Config.mySmallTextSlyele,
            ),
            onTap: () {
              _navigateToDetailPage(item['title'], context);
            },
          ),
        ),
      ),
    );
  }



  void _navigateToDetailPage(String title, BuildContext context) {
    switch (title) {
      case 'Événement':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailPage(
              event: Event(
                title: 'Événement Spécial',
                date: DateTime.now().add(const Duration(days: 5)),
                location: 'Salle de Conférence',
                description: 'Description de l\'événement.',
                time: TimeOfDay.now(),
              ),
            ),
          ),
        );
        break;
      case 'Rendez-vous':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppointmentDetailPage(
              appointment: Appointment(
                title: 'Réunion Importante',
                date: DateTime.now(),
                time: TimeOfDay.now(),
                location: 'Bureau Principal',
                participants: [
                  Person('Alice', 'assets/images/6.jpeg'),
                  Person('Bob', 'assets/images/9.jpeg'),
                ],
                description: 'Détails du rendez-vous.',
              ),
            ),
          ),
        );
        break;
      case 'Réunion':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingDetailPage(
              meeting: Tasks(
                title: 'Réunion d\'Équipe',
                date: DateTime.now(),
                time: TimeOfDay.now(),
                location: 'Salle de Réunion',
                description: 'Description de la réunion.',
              ),
            ),
          ),
        );
        break;
      case 'Tâches':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(
              task: Meeting(
                title: 'Tâche Critique',
                description: 'Description de la tâche.',
                startDate: DateTime.now(),
                dueDate: DateTime.now().add(const Duration(days: 2)),
                assignedUsers: [
                  User(id: '1', name: 'Alice', email: 'alice@example.com', avatarUrl: 'assets/images/6.jpeg', role: Role.users),
                  User(id: '2', name: 'Bob', email: 'bob@example.com', avatarUrl: 'assets/images/24.jpeg', role: Role.users),
                ],
                status: 'En cours',
              ),
            ),
          ),
        );
        break;
    }
  }







  Widget _buildDashboardCard(String title, IconData icon, Color color, BuildContext context, Widget destination) {
    return Card(
      elevation: 7.0,
      color: color,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40.0, color: Colors.black
              ),
              const SizedBox(height: 10.0),
              Text(title, style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,

              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// Custom ScrollBehavior to disable scrolling
class NoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, ScrollableDetails details) {
    return child; // Disable the visual effects of scrollable areas
  }

  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{}; // Disable scroll gestures
}
