import 'package:bike_tuk_tuk/BecomeDriverPage.dart';
import 'package:bike_tuk_tuk/BookRidePage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFF6EB2B),
      //   leading: Padding(
      //     padding: const EdgeInsets.only(left: 16, top: 8),
      //     child: Icon(
      //       Icons.account_circle_sharp,
      //       size: 52,
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      AssetImage('assets/BikeTukTuk.jpg'), // Profile image
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 40),
                Container(
                  // color: Colors.yellow[100],
                  padding: const EdgeInsets.only(
                      left: 50, right: 50, top: 60, bottom: 60),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12,
                  ),

                  child: Column(
                    children: [
                      const Text(
                        'Welcome to Bike Tuk Tuk!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Get a ride anytime, anywhere.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BookRidePage()), // Replace with the appropriate page
                          );
                        },
                        icon: const Icon(Icons.directions_bike,
                            color: Colors.white),
                        label: const Text(
                          'Book a Ride',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          backgroundColor: Colors.lime[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Becomedriverpage()), // Replace with the appropriate page
                          );
                        },
                        icon: const Icon(Icons.person_add_alt,
                            color: Colors.white),
                        label: const Text(
                          'Become a Driver',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 30.0),
                          backgroundColor: Colors.yellow[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
