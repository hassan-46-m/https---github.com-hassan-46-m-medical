import 'package:flutter/material.dart';


import '../colors/app_colors.dart';

class HomeDetails extends StatelessWidget {
  HomeDetails({super.key});

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        // If the content might overflow vertically
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align text to the start
          children: [
            const Padding(
              // Add padding for better visual spacing
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 4),
              child: Text(
                "Popular",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              // Use SizedBox for fixed height
              height: 200,
              child: ListView.builder(
                // Use ListView.builder for dynamic items
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with your actual item count
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      scaffoldKey.currentState!.showBottomSheet(
                        (context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Drug Details',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade400,
                                          blurRadius: 4)
                                    ],
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Drug Name:',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 4),
                                            Text('Active ingredient:'),
                                            SizedBox(height: 4),
                                            Text('Details:'),
                                            SizedBox(height: 4),
                                            Text('For:'),
                                          ],
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                            'assets/images/drug.png',
                                            width: 60,
                                            height: 60),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                          color: AppColor.primaryColor,
                                          Icons.arrow_back),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton.icon(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade700,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                        ),
                                        icon: Icon(Icons.favorite,
                                            color: Colors.white),
                                        label: Text('Add to favourite',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.all(8.0),
                      // Add margin between items
                      decoration: BoxDecoration(
                        // Use BoxDecoration for styling
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(
                            8.0), // Example: rounded corners
                      ),
                      child: Center(
                        // Center the content within the container (optional)
                        child: Text(
                          'Item $index', // Example text
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            const Padding(
              // Add padding for better visual spacing
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 4),
              child: Text(
                "Suggestion",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              // Use SizedBox for fixed height
              height: 200,
              child: ListView.builder(
                // Use ListView.builder for dynamic items
                scrollDirection: Axis.horizontal,
                itemCount: 10, // Replace with your actual item count
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.all(8.0),
                    // Add margin between items
                    decoration: BoxDecoration(
                      // Use BoxDecoration for styling
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(
                          8.0), // Example: rounded corners
                    ),
                    child: Center(
                      // Center the content within the container (optional)
                      child: Text(
                        'Item $index', // Example text
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
