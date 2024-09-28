import 'package:flutter/material.dart';
import 'package:easy_mtp/config.dart';

import 'details.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Liste des notifications
  List<NotificationItem> notifications = [
    NotificationItem(title: 'Nouvelle tâche créée', date: '01/09/2024', color: Colors.green),
    NotificationItem(title: 'Tâche assignée', date: '02/09/2024', color: Colors.red),
    NotificationItem(title: 'Réunion planifiée', date: '03/09/2024', color: Colors.blue),
    NotificationItem(title: 'Rendez-vous modifié', date: '04/09/2024', color: Colors.orange),
    NotificationItem(title: 'Événement créé', date: '05/09/2024', color: Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,

      appBar: AppBar(
        backgroundColor: Config.myAppBarBackgroundColor,
        elevation: 0,
        title: Text(
          "Notifications",
          style: Config.myTileTextSlyle,
        ),
        centerTitle: true,
       leading: const SizedBox(),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Column(
            children: [
              Dismissible(
                key: ValueKey(notification.title),
                background: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check, color: Colors.white),
                      SizedBox(width: 20),
                      Text('Marquer comme lue', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Supprimer', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.delete, color: Colors.white),
                    ],
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    // Marquer comme lu
                    setState(() {
                      notification.isRead = true;
                    });
                    return Future.value(false); // Ne pas supprimer l'élément
                  } else if (direction == DismissDirection.endToStart) {
                    // Supprimer
                    setState(() {
                      notifications.removeAt(index);
                    });
                    return Future.value(true); // Supprimer l'élément
                  }
                  return Future.value(false); // Retourner false si aucune action n'est prise
                },
                child: ListTile(
                  leading: Icon(Icons.notification_important, color: notification.color),
                  title: Text(notification.title),
                  subtitle: Text(notification.date),
                  trailing: notification.isRead
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    // Naviguer vers la page de détails de la notification
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationDetailPage(notification: notification),
                      ),
                    );
                  },
                ),
              ),
              // Ajouter un Divider entre les notifications
              Divider(
                color: Color(0xffff7f50).withOpacity(0.5),
                thickness: 1,
              ),
            ],
          );
        },
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String date;
  final Color color;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.date,
    required this.color,
    this.isRead = false,
  });
}


