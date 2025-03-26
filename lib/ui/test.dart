import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrugListScreen extends StatefulWidget {
  const DrugListScreen({super.key});

  @override
  _DrugListScreenState createState() => _DrugListScreenState();
}

class _DrugListScreenState extends State<DrugListScreen> {
  List<dynamic> _drugs = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchAllDrugs();
  }

  Future<void> _fetchAllDrugs() async {
    final url = Uri.parse('https://1474-196-159-72-17.ngrok-free.app/api/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        if (decodedResponse is List) {
          setState(() {
            _drugs = decodedResponse;
            _isLoading = false;
          });
        } else if (decodedResponse is Map && decodedResponse.containsKey('data')) {
          setState(() {
            _drugs = List.from(decodedResponse['data']);
            _isLoading = false;
          });
        } else {
          print('Unexpected JSON format');
          setState(() {
            _hasError = true;
            _isLoading = false;
          });
        }
      } else {
        print('Error: ${response.statusCode}, Response: ${response.body}');
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to load data: $e');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Drugs'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(child: Text('Failed to load data, please try again.'))
          : ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _drugs.length,
        itemBuilder: (context, index) {
          final drug = _drugs[index];

          // تأكد من أن البيانات ليست null وأضف قيم افتراضية عند الحاجة
          final String drugName = drug['name'] ?? 'Unknown';
          final String activeIngredient = drug['ingredient'] ?? 'Not available';
          final String imageUrl = drug['image_url'] ?? '';

          return Card(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                'Drug Name: $drugName',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Active Ingredient: $activeIngredient',
              ),
              trailing: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                  imageUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, color: Colors.red);
                  },
                )
                    : Icon(Icons.medical_services, size: 50, color: Colors.blue),
              ),
            ),
          );
        },
      ),
    );
  }
}
