import 'package:flutter/material.dart';


class Circularbutton extends StatefulWidget {
  const Circularbutton({
    Key? key,

    this.btnColor = Colors.red,
    this.textColor = Colors.white,
    this.border,
  }) : super(key: key);

  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<Circularbutton> createState() => _CircularbuttonState();
}

class _CircularbuttonState extends State<Circularbutton> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(100),
              border: widget.border,
            ),
            child: Center(
                child: CircularProgressIndicator(color: Colors.white)
            ),
          ),
        ),
      ),
    );
  }
}