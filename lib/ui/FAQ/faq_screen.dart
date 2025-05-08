import 'package:flutter/material.dart';



class FAQScreen extends StatelessWidget {
  static const String routeName = "FAQ screen";

  @override
  Widget build(BuildContext context) {
    return (Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "FAQ",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FAQSection(
              icon: Icons.medical_services_outlined,
              title: "General Questions",
              questions: [
                "What is this app used for?",
                "Is this app a replacement for a doctor’s prescription?",
                "Is the app free to use?",
              ],
            ),
            FAQSection(
              icon: Icons.person,
              title: "Account & Login",
              questions: [
                "How do i create an account?",
                "I forgot my password. How can I reset it?",
                "Can I update my personal information?",
              ],
            ),
            FAQSection(
              icon: Icons.search,
              title: "Search & Drug Info",
              questions: [
                "How do I search for a medicine?",
                "Can I take photo of Prescription insstead of typing the drug name?",
              ],
            ),
            FAQSection(
              icon: Icons.history,
              title: "History",
              questions: [
                "What does the “History”section show?",
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class FAQSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> questions;

  const FAQSection({
    required this.icon,
    required this.title,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 8),
          ...questions.map(
                (q) => Padding(
              padding: const EdgeInsets.only(left: 32.0, bottom: 4),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                onPressed: () {


                  print('Tapped on: $q');
                },
                child: Text(
                  q,
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
