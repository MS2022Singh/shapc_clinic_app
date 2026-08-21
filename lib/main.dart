import 'package:flutter/material.dart';

void main() {
  runApp(const ShapcApp());
}

class Patient {
  String id;
  String name;
  String bloodGroup;
  String staffNo;
  String consultant;
  int age;
  String dob;
  String gender;
  String phone;
  String emergencyPhone;
  String address;
  String history;
  String vitals;

  Patient({
    required this.id,
    required this.name,
    required this.bloodGroup,
    required this.staffNo,
    required this.consultant,
    required this.age,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.emergencyPhone,
    required this.address,
    required this.history,
    required this.vitals,
  });
}

class AppointmentItem {
  String id;
  String patientName;
  String doctor;
  String time;
  String date;
  String phone;
  String reason;
  String status;
  bool doctorReminderSet;

  AppointmentItem({
    required this.id,
    required this.patientName,
    required this.doctor,
    required this.time,
    required this.date,
    required this.phone,
    required this.reason,
    required this.status,
    this.doctorReminderSet = false,
  });
}

class LedgerItem {
  String id;
  String description;
  String staffNo;
  String doctorId;
  String mode;
  String amount;
  String date;

  LedgerItem({
    required this.id,
    required this.description,
    required this.staffNo,
    required this.doctorId,
    required this.mode,
    required this.amount,
    required this.date,
  });
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
          seedColor: const Color(0xFF6B21A8),
          primary: const Color(0xFF6B21A8),
          surface: const Color(0xFFFAF5FF),
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
  int _ledgerTab = 0;
  String _searchQuery = "";

  String _doctorName = "Dr. S. K. Singh";
  String _doctorId = "79492";
  String _licenseNo = "REG-SHAPC-2026-9912";
  String _specialization = "Senior Consultant Physiotherapist";
  String _contactNo = "+91 9811011783";
  String _email = "dr.sksingh@shapc.org";
  String _clinicTitle = "SHAPC Health Center & Clinical System";

  final List<Patient> _patients = [
    Patient(
      id: "SHAPC-2026-001",
      name: "POONAM SHARMA",
      bloodGroup: "O+",
      staffNo: "1600818",
      consultant: "Dr. S. K. Singh (79492)",
      age: 55,
      dob: "1971-03-12",
      gender: "Female",
      phone: "9953134406",
      emergencyPhone: "9811011783",
      address: "B-402, BHEL Enclave, Sector 62, Noida",
      history: "Cervical Spondylitis, Lumbar Pain",
      vitals: "BP: 120/80 mmHg | Pulse: 72 bpm | SpO2: 98%",
    ),
  ];

  final List<AppointmentItem> _appointments = [
    AppointmentItem(
      id: "A-01",
      patientName: "POONAM SHARMA",
      doctor: "Dr. S. K. Singh",
      time: "10:30 AM",
      date: "Aug 21, 2026",
      phone: "9953134406",
      reason: "Session 7 / Follow-up Vitals Check",
      status: "Scheduled",
      doctorReminderSet: true,
    ),
  ];

