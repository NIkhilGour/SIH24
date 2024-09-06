import 'package:flutter/material.dart';

class ForgetPasswordBtn extends StatelessWidget {
  const ForgetPasswordBtn(
      {super.key,
      required this.buttonicon,
      required this.subtile,
      required this.title,
      required this.onTap
      });

  final IconData buttonicon;
  final String title, subtile;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
        child: Row(children: [
          Icon(
            buttonicon,
            size: 60,
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w900)),
              Text(
                subtile,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ],
          )
        ]),
      ),
    );
  }
}
