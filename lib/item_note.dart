import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: 170, // Set the desired width
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // You can change the color
                    width: 1.0, // You can change the width
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    Text("Name"),
                  ],
                ),
              ),
            ),
          ),

          Flexible(
            child: SizedBox(
              width: 170, // Set the desired width
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // You can change the color
                    width: 1.0, // You can change the width
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    Text("Parent's Telephone"),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: 170, // Set the desired width
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // You can change the color
                    width: 1.0, // You can change the width
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Column(
                  children: [
                    Text("Address"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
