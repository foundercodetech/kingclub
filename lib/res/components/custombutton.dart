import 'package:flutter/material.dart';



class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.btnColor = Colors.red,
    this.textColor = Colors.white,
    this.border,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final BoxBorder? border;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Ink(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              25,
            ),
          ),
          child: Container(
            width: 180,
            height: 50,
            decoration: BoxDecoration(
              color: widget.btnColor,
              borderRadius: BorderRadius.circular(
                10,
              ),
              border: widget.border,
            ),
            child: Center(
              child: Text(
                  widget.text,style: TextStyle(color:Colors.white),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
