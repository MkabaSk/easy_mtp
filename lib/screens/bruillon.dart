/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'profile.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _items = [
    {'title': 'Événement', 'icon': Icons.event, 'color': Colors.red, 'info': 'Informations sur Événement'},
    {'title': 'Rendez-vous', 'icon': Icons.calendar_today, 'color': Colors.blue, 'info': 'Informations sur Rendez-vous'},
    {'title': 'Réunion', 'icon': Icons.meeting_room, 'color': Colors.green, 'info': 'Informations sur Réunion'},
    {'title': 'Tâches', 'icon': Icons.track_changes, 'color': Colors.purple, 'info': 'Informations sur Tâches'},
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late Timer _timer;

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
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      if (_items.isNotEmpty) {
        final item = _items.removeAt(0);
        _items.add(item);
        _listKey.currentState?.removeItem(
          0,
              (context, animation) => _buildItem(context, item, animation),
        );
        Future.delayed(Duration(milliseconds: 300), () {
          _listKey.currentState?.insertItem(_items.length - 1);
        });
      }
    });
  }

  Widget _buildItem(BuildContext context, Map<String, dynamic> item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.2),
          end: Offset.zero,
        ).animate(animation),
        child: Card(
          elevation: 4.0,
          color: item['color'],
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          child: ListTile(
            leading: Icon(item['icon'], size: 40.0, color: Colors.white),
            title: Text(item['title'], style: TextStyle(color: Colors.white, fontSize: 18.0)),
            subtitle: Text(
              item['info'],
              style: TextStyle(color: Colors.white70, fontSize: 14.0),
            ),
            onTap: () {


            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tableau de Bord'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              children: [
                _buildDashboardCard('Rendez-vous', Icons.calendar_today, Colors.blue, context, AppointmentListPage()),
                _buildDashboardCard('Réunions', Icons.meeting_room, Colors.green, context, MeetingPlanningPage()),
                _buildDashboardCard('Evenements', Icons.event, Colors.red, context, CreateEventPage()),
                _buildDashboardCard('Tâches', Icons.track_changes, Colors.purple, context, ProfileSettingsPage()),
              ],
            ),
          ),
          Container(
            height: 350.0, // Adjust the height as needed
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(context, _items[index], animation);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(String title, IconData icon, Color color, BuildContext context, Widget destination) {
    return Card(
      elevation: 4.0,
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
              Icon(icon, size: 40.0, color: Colors.white),
              SizedBox(height: 10.0),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}



POUR LA TACHE

void _showTaskDetails(BuildContext context, String title, double progress, Color color) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description de la tâche ici...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Fermer'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action pour marquer comme terminé
                    },
                    child: Text('Marquer comme terminé'),
                    style: ElevatedButton.styleFrom(backgroundColor: color),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
*/
