import 'package:eventbookingapp/admin/uploada_event.dart';
import 'package:flutter/material.dart';

import 'Tickerts_event.dart';
import 'admin_logi.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AdminLoginPage()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),

        ],

        automaticallyImplyLeading: false,
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // 🎟 Tickets
            _buildDashboardCard(
              context,
              icon: Icons.confirmation_number,
              title: "Tickets",
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EventTickets()),
                );
              },
            ),
            // 🎉 Upload Event
            _buildDashboardCard(
              context,
              icon: Icons.event,
              title: "Upload Event",
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UploadEvent()),
                );
              },
            ),
            // ⚙️ Settings/Gismo
            _buildDashboardCard(
              context,
              icon: Icons.settings,
              title: "Gismo / Settings",
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GismoPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
      required String title,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 50),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =================== Dummy Pages ===================

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tickets")),
      body: const Center(
        child: Text("All booked tickets will appear here."),
      ),
    );
  }
}

class UploadEventPage extends StatelessWidget {
  const UploadEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Event")),
      body: const Center(
        child: Text("Event upload form will appear here."),
      ),
    );
  }
}

class GismoPage extends StatelessWidget {
  const GismoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gismo / Settings")),
      body: const Center(
        child: Text("Admin settings and tools."),
      ),
    );
  }
}
