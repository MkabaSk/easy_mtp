import 'package:easy_mtp/config.dart';
import 'package:flutter/material.dart';

import 'notifications.dart';

class NotificationDetailPage extends StatelessWidget {
  final NotificationItem notification;

  NotificationDetailPage({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,
      appBar: AppBar(
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
        backgroundColor: Config.myAppBarBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Date: ${notification.date}',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description de la notification ici...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}