import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  final String? token;
  const Dashboard({super.key, this.token});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Map<String, dynamic>? userData;

   @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    var hardToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzMzM3MGJmMi1jZDRkLTQ4MjgtYWIwZS0xZDE2MWEwMzZmNTMiLCJpYXQiOjE3NDk4OTA2NDAsImV4cCI6MTc0OTg5NDI0MH0.4bEaKPfaQkxtVTLgz7yRU9sYEsLdnNkdji9XIaUHCDA";
    final res = await http.get(
      Uri.parse("https://p066xjm1-8000.inc1.devtunnels.ms/api/users/me"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $hardToken',
      },
    );
    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      setState(() {
        userData = body['data']['user'];
      });
    } else {
      // handle error…
      print("Failed to load profile: $res");
    }
  }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Text("Dashboard",
  //         style: GoogleFonts.pacifico(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 50,
  //           color: Colors.blue,
  //         )
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(100),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      // adjust URL to your server’s image path
                      "https://lh3.googleusercontent.com/a/ACg8ocI8ycrL6Wf_okwYZU4dpD0aOlvjO3wAqa4bDSz06yRy2I4qTAU=s96-c",
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userData!['name'],
                    style: GoogleFonts.pacifico(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(userData!['email'],
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Role: ${userData!['role']}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("Provider: ${userData!['provider']}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 24),
                
                ],
              ),
            ),
    );
  }
}