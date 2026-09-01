import 'package:flutter/material.dart';

void main() {
  runApp(const ShapcClinicApp());
}

class ShapcClinicApp extends StatelessWidget {
  const ShapcClinicApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHAPC Clinic Management System',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
      ),
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends StatefulWidget {
  const MainDashboard({Key? key}) : super(key: key);

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardHomeView(),
    const PatientManagementView(),
    const BookkeepingView(),
    const ReportsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('SHAPC Clinic', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                ),
                const Divider(height: 1),
                _buildNavItem(0, 'Dashboard'),
                _buildNavItem(1, 'Patient Management'),
                _buildNavItem(2, 'Bookkeeping & Billing'),
                _buildNavItem(3, 'Reports'),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        color: isSelected ? Colors.teal.withOpacity(0.1) : Colors.transparent,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.teal : Colors.black87,
          ),
        ),
      ),
    );
  }
}

class DashboardHomeView extends StatelessWidget {
  const DashboardHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Dashboard Overview', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildMetricCard('Total Patients', '1,245', Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _buildMetricCard('Today Revenue', '₹14,500', Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildMetricCard('Pending Reports', '8', Colors.orange)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class PatientManagementView extends StatefulWidget {
  const PatientManagementView({Key? key}) : super(key: key);

  @override
  _PatientManagementViewState createState() => _PatientManagementViewState();
}

class _PatientManagementViewState extends State<PatientManagementView> {
  final List<Map<String, String>> _patients = [
    {'name': 'Rahul Sharma', 'age': '32', 'disease': 'Hypertension'},
    {'name': 'Priya Verma', 'age': '28', 'disease': 'Type 2 Diabetes'},
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();

  void _addPatient() {
    if (_nameController.text.isNotEmpty && _ageController.text.isNotEmpty && _diseaseController.text.isNotEmpty) {
      setState(() {
        _patients.add({
          'name': _nameController.text,
          'age': _ageController.text,
          'disease': _diseaseController.text,
        });
        _nameController.clear();
        _ageController.clear();
        _diseaseController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Patient Management', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Patient Name', border: OutlineInputBorder(), filled: true, fillColor: Colors.white))),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: _ageController, decoration: const InputDecoration(labelText: 'Age', border: OutlineInputBorder(), filled: true, fillColor: Colors.white))),
              const SizedBox(width: 10),
              Expanded(child: TextField(controller: _diseaseController, decoration: const InputDecoration(labelText: 'Diagnosis', border: OutlineInputBorder(), filled: true, fillColor: Colors.white))),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: _addPatient, style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22), backgroundColor: Colors.teal, foregroundColor: Colors.white), child: const Text('Add Patient'))
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {
                final p = _patients[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.teal.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                      child: const Text('PAT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
                    ),
                    title: Text(p['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Age:  | Diagnosis: '),
                    trailing: IconButton(
                      icon: const Text('DEL', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      onPressed: () => setState(() => _patients.removeAt(index)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookkeepingView extends StatefulWidget {
  const BookkeepingView({Key? key}) : super(key: key);

  @override
  _BookkeepingViewState createState() => _BookkeepingViewState();
}

class _BookkeepingViewState extends State<BookkeepingView> {
  final List<Map<String, String>> _transactions = [
    {'id': 'TXN001', 'patient': 'Rahul Sharma', 'amount': '₹1,500', 'type': 'Consultation'},
    {'id': 'TXN002', 'patient': 'Priya Verma', 'amount': '₹2,000', 'type': 'Lab Test'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bookkeeping & Billing Ledger', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: ListView.builder(
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  var tx = _transactions[index];
                  return ListTile(
                    title: Text(' - Patient: ', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Service Type: '),
                    trailing: Text(tx['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 16)),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReportsView extends StatelessWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Automated PDF / CSV Reporting', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            child: const Text('Export Monthly Financial Report (CSV)'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
            child: const Text('Generate Patient Summary (PDF)'),
          ),
        ],
      ),
    );
  }
}