  final List<LedgerItem> _dailyLedger = [
    LedgerItem(
      id: "L-1001",
      description: "RECHS Consultation / Physiotherapy (7 Days)",
      staffNo: "1600818",
      doctorId: "79492",
      mode: "RECHS",
      amount: "3500.00",
      date: "Aug 21, 2026",
    ),
  ];

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  void _showProfileModal() {
    final docNameCtrl = TextEditingController(text: _doctorName);
    final docIdCtrl = TextEditingController(text: _doctorId);
    final licenseCtrl = TextEditingController(text: _licenseNo);
    final specCtrl = TextEditingController(text: _specialization);
    final phoneCtrl = TextEditingController(text: _contactNo);
    final emailCtrl = TextEditingController(text: _email);
    final clinicCtrl = TextEditingController(text: _clinicTitle);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 520,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle, size: 36, color: Color(0xFF6B21A8)),
                    const SizedBox(width: 12),
                    const Text('Doctor & Clinic Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12),
                TextField(controller: docNameCtrl, decoration: const InputDecoration(labelText: 'Doctor Name')),
                TextField(controller: docIdCtrl, decoration: const InputDecoration(labelText: 'Doctor ID / Staff Code')),
                TextField(controller: licenseCtrl, decoration: const InputDecoration(labelText: 'Registration / License No')),
                TextField(controller: specCtrl, decoration: const InputDecoration(labelText: 'Specialization')),
                TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Doctor Contact No')),
                TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Doctor Email Address')),
                TextField(controller: clinicCtrl, decoration: const InputDecoration(labelText: 'Clinic Title')),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _doctorName = docNameCtrl.text;
                        _doctorId = docIdCtrl.text;
                        _licenseNo = licenseCtrl.text;
                        _specialization = specCtrl.text;
                        _contactNo = phoneCtrl.text;
                        _email = emailCtrl.text;
                        _clinicTitle = clinicCtrl.text;
                      });
                      Navigator.pop(context);
                      _showMessage('Profile Attributes Updated Successfully');
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8), foregroundColor: Colors.white),
                    child: const Text('Save Profile Details'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddPatientModal() {
    final nameCtrl = TextEditingController();
    final staffCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emergencyCtrl = TextEditingController();
    final bloodCtrl = TextEditingController(text: "O+");
    final ageCtrl = TextEditingController();
    final dobCtrl = TextEditingController(text: "1980-01-01");
    final genderCtrl = TextEditingController(text: "Male");
    final addressCtrl = TextEditingController();
    final historyCtrl = TextEditingController();
    final vitalsCtrl = TextEditingController(text: "BP: 120/80 mmHg | Pulse: 72 bpm | SpO2: 98%");

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 520,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add New Patient Entry', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
                const SizedBox(height: 16),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Patient Full Name')),
                Row(
                  children: [
                    Expanded(child: TextField(controller: staffCtrl, decoration: const InputDecoration(labelText: 'Staff No'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: bloodCtrl, decoration: const InputDecoration(labelText: 'Blood Group'))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: TextField(controller: ageCtrl, decoration: const InputDecoration(labelText: 'Age'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: genderCtrl, decoration: const InputDecoration(labelText: 'Gender'))),
                  ],
                ),
                TextField(controller: dobCtrl, decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)')),
                Row(
                  children: [
                    Expanded(child: TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Primary Phone'))),
                    const SizedBox(width: 12),
                    Expanded(child: TextField(controller: emergencyCtrl, decoration: const InputDecoration(labelText: 'Emergency Phone'))),
                  ],
                ),
                TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Residential Address')),
                TextField(controller: historyCtrl, decoration: const InputDecoration(labelText: 'Medical History / Condition')),
                TextField(controller: vitalsCtrl, decoration: const InputDecoration(labelText: 'Current Vitals (BP / SpO2 / Pulse)')),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (nameCtrl.text.isNotEmpty) {
                          setState(() {
                            _patients.add(Patient(
                              id: "SHAPC-2026-00${_patients.length + 1}",
                              name: nameCtrl.text.toUpperCase(),
                              bloodGroup: bloodCtrl.text,
                              staffNo: staffCtrl.text.isEmpty ? "N/A" : staffCtrl.text,
                              consultant: "$_doctorName ($_doctorId)",
                              age: int.tryParse(ageCtrl.text) ?? 30,
                              dob: dobCtrl.text,
                              gender: genderCtrl.text,
                              phone: phoneCtrl.text,
                              emergencyPhone: emergencyCtrl.text.isEmpty ? phoneCtrl.text : emergencyCtrl.text,
                              address: addressCtrl.text.isEmpty ? "Registered Address" : addressCtrl.text,
                              history: historyCtrl.text.isEmpty ? "None Recorded" : historyCtrl.text,
                              vitals: vitalsCtrl.text,
                            ));
                          });
                          Navigator.pop(context);
                          _showMessage('Patient Added With Full Vitals & History');
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8), foregroundColor: Colors.white),
                      child: const Text('Save Patient Record'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditPatientModal(Patient p) {
    final nameCtrl = TextEditingController(text: p.name);
    final staffCtrl = TextEditingController(text: p.staffNo);
    final phoneCtrl = TextEditingController(text: p.phone);
    final addressCtrl = TextEditingController(text: p.address);
    final historyCtrl = TextEditingController(text: p.history);
    final vitalsCtrl = TextEditingController(text: p.vitals);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit Patient Details (${p.id})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
                const SizedBox(height: 16),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Patient Name')),
                TextField(controller: staffCtrl, decoration: const InputDecoration(labelText: 'Staff No')),
                TextField(controller: phoneCtrl, decoration: const InputDecoration(labelText: 'Phone Number')),
                TextField(controller: addressCtrl, decoration: const InputDecoration(labelText: 'Address')),
                TextField(controller: historyCtrl, decoration: const InputDecoration(labelText: 'Medical History')),
                TextField(controller: vitalsCtrl, decoration: const InputDecoration(labelText: 'Vitals')),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          p.name = nameCtrl.text.toUpperCase();
                          p.staffNo = staffCtrl.text;
                          p.phone = phoneCtrl.text;
                          p.address = addressCtrl.text;
                          p.history = historyCtrl.text;
                          p.vitals = vitalsCtrl.text;
                        });
                        Navigator.pop(context);
                        _showMessage('Patient Details Updated');
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8), foregroundColor: Colors.white),
                      child: const Text('Update Record'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContextualDocument({required String title, required String type, required List<Map<String, String>> fields}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 520,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_clinicTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF6B21A8))),
                      Text('Dr. $_doctorName | ID: $_doctorId', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: Colors.purple.shade100, borderRadius: BorderRadius.circular(6)),
                    child: Text(type, style: const TextStyle(color: Color(0xFF6B21A8), fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                ],
              ),
              const Divider(height: 24),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
              const SizedBox(height: 12),
              ...fields.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 140, child: Text(f['label']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
                        Expanded(child: Text(f['value']!, style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('Print Job Sent');
                    },
                    icon: const Icon(Icons.print),
                    label: const Text('Print Document'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showMessage('PDF File Downloaded');
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download PDF'),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8), foregroundColor: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showQuickBookModal() {
    final patientCtrl = TextEditingController(text: _patients.isNotEmpty ? _patients.first.name : "");
    final reasonCtrl = TextEditingController(text: "Physiotherapy Session");
    final timeCtrl = TextEditingController(text: "11:00 AM");

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Schedule Quick Appointment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF6B21A8))),
              const SizedBox(height: 16),
              TextField(controller: patientCtrl, decoration: const InputDecoration(labelText: 'Patient Name')),
              TextField(controller: reasonCtrl, decoration: const InputDecoration(labelText: 'Session Reason')),
              TextField(controller: timeCtrl, decoration: const InputDecoration(labelText: 'Time Slot')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  ElevatedButton(
                    onPressed: () {
                      if (patientCtrl.text.isNotEmpty) {
                        setState(() {
                          _appointments.add(AppointmentItem(
                            id: "A-0${_appointments.length + 1}",
                            patientName: patientCtrl.text,
                            doctor: _doctorName,
                            time: timeCtrl.text,
                            date: "Aug 21, 2026",
                            phone: _patients.isNotEmpty ? _patients.first.phone : "9953134406",
                            reason: reasonCtrl.text,
                            status: "Scheduled",
                            doctorReminderSet: true,
                          ));
                        });
                        Navigator.pop(context);
                        _showMessage('Appointment Scheduled with Doctor Alert');
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8), foregroundColor: Colors.white),
                    child: const Text('Book Appointment'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E8FF),
      body: Column(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: const Color(0xFFFAF5FF),
            child: Row(
              children: [
                const Text(
                  'SHAPC Secure Vault Clinical System v1.5.0-stable',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B)),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.cloud_upload_outlined, color: Colors.black87),
                  tooltip: 'Manual Sync',
                  onPressed: () => _showMessage('Cloud Backup Triggered'),
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle, color: Color(0xFF6B21A8)),
                  tooltip: 'Profile & Settings',
                  onPressed: _showProfileModal,
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF15803D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, size: 14, color: Colors.white),
                      SizedBox(width: 6),
                      Text('Cloud Sync Active', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: const Color(0xFFFAF5FF),
                  selectedIconTheme: const IconThemeData(color: Color(0xFF6B21A8)),
                  unselectedIconTheme: const IconThemeData(color: Colors.black54),
                  selectedLabelTextStyle: const TextStyle(color: Color(0xFF6B21A8), fontWeight: FontWeight.bold),
                  destinations: const [
                    NavigationRailDestination(icon: Icon(Icons.grid_view), label: Text('Dashboard')),
                    NavigationRailDestination(icon: Icon(Icons.people), label: Text('Patients')),
                    NavigationRailDestination(icon: Icon(Icons.calendar_today), label: Text('Appointments')),
                    NavigationRailDestination(icon: Icon(Icons.account_balance_wallet), label: Text('Bookkeeping')),
                    NavigationRailDestination(icon: Icon(Icons.bar_chart), label: Text('Reports')),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1, color: Colors.black12),
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
          const Text('Clinical System Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
          const SizedBox(height: 20),
          Row(
            children: [
              _dashCard('Total Registered Patients', '${_patients.length}', Icons.people, Colors.purple),
              const SizedBox(width: 16),
              _dashCard('Today\'s Appointments', '${_appointments.length}', Icons.calendar_month, Colors.indigo),
              const SizedBox(width: 16),
              _dashCard('Daily Ledger Entries', '${_dailyLedger.length}', Icons.account_balance_wallet, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dashCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
                const SizedBox(height: 4),
                Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
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
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black38),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.black54),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          onChanged: (val) => setState(() => _searchQuery = val),
                          decoration: const InputDecoration(
                            hintText: 'Search by Name, Phone, Staff No, or Patient ID...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _showAddPatientModal,
                icon: const Icon(Icons.person_add_alt_1, size: 18),
                label: const Text('Add Patient'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE9D5FF), foregroundColor: const Color(0xFF581C87)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _patients.length,
              itemBuilder: (context, index) {
                final p = _patients[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('${p.name} (${p.id})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.visibility, color: Color(0xFF0284C7)),
                            onPressed: () => _showContextualDocument(
                              title: 'PATIENT DOSSIER',
                              type: 'FULL VIEW',
                              fields: [
                                {'label': 'Patient ID:', 'value': p.id},
                                {'label': 'Full Name:', 'value': p.name},
                                {'label': 'Vitals Logged:', 'value': p.vitals},
                                {'label': 'Clinical History:', 'value': p.history},
                              ],
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.edit, color: Color(0xFFD97706)), onPressed: () => _showEditPatientModal(p)),
                        ],
                      ),
                      Text('Staff No: ${p.staffNo} | History: ${p.history} | Vitals: ${p.vitals}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. APPOINTMENT TRACKER WITH DOCTOR REMINDER ALERT ---
  Widget _buildAppointmentsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Appointment Tracker', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E1B4B))),
              ElevatedButton.icon(
                onPressed: _showQuickBookModal,
                icon: const Icon(Icons.alarm_add, size: 18),
                label: const Text('Quick Book'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE9D5FF), foregroundColor: const Color(0xFF581C87)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                final appt = _appointments[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: appt.doctorReminderSet ? const Color(0xFF6B21A8) : Colors.black12, width: appt.doctorReminderSet ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(appt.patientName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(width: 10),
                                if (appt.doctorReminderSet)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.amber.shade800)),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.alarm_on, size: 12, color: Colors.amber),
                                        SizedBox(width: 4),
                                        Text('⏰ Doctor Alert Active', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Doctor: ${appt.doctor} | Schedule: ${appt.date} at ${appt.time}'),
                            Text('Reason: ${appt.reason}', style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ),
                      // Toggle Doctor Reminder State
                      IconButton(
                        icon: Icon(appt.doctorReminderSet ? Icons.notifications_active : Icons.notifications_none, color: appt.doctorReminderSet ? Colors.amber.shade800 : Colors.grey),
                        tooltip: appt.doctorReminderSet ? 'Doctor Reminder Active' : 'Set Doctor Reminder',
                        onPressed: () {
                          setState(() => appt.doctorReminderSet = !appt.doctorReminderSet);
                          _showMessage(appt.doctorReminderSet ? 'Doctor Reminder Activated' : 'Doctor Reminder Cleared');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.visibility, color: Color(0xFF0284C7)),
                        onPressed: () => _showContextualDocument(
                          title: 'APPOINTMENT DETAILS',
                          type: 'TRACKER',
                          fields: [
                            {'label': 'Patient:', 'value': appt.patientName},
                            {'label': 'Doctor:', 'value': appt.doctor},
                            {'label': 'Schedule:', 'value': '${appt.date} - ${appt.time}'},
                            {'label': 'Doctor Reminder:', 'value': appt.doctorReminderSet ? "ACTIVE ALERT" : "DISABLED"},
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookkeepingView() {
    return const Center(child: Text('Bookkeeping Ledger Active'));
  }

  Widget _buildReportsView() {
    return const Center(child: Text('Reports & Exports Active'));
  }
}