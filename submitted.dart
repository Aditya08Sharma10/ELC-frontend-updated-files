import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

class SubmittedDataPage extends StatefulWidget {
  const SubmittedDataPage({super.key});
  @override
  SubmittedDataPageState createState() => SubmittedDataPageState();
}

class SubmittedDataPageState extends State<SubmittedDataPage> {
  List<dynamic> submittedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSubmittedData();
  }

  Future<void> fetchSubmittedData() async {
    final url = Uri.parse('https://elcapp.42web.io/get_data.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded is Map && decoded['data'] is List) {
          setState(() {
            submittedData = decoded['data'];
            isLoading = false;
          });
        } else {
          logger.e("Unexpected response format: $decoded");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        logger.e("Failed to fetch data");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      logger.e("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/10.jpg',
              width: 430,
              height: 700,
              fit: BoxFit.fill,
            ),
            Container(
              width: 320,
              height: 480,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(13),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : submittedData.isEmpty
                  ? Center(child: Text("No submissions found!"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: submittedData.length,
                      itemBuilder: (context, index) {
                        final item = submittedData[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${item['name']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Email: ${item['email']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Phone: ${item['phone']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'DOB: ${item['dob']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Gender: ${item['gender']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              'Blood Group: ${item['blood_group']}',
                              style: TextStyle(color: Colors.black),
                            ),
                            Divider(color: Colors.black),
                          ],
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
