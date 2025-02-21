import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelmate/constants/call_functions.dart';

import '../constants/constant_colors.dart';
import '../provider/mainProvider.dart';
import 'EventDetail.dart';

class AllEventScreen extends StatelessWidget {
  String userId;
  AllEventScreen({super.key,required this.userId});

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              "Events",
              style: TextStyle(
                fontFamily: "bakbak",
                fontSize: 28,
                color: Colors.white,
                // fontWeight: FontWeight.bold
              ),
            ),

          ),



          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<MainProvider>(
                          builder: (context, provider, child) {
                            return Container(
                              height: height / 15,
                              decoration: BoxDecoration(
                                gradient: admingradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Autocomplete<String>(
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  // If the search bar is cleared, reset the filtered list to the full list
                                  if (textEditingValue.text.isEmpty) {
                                    provider.updateFilteredEvents(provider.eventList);
                                    return provider.eventList
                                        .map((event) => event.eventName) // Ensure returning a List<String>
                                        .toList();
                                  } else {
                                    // Filter the destinations based on the search text
                                    var filteredList = provider.eventList.where((event) =>
                                    event.eventName.toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                                        event.eventPlace.toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                                        event.eventDistrict.toLowerCase().contains(textEditingValue.text.toLowerCase()) ||
                                        event.eventDescription.toLowerCase().contains(textEditingValue.text.toLowerCase())
                                    ).toList();

                                    // Show Snackbar if no destinations match
                                    if (filteredList.isEmpty && textEditingValue.text.isNotEmpty) {
                                      // Show a Snackbar if no destinations match
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('No Event found matching your search.'),
                                          backgroundColor: Colors.pink.shade200,
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 2),
                                        ),

                                      );


                                    }

                                    provider.updateFilteredEvents(filteredList); // Update filtered list with List<DestinationModel>
                                    return filteredList.map((event) => event.eventName).toList(); // Map to List<String>
                                  }
                                },
                                displayStringForOption: (String option) => option,
                                fieldViewBuilder: (BuildContext context,
                                    TextEditingController fieldTextEditingController,
                                    FocusNode fieldFocusNode,
                                    VoidCallback onFieldSubmitted) {
                                  return TextField(
                                    textAlign: TextAlign.left,
                                    focusNode: fieldFocusNode,
                                    controller: fieldTextEditingController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(width: 0.5, color: Colors.transparent),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(width: 0.5, color: Colors.transparent),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(width: 0.5, color: Colors.transparent),
                                      ),
                                      prefixIcon: GestureDetector(
                                          onTap: () {
                                            fieldFocusNode.requestFocus();
                                          },
                                          child: Icon(Icons.search_outlined,size: 30,color: Colors.grey,)),
                                      hintText: "Find out where you want to go!",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                      // suffixIcon: GestureDetector(
                                      //   onTap: () {
                                      //     fieldFocusNode.requestFocus();
                                      //   },
                                      //   child: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                                      // ),
                                    ),
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.grey),
                                  );
                                },
                                onSelected: (String selection) {
                                  // Filter destinations based on the selected name
                                  var filteredEvents = provider.eventList
                                      .where((event) => event.eventName.toLowerCase() == selection.toLowerCase())
                                      .toList();

                                  provider.updateFilteredEvents(filteredEvents);
                                },
                                optionsViewBuilder: (BuildContext context,
                                    AutocompleteOnSelected<String> onSelected,
                                    Iterable<String> options) {
                                  return Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 30,
                                        height: 200,
                                        color: Colors.black,
                                        child: ListView.builder(
                                          padding: const EdgeInsets.all(10.0),
                                          itemCount: options.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            final String option = options.elementAt(index);
                                            return GestureDetector(
                                              onTap: () {
                                                onSelected(option);
                                              },
                                              child: Container(
                                                color: Colors.black,
                                                height: 40,
                                                width: MediaQuery.of(context).size.width - 30,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(option,
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w500, color: Colors.grey)),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),

                        Consumer<MainProvider>(
                            builder: (context1,dValue,child) {
                              return ListView.builder(
                                itemCount: dValue.filteredeventList.isNotEmpty
                                ?dValue.filteredeventList.length
                                    :dValue.eventList.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var event=dValue.filteredeventList.isNotEmpty
                                  ?dValue.filteredeventList[index]
                                      :dValue.eventList[index];
                                  return GestureDetector(
                                    onTap: () {
                                     callNext(context, EventDetailScreen(eventDetails: event, userId: userId,));
                                     // callNext(context, eventDetailWidget(eventDetails: event,));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: height / 4.5,
                                            width: width,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(event.eventImage),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 15.0),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: height / 7,
                                                    ),
                                                    Text(event.eventName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Colors.white,fontFamily: "playfair",
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.place_outlined,color: Colors.white,size: 20,),Text(
                                                          event.eventPlace,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: "benne",
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ] ),
                                            ),
                                          )],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
