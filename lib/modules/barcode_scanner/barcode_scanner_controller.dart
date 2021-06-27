import 'package:bills_checking/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class BarcodeScannerController {

    // final tipo const no js, só instancia uma vez;

// gerencia de estado para a classe com ValueNotifier para alterações aqui para a view
// sem necessitar de setState
  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(BarcodeScannerStatus());  

  BarcodeScannerStatus get status => statusNotifier.value;

  set status(BarcodeScannerStatus status) => statusNotifier.value = status;

  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  // funções blackBox

   void getAvailableCameras() async {
     try {
        final response = await availableCameras();
        // checar disponibilidade da câmera de trás
        // pode ter mais de uma câmera na traseira ou frontal
        final camera = response.firstWhere(
          (element) => element.lensDirection == CameraLensDirection.back
        );

        final cameraController = CameraController(
          camera,
          ResolutionPreset.max,
          enableAudio: false
        );

        await cameraController.initialize();

        status = BarcodeScannerStatus.available(cameraController);
        scanWithCamera();
     
     } catch (err) {

       status = BarcodeScannerStatus.error(err.toString());
       print(err);
     }
   }

   void scanWithCamera() {
     Future.delayed(const Duration(seconds: 3)).then((value) => (value) {
      

       if (status.cameraController != null && status.cameraController!.value.isStreamingImages) {
         status.cameraController!.stopImageStream();
       }

       status = BarcodeScannerStatus.error("Timeout de leitura de boleto!");

     }
    );
    listenStreamingCamera();
   }

   Future<void> scannerBarCode(InputImage inputImage) async {

     try {

       if(status.cameraController != null) {

         if (status.cameraController!.value.isStreamingImages) {
           status.cameraController!.stopImageStream();
         }
         
       }

       final barcodes = await barcodeScanner.processImage(inputImage);
       var barcode;

       for (Barcode item in barcodes) {
         barcode = item.value.displayValue;
       }

       if (barcode != null && status.barcode.isEmpty) {
        status = BarcodeScannerStatus.barcode(barcode);
        
        if (status.cameraController != null) {
           status.cameraController!.dispose(); // fechar a câmera
        }
       
        return;
       }

       getAvailableCameras();

     } catch(err){
         print("erro na leitura $err");
     }
    
   }

   void scanWithImagePicker() async {
     await status.cameraController!.stopImageStream();
     final response = await ImagePicker().getImage(source: ImageSource.gallery);
     final inputImage = InputImage.fromFilePath(response!.path);

     scannerBarCode(inputImage);
   }

   void listenStreamingCamera() {

     if (status.cameraController == null) {return;}

     if (status.cameraController!.value.isStreamingImages == false) {

        status.cameraController!.startImageStream((cameraImage) async {

          try {

            final WriteBuffer allBytes = WriteBuffer();

            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            
            final bytes = allBytes.done().buffer.asUint8List();

            final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

            const InputImageRotation imageRotation = InputImageRotation.Rotation_0deg;

            final InputImageFormat inputImageFormat =
                InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.NV21;

            final planeData = cameraImage.planes.map(
              (Plane plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );

            final inputImageCamera = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
            await Future.delayed(const Duration(seconds: 3)); // delay de abrir a camera
            await scannerBarCode(inputImageCamera);

          } catch(err) {
            print(err);
          }
        });

     }

  }

  void dispose() {
    statusNotifier.dispose();
    barcodeScanner.close();
    if (status.showCamera) {
      status.cameraController!.dispose();
    }
  }
}