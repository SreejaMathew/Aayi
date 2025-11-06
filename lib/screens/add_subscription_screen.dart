import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final TextEditingController planNameController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController patientMobileController = TextEditingController();
  final TextEditingController patientEmailController = TextEditingController();

  final TextEditingController caregiverNameController = TextEditingController();
  final TextEditingController caregiverMobileController =
      TextEditingController();
  final TextEditingController caregiverEmailController =
      TextEditingController();

  final TextEditingController familyNameController = TextEditingController();
  final TextEditingController familyMobileController = TextEditingController();
  final TextEditingController familyEmailController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> addSubscription() async {
    if (planNameController.text.isEmpty || patientNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Add main subscription
      final subscriptionRef = await firestore.collection('subscriptions').add({
        'planName': planNameController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Add members
      await subscriptionRef.collection('members').add({
        'name': patientNameController.text.trim(),
        'mobile': patientMobileController.text.trim(),
        'gmail': patientEmailController.text.trim(),
        'type': 'Patient',
      });

      await subscriptionRef.collection('members').add({
        'name': caregiverNameController.text.trim(),
        'mobile': caregiverMobileController.text.trim(),
        'gmail': caregiverEmailController.text.trim(),
        'type': 'Caregiver',
      });

      await subscriptionRef.collection('members').add({
        'name': familyNameController.text.trim(),
        'mobile': familyMobileController.text.trim(),
        'gmail': familyEmailController.text.trim(),
        'type': 'Family Member',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Subscription added successfully!")),
      );

      planNameController.clear();
      patientNameController.clear();
      patientMobileController.clear();
      patientEmailController.clear();
      caregiverNameController.clear();
      caregiverMobileController.clear();
      caregiverEmailController.clear();
      familyNameController.clear();
      familyMobileController.clear();
      familyEmailController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ Failed: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool required = false,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label + (required ? " *" : ""),
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Subscription")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField("Plan Name", planNameController, required: true),
            const SizedBox(height: 20),

            const Text(
              "👩‍⚕️ Patient Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildTextField("Name", patientNameController, required: true),
            const SizedBox(height: 8),
            buildTextField("Mobile", patientMobileController),
            const SizedBox(height: 8),
            buildTextField("Gmail", patientEmailController),
            const SizedBox(height: 20),

            const Text(
              "👨‍⚕️ Caregiver Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildTextField("Name", caregiverNameController),
            const SizedBox(height: 8),
            buildTextField("Mobile", caregiverMobileController),
            const SizedBox(height: 8),
            buildTextField("Gmail", caregiverEmailController),
            const SizedBox(height: 20),

            const Text(
              "👨‍👩‍👧 Family Member Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            buildTextField("Name", familyNameController),
            const SizedBox(height: 8),
            buildTextField("Mobile", familyMobileController),
            const SizedBox(height: 8),
            buildTextField("Gmail", familyEmailController),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: isLoading ? null : addSubscription,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Subscription"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
