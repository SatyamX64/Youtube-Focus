import 'package:flutter/material.dart';

class CenteredMessage extends StatelessWidget {
  const CenteredMessage({required this.icon, required this.message, Key? key})
      : super(key: key);

  final IconData icon;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: 40,
            ),
            Text(
              message,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
