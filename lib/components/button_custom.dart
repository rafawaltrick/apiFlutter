import 'package:flutter/material.dart';

class ButtomCustom extends StatefulWidget {
  final String title;
  final VoidCallback function;
  final double width;
  final double height;
  final Color color;

  const ButtomCustom(
      {super.key,
      required this.title,
      required this.function,
      this.width = 110,
      this.height = 40,
      this.color = Colors.blue});

  @override
  _ButtonCustom createState() => _ButtonCustom();
}

class _ButtonCustom extends State<ButtomCustom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: widget.color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.all(10.0),
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: Size(widget.width, widget.height),
                maximumSize: Size(widget.width, widget.height),
                elevation: 5.0,
                shadowColor: Colors.black,
                side: const BorderSide(
                  color: Colors.transparent,
                )),
            onPressed: widget.function,
            child: Text(widget.title)));
  }
}
