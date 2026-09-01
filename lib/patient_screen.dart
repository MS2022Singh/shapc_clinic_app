import 'package:flutter/material.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({Key? key}) : super(key: key);

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final List<Map<String, String>> _patients = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();

  void _addPatient() {
    if (_nameController.text.isNotEmpty) {
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
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Management - SHAPC Clinic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Patient Name')),
            TextField(controller: _ageController, decoration: const InputDecoration(labelText: 'Age')),
            TextField(controller: _diseaseController, decoration: const InputDecoration(labelText: 'Diagnosis / Disease')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _addPatient, child: const Text('Add Patient')),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                  final patient = _patients[index];
                  return Card(
                    child: ListTile(
                      title: Text(patient['name'] ?? ''),
                      subtitle: Text('Age:  | Disease: '),
                    ),
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
