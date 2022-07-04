import 'package:flutter/material.dart';

class TapToPlayButton extends StatelessWidget {
  const TapToPlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 130,
        width: 120,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white)),
          child: Column(
            children: const [
              Icon(
                Icons.play_arrow,
                size: 80.0,
                color: Colors.white,
              ),
              Text(
                "Tap to Play",
                style: TextStyle(
                    color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}
