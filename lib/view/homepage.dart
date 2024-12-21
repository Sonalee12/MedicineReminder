import 'package:flutter/material.dart';
import 'package:medicine_reminder/view/addmedicine.dart';
import 'package:medicine_reminder/view/profile.dart';// Import the Add Medicine page

class HealthDashboard extends StatefulWidget {
  @override
  _HealthDashboardState createState() => _HealthDashboardState();
}

class _HealthDashboardState extends State<HealthDashboard> {
  int _selectedIndex = 0;

  // List of pages to navigate between
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(), // Home page content
      AddMedicinePage(), // Add Medicine page
      ProfilePage(), // Profile page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

              // Urgent Care Button
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning, color: Colors.orange, size: 30),
                        const SizedBox(width: 12),
                        const Text(
                          'Urgent Care',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward, color: Colors.orange),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Services Section
              const Text(
                'Our Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  ServiceItem(icon: Icons.medical_services, label: 'Medicines'),
                  ServiceItem(icon: Icons.local_hospital, label: 'Ambulance'),
                ],
              ),
              const SizedBox(height: 20),

              // Appointment Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Appointment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AppointmentCard(),
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

class CustomerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'Customer Profile Page',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
