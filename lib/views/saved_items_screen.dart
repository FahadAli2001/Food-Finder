import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodfinder/widgets/custom_saved_items_container.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Saved Items",
            style: TextStyle(
              color: Colors.white,
              //  fontWeight: FontWeight.bold
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              for (var i = 0; i < 4; i++) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: CustomSavedItemsContainer(),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
