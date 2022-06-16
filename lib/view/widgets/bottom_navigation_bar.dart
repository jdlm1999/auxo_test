import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.purple,
      child: SizedBox(
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: const Icon(
                  Icons.travel_explore,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (Route<dynamic> route) => false);
                }),
            IconButton(
                icon: const Icon(Icons.airplane_ticket, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/air', (Route<dynamic> route) => false);
                }),
          ],
        ),
      ),
    );
  }
}
