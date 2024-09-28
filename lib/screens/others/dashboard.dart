
import 'package:easy_mtp/screens/others/profile.dart';
import 'package:easy_mtp/screens/others/progression.dart';
import 'package:easy_mtp/screens/others/test.dart';
import 'package:flutter/material.dart';

import '../../config.dart';
import '../../models/evenement.dart';
import '../../models/rendez_vous.dart';
import '../../models/task.dart';
import '../../models/reunion.dart';
import '../../models/user.dart';
import 'home.dart';
import '../notifications/notifications.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  final List<Meeting> tasks = [];
  final List<Tasks> meetings = [];
  final List<Appointment> appointments = [];
  final List<Event> events = [];

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      HomePage(),
      StatisticsPage(tasks: tasks, meetings: meetings, appointments: appointments, events: events,),
      NotificationsPage(),
      ProfilePage(),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.home_filled,
              color: _currentIndex == 0 ? Colors.deepOrange : Colors.blueGrey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.pie_chart,
              color: _currentIndex == 1 ? Colors.deepOrange : Colors.blueGrey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.notifications,
              color: _currentIndex == 2 ? Colors.deepOrange : Colors.blueGrey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? Colors.deepOrange : Colors.blueGrey,
            ),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.cyan,
        iconSize: 30,
        elevation: 5,
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Color color, String route) {
    return Card(
      elevation: 4.0,
      color: color,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
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
