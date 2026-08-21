import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const ShapcApp());
}

class DoctorProfile {
  static String name = "Dr. Poonam Sharma";
  static String regNo = "79492";
  static String clinicName = "SHAPC Health Center";
  static String address = "BHEL RECHS Wing, Main Clinic Complex";
  static String phone = "+91 98765 43210";
}

class FileExportHandler {
  static Future<String> getDownloadsPath() async {
    if (Platform.isWindows) {
      final userProfile = Platform.environment['USERPROFILE'];
      return '$userProfile\\Downloads';
    }
    return '/storage/emulated/0/Download';
  }

  static Future<File> exportData(String fileName, String data) async {
    final path = await getDownloadsPath();
    final file = File('$path\\$fileName');
    return await file.writeAsString(data);
  }
}

class ShapcApp extends StatelessWidget {
  const ShapcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHAPC Secure Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B5288),
          primary: const Color(0xFF2B5288),
          surface: const Color(0xFFF4F6F9),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _openDoctorSettings() {
    final nameCtrl = TextEditingController(text: DoctorProfile.name);
    final regCtrl = TextEditingController(text: DoctorProfile.regNo);
    final clinicCtrl = TextEditingController(text: DoctorProfile.clinicName);
    final addrCtrl = TextEditingController(text: DoctorProfile.address);
    final phoneCtrl = TextEditingController(text: DoctorProfile.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person_pin, color: Color(0xFF2B5288)),
            SizedBox(width: 10),
            Text('Doctor Profile Settings'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Doctor Name')),
              TextField(controller: regCtrl, decoration: const InputDecoration(labelText: 'Medical Council Reg No.')),
              TextField(controller: clinicCtrl, decoration: const InputDecoration(labelText: 'Clinic / Center Name')),
              TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: 'Clinic Address')),
              TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                DoctorProfile.name = nameCtrl.text;
                DoctorProfile.regNo = regCtrl.text;
                DoctorProfile.clinicName = clinicCtrl.text;
                DoctorProfile.address = addrCtrl.text;
                DoctorProfile.phone = phoneCtrl.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Doctor details updated successfully!')),
              );
            },
            child: const Text('Save Settings'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Column(
        children: [
          // Top Header Bar
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color(0xFF2B5288),
            child: Row(
              children: [
                Text(
                  '${DoctorProfile.clinicName} - ${DoctorProfile.name} (v1.5.0)',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  tooltip: 'Doctor Profile Settings',
                  onPressed: _openDoctorSettings,
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.cloud_done, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text('Realtime Sync Active', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Body with Navigation Rail
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                  labelType: NavigationRailLabelType.all,
                  leading: const SizedBox(height: 10),
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: Text('Dashboard')),
                    NavigationRailDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: Text('Patients')),
                    NavigationRailDestination(icon: Icon(Icons.calendar_month_outlined), selectedIcon: Icon(Icons.calendar_month), label: Text('Appointments')),
                    NavigationRailDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: Text('Bookkeeping')),
                    NavigationRailDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: Text('Reports')),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: [
                      _buildDashboardView(),
                      _buildPatientsView(),
                      _buildAppointmentsView(),
                      _buildBookkeepingView(),
                      _buildReportsView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Clinical Overview & Analytics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              _metricCard('Total Registered Patients', '142', Icons.people, Colors.blue),
              const SizedBox(width: 16),
              _metricCard("Today's Appointments", '8', Icons.calendar_today, Colors.orange),
              const SizedBox(width: 16),
              _metricCard('Monthly RECHS / Cash Billing', 'Rs. 3,500.00', Icons.payments, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search by Name, Phone, Staff No, or Patient ID...',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Add Patient'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B5288),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: Text('POONAM SHARMA (SHAPC-2026-001) [Blood: O+]', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Staff No: 1600818 | Consultant: ${DoctorProfile.name} (${DoctorProfile.regNo})'),
                  const Text('Age: 55 | DOB: 1971-03-12 | Phone: 9953134406 | Address: B-402, BHEL Enclave, Sector 62, Noida'),
                  const Text('Vitals: BP: 120/80 mmHg | Pulse: 72 bpm | SpO2: 98%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.print), onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Appointment Tracker', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_alarm),
                label: const Text('Quick Book'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B5288),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: const Text('POONAM SHARMA', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Doctor: ${DoctorProfile.name} | Time: 10:30 AM | Date: Aug 19, 2026\nReason: Session 7 / Follow-up Vitals Check'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.check_circle_outline, color: Colors.green), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
                  IconButton(icon: const Icon(Icons.cancel_outlined, color: Colors.red), onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookkeepingView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Bookkeeping & Billing Ledger', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.receipt_long),
                label: const Text('Generate RECHS Bill'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2B5288),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.receipt)),
              title: Text('RECHS Consultation / Physiotherapy (7 Days) - ${DoctorProfile.name}'),
              subtitle: Text('Staff No: 1600818 | Doctor ID: ${DoctorProfile.regNo} | BHEL RECHS\nIn Words: Three Thousand Five Hundred Only'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Rs. 3,500.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () async {
                      await FileExportHandler.exportData('rechs_bill_1600818.txt', 'RECHS Bill - Rs. 3500.00 - ${DoctorProfile.name}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Report saved to Downloads folder!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Automated PDF / CSV Reporting Engine', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await FileExportHandler.exportData('daily_financial_report.csv', 'Date,Type,Amount\n2026-08-21,RECHS,3500');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Daily Report exported to Downloads!')));
                },
                icon: const Icon(Icons.table_chart),
                label: const Text('Export Daily Financial Report (CSV)'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await FileExportHandler.exportData('monthly_financial_report.csv', 'Month,Total\nAug 2026,3500');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Monthly Report exported to Downloads!')));
                },
                icon: const Icon(Icons.bar_chart),
                label: const Text('Export Monthly Financial Report (CSV)'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await FileExportHandler.exportData('patient_summary.pdf', 'Patient Summary Report - ${DoctorProfile.clinicName}');
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Patient Summary saved to Downloads!')));
                },
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Generate Patient Summary (PDF)'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}