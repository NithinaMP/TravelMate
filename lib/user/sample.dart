import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/provider/mainProvider.dart';

// /// State Management Class
// class SelectedIndexProvider extends ChangeNotifier {
//   int _selectedIndex = -1;
//
//   int get selectedIndex => _selectedIndex;
//
//   void selectIndex(int index) {
//     _selectedIndex = index;
//     notifyListeners(); // Notify listeners to rebuild the UI
//   }
// }



class InfiniteNumberSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite Number Selector"),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50, // Adjust the height of the row container
              child: Consumer<MainProvider>(
                builder: (context, dvalue, child) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final selectedIndex = dvalue.selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          dvalue.selectIndex(index);
                          print("Selected: ${index + 1} seats");
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? Colors.redAccent
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Consumer<MainProvider>(
              builder: (context, dvalue, child) {
                return ElevatedButton(
                  onPressed: dvalue.selectedIndex == -1
                      ? null // Button disabled when no number is selected
                      : () {
                    // Handle "Select seats" button press
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: dvalue.selectedIndex == -1
                        ? Colors.grey // Disabled button color
                        : Colors.redAccent, // Active button color
                  ),
                  child: Text(
                    "Select seats",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dvalue.selectedIndex == -1
                          ? Colors.black54 // Disabled text color
                          : Colors.white, // Active text color
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

