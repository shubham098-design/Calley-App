import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            SizedBox(
                height: 60,
                width: 60,
                child: Icon(Icons.person,)),
            const SizedBox(height: 20),

            // Name
            const Text(
              "Shubham Kashyap",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),

            // Tagline
            const Text(
              "Passionate Developer • Problem Solver • Innovator",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Description
            const Text(
              "Hello! I'm Shubham Kashyap, a creative and detail-oriented software developer with a passion for crafting clean, "
                  "user-friendly, and scalable mobile applications. I believe in writing code that not only works but also "
                  "inspires others. With a strong grasp of Flutter, UI/UX design, and problem-solving skills, my mission is "
                  "to turn ideas into reality and deliver meaningful digital experiences.",
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),

            // Contact Info
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("📧 Email: shubhamdhaniyan09@gmail.com",
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 8),
                    Text("📍 Location: India",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Footer
            const Text(
              "© 2025 Shubham . All rights reserved.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
