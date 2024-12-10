import 'package:flutter/material.dart';

class SwitchInRowExample extends StatefulWidget {
  @override
  _SwitchInRowExampleState createState() => _SwitchInRowExampleState();
}

class _SwitchInRowExampleState extends State<SwitchInRowExample> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Switch with Status"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 11),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.confirmation_num_outlined,
                  color: Colors.brown,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    "Slot Availability",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: "baloo",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.white,
                ),
                Text(
                  isSwitched ? "Available" : "Not Available",
                  style: TextStyle(
                    color: isSwitched ? Colors.green : Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}