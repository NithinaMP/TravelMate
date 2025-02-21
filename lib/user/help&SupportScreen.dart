import 'package:flutter/material.dart';
import 'package:travelmate/constants/call_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constant_colors.dart';
import 'FAQScreen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  // Function to launch phone dialer
  void _callSupport() async {
    final Uri phoneUri = Uri(scheme: "tel", path: "+919744151058"); // Replace with your support number
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint("Could not launch phone dialer");
    }
  }

  void _whatsappSupport() async {
    final Uri whatsappUri = Uri.parse(
        "https://wa.me/919744151058?text=Hello%20Support,%20I%20need%20help%20with%20my%20booking."
    ); // Replace with your support number and message

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      debugPrint("Could not open WhatsApp");
    }
  }


  // Function to launch email
  void _emailSupport() async {
    final Uri emailUri = Uri(
      scheme: "mailto",
      path: "nandhithampnandhu@gmail.com",
      queryParameters: {"subject": "Support Request"},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("Could not open email app");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help & Support",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: cstOrange1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text("Call Support"),
              subtitle: Text("Talk to our support team"),
              onTap: _callSupport,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.message, color: Colors.green),
              title: Text("WhatsApp Support"),
              subtitle: Text("Chat with us on WhatsApp"),
              onTap: _whatsappSupport,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text("Email Support"),
              subtitle: Text("Send us an email"),
              onTap: _emailSupport,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.orange),
              title: Text("FAQs"),
              subtitle: Text("Frequently Asked Questions"),
              onTap: () {
                callNext(context, FAQScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
