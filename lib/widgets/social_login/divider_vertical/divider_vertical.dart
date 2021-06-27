import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:flutter/material.dart';

class DividerVertical extends StatelessWidget {
  const DividerVertical({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: double.maxFinite,
      color: AppColors.stroke,
      child: null,
    );
  }
}