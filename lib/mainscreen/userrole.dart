import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayer/mainscreen/director_screen.dart';

import 'artist_screen.dart';

class UserRoleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding/userrole.png'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay (optional, for better text visibility)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Buttons and Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title or Tagline (optional)
              Text(
                'Choose Your Role',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 4.0,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // "I am an Artist" Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: ()=>Get.to(()=>ArtistScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // White button
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    elevation: 5, // Add shadow for a better look
                  ),
                  child: Text(
                    'I am an Artist',
                    style: TextStyle(
                      color: Colors.orange, // Orange text
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10), // Space between buttons

              // "I am a Director" Button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: ()=>Get.to(()=>DirectorScreen()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Orange button
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    elevation: 5, // Add shadow for a better look
                  ),
                  child: Text(
                    'I am a Director',
                    style: TextStyle(
                      color: Colors.white, // White text
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Footer for Positioning
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Powered by VideoPlayer App',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
