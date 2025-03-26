import 'package:flutter/material.dart';

class FavoriteDrugs {
  static List<Map<String, dynamic>> favorites = [];
}

class LikedDetails extends StatefulWidget {
  const LikedDetails({super.key});

  @override
  _LikedDetailsState createState() => _LikedDetailsState();
}

class _LikedDetailsState extends State<LikedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Drugs")),
      body: FavoriteDrugs.favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorite drugs added yet.",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        itemCount: FavoriteDrugs.favorites.length,
        itemBuilder: (context, index) {
          final drug = FavoriteDrugs.favorites[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              title: Text(
                drug['MedicineName'] ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Manufacturer: ${drug['Manufacturer'] ?? 'Not available'}\nPrice: ${drug['Price'] ?? 'N/A'}',
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: drug['ImageURL'] != null && drug['ImageURL']!.isNotEmpty
                    ? Image.network(
                  drug['ImageURL']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, color: Colors.red);
                  },
                )
                    : const Icon(Icons.medical_services, size: 50, color: Colors.blue),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    FavoriteDrugs.favorites.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${drug['MedicineName']} removed from favorites!')),
                  );
                },
              ),
              onTap: () {
                // **التنقل إلى شاشة التفاصيل عند النقر على العنصر**
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrugDetails(drug: drug),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DrugDetails extends StatelessWidget {
  final Map<String, dynamic> drug;

  const DrugDetails({super.key, required this.drug});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Drug Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Drug Details', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: drug['ImageURL'] != null && drug['ImageURL']!.isNotEmpty
                    ? Image.network(
                  drug['ImageURL']!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, color: Colors.red, size: 100);
                  },
                )
                    : const Icon(Icons.medical_services, size: 100, color: Colors.blue),
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.grey.shade400, blurRadius: 4)],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Drug Name:', drug['MedicineName']),
                  _buildDetailRow('Active Ingredient:', drug['Composition']),
                  _buildDetailRow('Uses:', drug['Uses']),
                  _buildDetailRow('Side Effects:', drug['Side_effects']),
                  _buildDetailRow('Manufacturer:', drug['Manufacturer']),
                  _buildDetailRow('Price:', drug['Price']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(text: '$title ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value ?? 'Not available'),
          ],
        ),
      ),
    );
  }
}
