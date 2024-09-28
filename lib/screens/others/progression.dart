import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/evenement.dart';
import '../../models/rendez_vous.dart';
import '../../models/reunion.dart';
import '../../models/task.dart';



class StatisticsPage extends StatefulWidget {
  final List<Meeting> tasks;
  final List<Tasks> meetings;
  final List<Appointment> appointments;
  final List<Event> events;



  StatisticsPage({
    required this.tasks,
    required this.meetings,
    required this.appointments,
    required this.events,
  });



  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}



class _StatisticsPageState extends State<StatisticsPage> with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  int touchedIndex = -1;



  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }



  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {


    // Données locales pour les tests
    final List<String> localTaskStatuses = ['Compléter', 'En cours', 'En attente'];
    final List<String> localMeetingStatuses = ['Compléter', 'En cours', 'En attente'];
    final List<String> localAppointmentStatuses = ['Compléter', 'En cours'];
    final List<String> localEventStatuses = ['En attente', 'Compléter'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Statistiques',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: const SizedBox(),
      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildStatisticCard(
                context,
                'Tâches',
                _getStatusCounts(localTaskStatuses),
              ),
              _buildStatisticCard(
                context,
                'Réunions',
                _getStatusCounts(localMeetingStatuses),
              ),
              _buildStatisticCard(
                context,
                'Rendez-vous',
                _getStatusCounts(localAppointmentStatuses),
              ),
              _buildStatisticCard(
                context,
                'Événements',
                _getStatusCounts(localEventStatuses),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildStatisticCard(
      BuildContext context,
      String title,
      Map<String, int> statusCounts,
      ) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: _buildPieChartSections(statusCounts),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                        _animationController?.forward(from: 0.0);
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ...statusCounts.entries.map((entry) => _buildStatusRow(entry.key, entry.value)),
          ],
        ),
      ),
    );
  }




  List<PieChartSectionData> _buildPieChartSections(Map<String, int> statusCounts) {
    final totalCount = statusCounts.values.reduce((a, b) => a + b);
    int index = 0;

    return statusCounts.entries.map((entry) {
      final double percentage = (entry.value / totalCount) * 100;
      final isTouched = index == touchedIndex;
      final double radius = isTouched ? 60 : 50;
      final double fontSize = isTouched ? 25.0 : 14.0;
      final shadows = [Shadow(color: Colors.black.withOpacity(0.3), blurRadius: 4)];

      index++; // Incremente l'index après chaque itération

      return PieChartSectionData(
        color: _getColorForStatus(entry.key),
        value: percentage,
        title: '${entry.value} (${percentage.toStringAsFixed(1)}%)',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }




  Widget _buildStatusRow(String status, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          status,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }




  Map<String, int> _getStatusCounts(List<String> statuses) {
    final Map<String, int> statusCounts = {};

    for (var status in statuses) {
      if (statusCounts.containsKey(status)) {
        statusCounts[status] = statusCounts[status]! + 1;
      } else {
        statusCounts[status] = 1;
      }
    }

    return statusCounts;
  }





  Color _getColorForStatus(String status) {
    switch (status) {
      case 'Compléter':
        return Colors.green;
      case 'En cours':
        return Colors.orange;
      case 'En attente':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }





}
