import 'package:bike_tuk_tuk/homepage.dart';
import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs: Login and Sign up
      child: Scaffold(
        body: Stack(
          children: [
            // Yellow Background
            Container(
              width: double.infinity,
              color: Colors.yellow,
              child: const Padding(
                padding: EdgeInsets.only(top: 95, left: 30),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TabBar for Login and Sign up
                    TabBar(
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.yellow,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.white,
                      indicatorWeight: 5.0,
                      labelPadding: EdgeInsets.only(left: 0, right: 40),
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorPadding: EdgeInsets.symmetric(vertical: -10),
                      tabs: [
                        Tab(text: 'Log in'),
                        Tab(text: 'Sign up'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // White Box with rounded left BorderRadius
            Positioned(
              top: 180,
              bottom: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width, // Full width
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TabBarView(
                    children: [
                      // Login form
                      _buildLoginForm(),
                      // Sign up form
                      _buildSignUpForm(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: UnderlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Perform login action
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              backgroundColor: Colors.yellow, // Button color
              foregroundColor: Colors.black, // Button text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Log in',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: UnderlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            border: UnderlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Perform sign-up action
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
              backgroundColor: Colors.yellow, // Button color
              foregroundColor: Colors.black, // Button text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
