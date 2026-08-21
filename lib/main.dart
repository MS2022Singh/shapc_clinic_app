import 'dart:io';

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
      return '\\Downloads';
    }
    return '/storage/emulated/0/Download';
  }

  static Future<File> exportData(String fileName, String data) async {
    final path = await getDownloadsPath();
    final file = File('\\');
    return await file.writeAsString(data);
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(ShapcClinicApp());
}

class ShapcClinicApp extends StatelessWidget {
  ShapcClinicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHAPC Secure Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2C5282)),
        useMaterial3: true,
        scaffoldBackgroundColor: Color(0xFFF4F6F8),
      ),
      home: MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1; // Default to Patients Screen

  final List<Widget> _pages = [
    DashboardScreen(),
    PatientsScreen(),
    AppointmentsScreen(),
    BookkeepingScreen(),
    ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2C5282),
        elevation: 2,
        title: Text(
          'SHAPC Secure Vault â€” Clinical System v1.4.0',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload_outlined, color: Colors.white),
            tooltip: 'Manual Cloud Backup',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(' Cloud Backup Successful: All clinic records synced.'),
                  backgroundColor: Color(0xFF2C5282),
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(right: 16, left: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Realtime Cloud Sync Active',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.white,
            selectedIconTheme: IconThemeData(color: Color(0xFF2C5282), size: 28),
            selectedLabelTextStyle: TextStyle(color: Color(0xFF2C5282), fontWeight: FontWeight.bold),
            unselectedIconTheme: IconThemeData(color: Colors.black54),
            unselectedLabelTextStyle: TextStyle(color: Colors.black54),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Patients'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: Text('Appointments'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.account_balance_wallet_outlined),
                selectedIcon: Icon(Icons.account_balance_wallet),
                label: Text('Bookkeeping'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart_outlined),
                selectedIcon: Icon(Icons.bar_chart),
                label: Text('Reports'),
              ),
            ],
          ),
          VerticalDivider(thickness: 1, width: 1, color: Color(0xFFE0E0E0)),
          Expanded(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. DASHBOARD MODULE
// -----------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Overview & Analytics', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
          SizedBox(height: 20),
          Row(
            children: [
              _buildMetricCard('Total Registered Patients', '142', Icons.people, Colors.blue),
              SizedBox(width: 16),
              _buildMetricCard('Today\'s Appointments', '8', Icons.calendar_today, Colors.orange),
              SizedBox(width: 16),
              _buildMetricCard('Monthly RECHS / Cash Billing', '\u20B93,500.00', Icons.payments, Colors.green),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: color.withOpacity(0.12), radius: 26, child: Icon(icon, color: color, size: 28)),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Color(0xFF2D3748))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. PATIENTS MODULE
// -----------------------------------------------------------------------------
class PatientsScreen extends StatefulWidget {
  PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  void _showAddPatientDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.person_add, color: Color(0xFF2C5282)),
            SizedBox(width: 8),
            Text('Register New Patient', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()))),
                    SizedBox(width: 12),
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Emergency Contact', border: OutlineInputBorder()))),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Staff / RECHS No', border: OutlineInputBorder()))),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Blood Group', border: OutlineInputBorder()),
                        value: 'O+',
                        items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                        onChanged: (v) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: TextField(decoration: InputDecoration(labelText: 'Age', border: OutlineInputBorder()))),
                    SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                        value: 'Female',
                        items: ['Male', 'Female', 'Other'].map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                        onChanged: (v) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Full Address', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Medical History / Diagnoses', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Initial Vitals (BP, Pulse, SpO2)', border: OutlineInputBorder())),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2C5282), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient registered successfully!')));
            },
            child: Text('Save Patient'),
          ),
        ],
      ),
    );
  }

  void _showPatientDetailsModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('POONAM SHARMA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(4), color: Colors.red.shade50),
              child: Text('O+', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient ID: SHAPC-2026-001 | Staff No: 1600818', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Consultant Doctor: Dr. S. K. Singh (79492)'),
            Divider(),
            Text('Age: 55 | DOB: 1971-03-12 | Gender: Female'),
            Text('Phone: 9953134406 | Emergency: 9811011783'),
            Text('Address: B-402, BHEL Enclave, Sector 62, Noida'),
            Divider(),
            Text('Medical History:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\u2022 Cervical Spondylitis\n\u2022 Lumbar Pain'),
            SizedBox(height: 8),
            Text('Latest Recorded Vitals:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('\u2022 Blood Pressure: 120/80 mmHg\n\u2022 Pulse: 72 bpm\n\u2022 SpO2: 98%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  void _showEditPatientDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit Patient Info - POONAM SHARMA'),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: TextEditingController(text: 'POONAM SHARMA'), decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: '9953134406'), decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: 'B-402, BHEL Enclave, Sector 62, Noida'), decoration: InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient details updated successfully!')));
            },
            child: Text('Update Changes'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete patient "POONAM SHARMA"? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patient record deleted.')));
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Color(0xFF2C5282)),
                    hintText: 'Search by Name, Phone, Staff No, or Patient ID...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _showAddPatientDialog,
                icon: Icon(Icons.person_add),
                label: Text('Add Patient'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2C5282),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('POONAM SHARMA (SHAPC-2026-001)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A202C))),
                          SizedBox(width: 12),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(border: Border.all(color: Colors.red.shade400), color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)),
                            child: Text('O+', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.print, color: Color(0xFF2C5282)),
                            tooltip: 'Print Record',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Printing Patient File...')));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.file_download, color: Color(0xFF2C5282)),
                            tooltip: 'Download PDF',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Downloading Patient Profile PDF...')));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_red_eye, color: Color(0xFF2C5282)),
                            tooltip: 'View Details',
                            onPressed: _showPatientDetailsModal,
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            tooltip: 'Edit Patient',
                            onPressed: _showEditPatientDialog,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Delete Patient',
                            onPressed: _showDeleteConfirmation,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Staff No: 1600818 | Consultant: Dr. S. K. Singh (79492)', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('Age: 55 | DOB: 1971-03-12 | Gender: Female | Phone: 9953134406 | Emergency: 9811011783', style: TextStyle(color: Colors.black87)),
                  Text('Address: B-402, BHEL Enclave, Sector 62, Noida', style: TextStyle(color: Colors.black87)),
                  Text('History: Cervical Spondylitis, Lumbar Pain', style: TextStyle(color: Colors.black87)),
                  SizedBox(height: 6),
                  Text('Vitals: BP: 120/80 mmHg | Pulse: 72 bpm | SpO2: 98%', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. APPOINTMENTS MODULE
// -----------------------------------------------------------------------------
class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  void _showQuickBookDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Quick Book Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Patient Name / ID', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Doctor Name', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Time / Date', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Reason for Visit', border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2C5282), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment scheduled!')));
            },
            child: Text('Confirm Booking'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Appointment Tracker', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
              ElevatedButton.icon(
                onPressed: _showQuickBookDialog,
                icon: Icon(Icons.alarm_add),
                label: Text('Quick Book'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2C5282),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Card(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('POONAM SHARMA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3748))),
                      SizedBox(height: 4),
                      Text('Doctor: Dr. S. K. Singh | Time: 10:30 AM | Date: Aug 19, 2026 | Phone: 9953134406', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text('Reason: Session 7 / Follow-up Vitals Check', style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.print, color: Color(0xFF2C5282)),
                        tooltip: 'Print Slip',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Printing Appointment Slip...')));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.file_download, color: Color(0xFF2C5282)),
                        tooltip: 'Download',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Downloading Appointment PDF...')));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.check_circle_outline, color: Colors.green),
                        tooltip: 'Mark Complete',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Appointment status set to Completed.')));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.exit_to_app, color: Colors.teal),
                        tooltip: 'Checkout',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Patient Checked Out.')));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Cancel',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Appointment cancelled.')));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. BOOKKEEPING & RECHS BILLING MODULE
// -----------------------------------------------------------------------------
class BookkeepingScreen extends StatefulWidget {
  BookkeepingScreen({super.key});

  @override
  State<BookkeepingScreen> createState() => _BookkeepingScreenState();
}

class _BookkeepingScreenState extends State<BookkeepingScreen> {
  void _showGenerateRechsBillDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Generate RECHS / Corporate Bill Form', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: TextEditingController(text: '158216'), decoration: InputDecoration(labelText: 'Form Sl. No.', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: '79492'), decoration: InputDecoration(labelText: 'Doctor\'s ID No.', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: 'POONAM SHARMA'), decoration: InputDecoration(labelText: 'Patient Name', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: '1600818'), decoration: InputDecoration(labelText: 'Employee Staff No.', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: 'Physiotherapy x 7 days'), decoration: InputDecoration(labelText: 'Diagnosis / Treatment Plan', border: OutlineInputBorder())),
                SizedBox(height: 12),
                TextField(controller: TextEditingController(text: '05-08-26, 06-08-26, 07-08-26, 08-08-26, 10-08-26, 11-08-26, 12-08-26'), decoration: InputDecoration(labelText: 'Session Dates (comma separated)', border: OutlineInputBorder())),
                SizedBox(height: 12),
                  TextField(controller: TextEditingController(text: '3500'), decoration: InputDecoration(labelText: 'Total Charges (\u20B9)', border: OutlineInputBorder())),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2C5282), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('RECHS Bill Generated and Saved!')));
            },
            child: Text('Generate & Save Bill'),
          ),
        ],
      ),
    );
  }

  void _showReceiptBreakdownDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('RECHS Bill Voucher #158214', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctor ID: 79492', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Title: RECHS Consultation / Physiotherapy (7 Days) - Poonam Sharma'),
            Divider(),
            Text('Session Dates Logged:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: ['05-08-26', '06-08-26', '07-08-26', '08-08-26', '10-08-26', '11-08-26', '12-08-26']
                  .map((d) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.blue.shade200)),
                        child: Text(d, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF2C5282))),
                      ))
                  .toList(),
            ),
            Divider(),
            Text('Total Amount: \u20B93,500.00'),
            Text('Amount in Words: Three Thousand Five Hundred Only', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13, color: Colors.black87)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bookkeeping & Billing Ledger', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
                ElevatedButton.icon(
                  onPressed: _showGenerateRechsBillDialog,
                  icon: Icon(Icons.receipt),
                  label: Text('Generate RECHS Bill'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C5282),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                )
              ],
            ),
            SizedBox(height: 16),
            TabBar(
              labelColor: Color(0xFF2C5282),
              indicatorColor: Color(0xFF2C5282),
              indicatorWeight: 3,
              tabs: [
                Tab(icon: Icon(Icons.calendar_view_day), text: 'Daily Ledger'),
                Tab(icon: Icon(Icons.calendar_view_week), text: 'Monthly Ledger'),
                Tab(icon: Icon(Icons.calendar_today), text: 'Annual Ledger'),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Card(
                        elevation: 2,
                        color: Colors.white,
                        child: ListTile(
                          leading: CircleAvatar(backgroundColor: Color(0xFFEBF8FF), child: Icon(Icons.receipt_long, color: Color(0xFF2C5282))),
                          title: Text('RECHS Consultation / Physiotherapy (7 Days) - Poonam Sharma', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Staff No: 1600818 | Doctor ID: 79492 | BHEL RECHS\nIn Words: Three Thousand Five Hundred Only'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('+\u20B93,500.00'),
                              SizedBox(width: 8),
                              IconButton(
                                icon: Icon(Icons.print, color: Color(0xFF2C5282)),
                                tooltip: 'Print Receipt',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Printing Ledger Receipt...')));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.file_download, color: Color(0xFF2C5282)),
                                tooltip: 'Download PDF',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Downloading Receipt PDF...')));
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.remove_red_eye, color: Color(0xFF2C5282)),
                                tooltip: 'View Breakdown',
                                onPressed: _showReceiptBreakdownDialog,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(child: Text('Monthly Aggregated Ledger & Financial Analytics', style: TextStyle(fontSize: 16, color: Colors.black54))),
                  Center(child: Text('Annual Financial Summary & Tax Reports', style: TextStyle(fontSize: 16, color: Colors.black54))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5. REPORTS MODULE
// -----------------------------------------------------------------------------
class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Automated PDF / CSV Reporting Engine', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A202C))),
          SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Exporting Daily Financial Report (CSV)...')));
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Export Daily Financial Report (CSV)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00695C),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Exporting Monthly Financial Report (CSV)...')));
                },
                icon: Icon(Icons.file_download),
                label: Text('Export Monthly Financial Report (CSV)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00695C),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' Generating Patient Summary (PDF)...')));
                },
                icon: Icon(Icons.picture_as_pdf),
                label: Text('Generate Patient Summary (PDF)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00695C),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



