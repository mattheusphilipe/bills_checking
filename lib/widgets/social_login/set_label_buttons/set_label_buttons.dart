import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:bills_checking/widgets/social_login/divider_vertical/divider_vertical.dart';
import 'package:bills_checking/widgets/social_login/label_button/label_button.dart';
import 'package:flutter/material.dart';

class SetLabelButtons extends StatelessWidget {
  SetLabelButtons({ 
      Key? key,  
      required this.primaryLabel,
      required this.secondaryLabel,
      required this.primaryOnPressed,
      required this.secondaryOnPressed,
      this.enablePrimaryColor = false
    }
  ) : super(key: key);

  final String primaryLabel;
  final String secondaryLabel;

  final bool enablePrimaryColor;


  final VoidCallback primaryOnPressed;
  final VoidCallback secondaryOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.shape,
        height: 56,
        child: Row(
          children: [
            Expanded(child: LabelButton(
                label: primaryLabel,
                onPressed: primaryOnPressed,
                style: enablePrimaryColor ? TextStyles.buttonPrimary: null
              )
            ),
            const DividerVertical(),
            Expanded(child: LabelButton(
              label: secondaryLabel,
               onPressed: secondaryOnPressed)
            ),
          ],
        ),
      );
  }
}