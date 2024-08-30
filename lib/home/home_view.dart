import 'package:flutter/material.dart';

import 'widgets/cookie_write.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildInfo(),
          const CookieWrite(),

        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Container(
      width: 360,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey)
      ),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              """
This is an overview of the OneFile API and it's endpoints, providing information on how to interact with them.

Each API call requires a special 'Cookie' header, which is just an authentication token. The token is made up of three parts: the livekeychain, authticket, and the journalticket. 

You can aquire this cookie by going to the OneFile website, logging in, and navigating to the 'Learning Journal' tab. Then, enter 'developer mode' / 
'inspect element', go to the 'network' tab and refresh the page. You should see list of API calls 
appear, find the one that says 'journalEntry' and click on it. It should show a new tab / window with some details about the call, scroll down and find
the 'Cookie' in the 'Request Headers' section. Copy the value and store it somewhere, like a password manager.
              
              """,
              style: TextStyle(
                fontFamily: "Inter",
                color: Colors.grey,
                fontSize: 14
              ),
            ),
          ],
        ),
      ),
    );
  }
}