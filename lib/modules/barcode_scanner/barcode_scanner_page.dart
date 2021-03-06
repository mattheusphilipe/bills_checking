import 'package:bills_checking/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:bills_checking/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:bills_checking/shared/bottom_sheet/bottom_sheet_widget.dart';
import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:bills_checking/widgets/social_login/set_label_buttons/set_label_buttons.dart';
import 'package:flutter/material.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({ Key? key }) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  
 final controller = BarcodeScannerController();

 @override
 void initState() {
   controller.getAvailableCameras();
   controller.statusNotifier.addListener(() { 
    if (controller.status.hasBarcode) {
      Navigator.pushReplacementNamed(context, "/insert_boleto");
    }
  });

   super.initState();
 }

 @override
 void dispose() {

   controller.dispose();
   super.dispose();
 }
 
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
      child: Stack(
        children: [
          
          //escutar um valor
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status,__) {
              if (status.showCamera) {
                return Container(
                  child: status.cameraController!.buildPreview(),
                );
              } else if (status.hasError) {
                return BottomSheetWidget(
                  primaryLabel: 'Escanear novamente',
                  primaryOnPressed: () { 
                    controller.getAvailableCameras();
                   },
                  secondaryLabel: 'Digitar código', 
                  secondaryOnPressed: () {  }, 
                  subtitle: 'Tente escanear novamente ou digite o código do seu boleto.',
                  title: 'Não foi possível identificar um código de barras.',
                );
              }

              return Container();
            } 
          ),

          RotatedBox(
          quarterTurns: 1,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text("Escaneie o código de barras do boleto", style: TextStyles.buttonBackground),
              centerTitle: true,
              leading: BackButton(color: AppColors.background,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(color: Colors.black.withOpacity(0.6))
                ), 
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.transparent,)
                ),
                  Expanded(
                    child: Container(color: Colors.black.withOpacity(0.6))
                ),
              ],
            ),
            bottomNavigationBar: SetLabelButtons(
              primaryLabel: "Inserir código do boleto",
              secondaryLabel: "Adicionar da galeria",
              primaryOnPressed: () {},
              secondaryOnPressed: () {}
              )
            ),
        )
        ],
      ),
    ); 



    // return BottomSheetWidget(
    //   primaryLabel: 'Escanear novamente',
    //    primaryOnPressed: () {  },
    //     secondaryLabel: 'Digitar código', 
    //     secondaryOnPressed: () {  }, 
    //     subtitle: 'Tente escanear novamente ou digite o código do seu boleto.',
    //     title: 'Não foi possível identificar um código de barras.',
    // );
  }
}