import 'package:easy_mtp/config.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.myBackgroundColor,

      appBar: AppBar(
        backgroundColor: Config.myAppBarBackgroundColor,
        elevation: 0,
        title: Text(
          "Profile",
          style: Config.myTileTextSlyle,
        ),
        centerTitle: true,
       /* actions: [
          const Icon(Icons.more_vert),
        ],*/
        leading: const SizedBox(),
      ),

      body: SingleChildScrollView(

        child: Column(

          children: [

           Padding(
             padding: const EdgeInsets.only( left: 30, right: 30, bottom: 5, top: 10),
             child: Material(
               borderRadius:  BorderRadius.circular(100),
                color: Config.myButtonColors,
               elevation: 8.0,

               /// Photo de profile
               child: Container(
                 padding: const EdgeInsets.only(top: 30.0, left: 30, right: 30, bottom: 30),
                 height: 150,
                 width: 150,
                 child:  Column(
                   children: [
                     Center(
                       child: Container(
                         padding: const EdgeInsets.all(2), // Espace entre l'image et la bordure
                         decoration: BoxDecoration(
                           color: Colors.white, // Couleur du cercle extérieur (optionnel, pour le contraste)
                           shape: BoxShape.circle,
                           border: Border.all(
                             color:  Config.myAppBarBackgroundColor, // Couleur de la bordure
                             width: 2.0, // Épaisseur de la bordure
                           ),
                         ),
                         child: const CircleAvatar(
                           radius: 40,
                           backgroundImage: AssetImage(
                             'assets/images/9.jpeg',
                           ),
                         ),
                       )
                       ,
                     ),

                   ],
                 ),
               ),
             ),
           ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 1),
              child: Material(
                elevation: 6.0,
                color: Config.myButtonColors?.withOpacity(0.9),
                borderRadius:  BorderRadius.vertical(
                    top: Radius.circular(80),
                    bottom:  Radius.circular(80)
                ),
                child: Container(
                  height: 600,
                  padding: const EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      buildInfoItem(Icons.person, "Filiation", "Mohamed Kaba"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.badge, "Role", "Développeur mobile"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.home, "Address", "Sanoyah/Coyah/Kindia"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.email, "E-mail", "mkaba8248@gmail.com"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      // Ajouter ici les informations supplémentaires
                      buildInfoItem(Icons.task, "Tâches créées", "25"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.event, "Événements créés", "10"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.meeting_room, "Réunions créées", "5"),
                      Divider(color: Config.myBackgroundColor, thickness: 1,),

                      buildInfoItem(Icons.schedule, "Rendez-vous créés", "8"),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildInfoItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Config.myBackgroundColor),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
