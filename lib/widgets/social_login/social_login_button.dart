import 'package:bills_checking/shared/themes/app_images.dart';
import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({ Key? key, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color:AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: Border.fromBorderSide(
            BorderSide(
              color: AppColors.stroke
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded( 
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.google),
                  const SizedBox(width: 16),
                  Container(height: 56, width: 1, color: AppColors.stroke,)
                ],
              ),
            ),
            Expanded(
              flex: 4, 
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Text("Entrar com Google", style: TextStyles.buttonGray,),
                ],
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      )
    );
  }
}