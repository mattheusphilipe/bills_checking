import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  String label = "";
  final VoidCallback onPressed;
  final TextStyle? style;

  LabelButton({ Key? key,
  required this.label,
  required this.onPressed,
  this.style }
  ) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: TextButton(
        onPressed: () {onPressed();},
        child: Text(label, 
        style: style ?? TextStyles.buttonHeading // se tem style, rederiza ele, se não o headind
        ),
      ),
    );
  }
}