import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: cstOrange1,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: Text("How do I book a trip?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "To book a trip, browse destinations, select your preferred package, and proceed with the payment.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("What payment methods are accepted?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "We accept credit/debit cards, UPI, net banking, and digital wallets.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Can I modify my booking details after confirmation?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Currently, modifications are not allowed after booking. Please contact support for urgent changes.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("How do I find details about my trip?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All trip details, including itinerary and accommodation info, can be found in the 'My Trips' section.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Are travel guides included in my booking?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Some packages include professional guides. Check the package details before booking.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("What should I do if I face an issue during my trip?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "In case of any issues, contact our 24/7 support team via phone, WhatsApp, or email from the Help & Support section.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Is there a refund policy?", style: TextStyle(fontWeight: FontWeight.bold)),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Refunds are subject to our policy. Please check the terms and conditions in the booking section.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
