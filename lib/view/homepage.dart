import 'package:flutter/material.dart';
import 'package:medicine_reminder/model/user_model.dart';
import 'package:medicine_reminder/view/medicineschedule.dart'; // Import the schedule page
import 'package:medicine_reminder/view/addmedicine.dart';

class HealthDashboard extends StatefulWidget {
  @override
  _HealthDashboardState createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  int _selectedIndex = 0;
  List<Medicine> medicines = [];

  // List of pages to navigate between
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(medicines: medicines), // Home page content
      AddMedicinePage(), // Add Medicine page
      SchedulePage(), // Profile page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _addMedicine() async {
    final newMedicine = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMedicinePage()),
    );
    if (newMedicine != null) {
      setState(() {
        medicines.add(newMedicine);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex], // Display the page based on selected index
      appBar: AppBar(
        title: Text(
          ['Health Dashboard', 'Add Medicine', 'Customer Profile'][_selectedIndex],
        ),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFF5F5F5),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add Medicine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Customer Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed, // Ensure items don't overflow
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Medicine> medicines;

  HomePage({required this.medicines});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Replace with user's profile image
                    radius: 25,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'User',
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(Icons.notifications_none, size: 30, color: Colors.grey[600]),
                ],
              ),
              const SizedBox(height: 20),

              // Your Medicines Section
              const SizedBox(height: 20),
              const Text(
                'Your Medicines',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              medicines.isEmpty
                  ? const Text('No medicines added yet.')
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  return ListTile(
                    title: Text(medicine.name),
                    subtitle: Text('${medicine.type}, ${medicine.amount}'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Navigate to Schedule Page with medicine details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchedulePage(
                            startDate: medicine.startDate,
                            finishDate: medicine.finishDate,
                            selectedDays: medicine.days,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, size: 30, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

class AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/150'), // Replace with doctor's image
            radius: 25,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dr. Prem Tiwari',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Orthopedic',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    'Wed Nov 20 - 8:00 AM',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
