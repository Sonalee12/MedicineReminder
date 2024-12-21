import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? finishDate;
  final List<bool> selectedDays;

  // Constructor
  SchedulePage({this.startDate, this.finishDate, required this.selectedDays});

  // Define the days of the week directly here
  final List<String> daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<int> dates = [16, 17, 18, 19, 20, 21, 22];
  final String today = 'Today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Schedule'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Days of the Week Section
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  daysOfWeek.length,
                      (index) => Column(
                    children: [
                      Text(
                        daysOfWeek[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: index == 0 ? Colors.blue : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: index == 0 ? Colors.blue : Colors.grey[300],
                        child: Text(
                          '${dates[index]}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: index == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Today Label
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                today,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),

            // Displaying Selected Days
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Days: ${List.generate(selectedDays.length, (index) => selectedDays[index] ? daysOfWeek[index] : null).where((day) => day != null).join(', ')}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // Medicine List (Schedule Cards)
            Expanded(
              child: ListView.builder(
                itemCount: 7, // Adjust this if you want to display more data
                itemBuilder: (context, index) {
                  return ScheduleCard(
                    startDate: startDate,
                    finishDate: finishDate,
                    selectedDays: selectedDays,
                    daysOfWeek: daysOfWeek, // Pass daysOfWeek to the ScheduleCard
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? finishDate;
  final List<bool> selectedDays;
  final List<String> daysOfWeek; // Accept daysOfWeek as a parameter

  ScheduleCard({this.startDate, this.finishDate, required this.selectedDays, required this.daysOfWeek});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.schedule, size: 40, color: Colors.blue),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Date: ${startDate != null ? startDate!.toLocal().toString().split(' ')[0] : 'Not set'}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Finish Date: ${finishDate != null ? finishDate!.toLocal().toString().split(' ')[0] : 'Not set'}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Days: ${List.generate(selectedDays.length, (index) => selectedDays[index] ? daysOfWeek[index] : null).where((day) => day != null).join(', ')}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}