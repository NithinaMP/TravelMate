import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/mainProvider.dart';

class SampleOne extends StatefulWidget {
  const SampleOne({super.key});

  @override
  State<SampleOne> createState() => _SampleOneState();
}

class _SampleOneState extends State<SampleOne> {
  bool isChecked = false;
  String? selectDesignation;
  final List<String> designation = ["Available", "Not Available"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown"),
      ),
      body: Column(
        children: [
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border when focused
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none, // No border when enabled
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: "Designation",
                    labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: "muktaregular"),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  value: selectDesignation,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: "muktaregular"),
                  dropdownColor: Colors.purple, // Dropdown color
                  items: designation.map((String designation) {
                    return DropdownMenuItem<String>(
                      value: designation,
                      child: Text(designation),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectDesignation = newValue;
                        value.slotController.text =
                            newValue; // Update the controller here
                      });
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }
          ),

          Consumer<MainProvider>(
            builder: (context,val,child) {
              return ElevatedButton(onPressed: () {
                val.addSlot();
              }, child: Text("Done"));
            }
          )
        ],
      ),
    );
  }
}
// TextEditingController slotController = TextEditingController();
// void addSlot(){
//   String id=DateTime.now().microsecondsSinceEpoch.toString();
//   Map<String,dynamic>det=HashMap();
//   det["DESIGNATION"] = slotController.text;
//   db.collection("Slot").doc(id).set(det);
//   notifyListeners();
//
// }