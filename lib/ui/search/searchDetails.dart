import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Searchdetails extends StatefulWidget {
  const Searchdetails({super.key});

  @override
  _SearchdetailsState createState() => _SearchdetailsState();
}

class _SearchdetailsState extends State<Searchdetails> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  bool _hasError = false;

  Future<void> _searchDrugs(String query) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    String url = query.isEmpty
        ? 'https://ca2c-45-101-122-117.ngrok-free.app/api'
        : 'https://ca2c-45-101-122-117.ngrok-free.app/api/search/$query';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        if (decodedResponse is Map && decodedResponse.containsKey('data')) {
          setState(() {
            _searchResults = List.from(decodedResponse['data']).map((drug) {
              return {
                'name': drug['MedicineName'] ?? 'Unknown',
                'ingredient': drug['Composition'] ?? 'Not available',
                'image_url': drug['ImageURL'] ?? '',
                'uses': drug['Uses'] ?? 'No uses available',
                'side_effects': drug['Side_effects'] ?? 'No side effects listed',
                'manufacturer': drug['Manufacturer'] ?? 'Unknown manufacturer',
                'price': drug['Price (EGP)'] ?? 'Price not available',
              };
            }).toList();
          });
        } else {
          print('Unexpected JSON format');
          setState(() => _hasError = true);
        }
      } else {
        print('Error: ${response.statusCode}, Response: ${response.body}');
        setState(() => _hasError = true);
      }
    } catch (e) {
      print('Failed to load search results: $e');
      setState(() => _hasError = true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Medicines")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _searchDrugs(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                suffixIcon: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.blue),
                  onPressed: () {}, // Implement image search feature
                ),
                hintText: 'Type here to search...',
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _hasError
                ? Center(child: Text('Failed to load data. Please try again.'))
                : ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final drug = _searchResults[index];
                final String drugName = drug['name'] ?? 'Unknown';
                final String activeIngredient = drug['ingredient'] ?? 'Not available';
                final String imageUrl = drug['image_url'] ?? '';
                final String uses = drug['uses'] ?? 'No uses available';
                final String sideEffects = drug['side_effects'] ?? 'No side effects listed';
                final String manufacturer = drug['manufacturer'] ?? 'Unknown manufacturer';
                final String price = drug['price'] ?? 'Price not available';

                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      'Drug Name: $drugName',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active Ingredient: $activeIngredient'),
                        Text('Uses: $uses'),
                        Text('Side Effects: $sideEffects'),
                        Text('Manufacturer: $manufacturer'),
                        Text('Price: $price'),
                      ],
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
          ),
        ],
      ),
    );
  }
}
