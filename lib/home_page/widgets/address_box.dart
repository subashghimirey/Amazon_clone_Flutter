import 'package:flutter/material.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 114, 226, 221),
            Color.fromARGB(255, 162, 236, 233),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(left: 8),
      child: const Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 25,
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Delivery to User - ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8, top: 2),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              size: 25,
            ),
          )
        ],
      ),
    );
  }
}
