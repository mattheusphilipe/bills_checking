import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:bills_checking/widgets/social_login/set_label_buttons/set_label_buttons.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({ Key? key,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.primaryOnPressed,
    required this.secondaryOnPressed, 
    required this.title, 
    required this.subtitle
   }
  ) : super(key: key);

  final String primaryLabel;
  final String secondaryLabel;

  final String title;
  final String subtitle;

  final VoidCallback primaryOnPressed;
  final VoidCallback secondaryOnPressed;

  @override
  Widget build(BuildContext context) {
      return SafeArea(
        child: RotatedBox(
          quarterTurns: 1,
          child: Material( 
            child:  Container(
              color: AppColors.shape,
              child: Column(
                children: [
                  Expanded(child: Container(color: Colors.black.withOpacity(0.6),)),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Text.rich(
                          TextSpan(text: title, 
                          style: TextStyles.buttonBoldHeading,
                          children: [
                            TextSpan(text: "\n$subtitle",
                            style: TextStyles.buttonHeading,
                            )
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(height: 1, color: AppColors.stroke,),
                      SetLabelButtons(
                        enablePrimaryColor: true,
                        primaryLabel: primaryLabel, 
                        primaryOnPressed: () {  },
                        secondaryLabel: secondaryLabel,
                        secondaryOnPressed: () {  },
                      )
                    ],
                  ),
                ],
              ),
            )
        ),
          ),
      );
       
  }
}