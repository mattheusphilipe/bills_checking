import 'package:bills_checking/modules/home/home_controller.dart';
import 'package:bills_checking/shared/themes/app_text_styles.dart';
import 'package:bills_checking/shared/themes/appcolors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final homeController = HomeController();
  final pages = [
    Container(
      color: Colors.red
    ),
    Container(
      color: Colors.blue
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: Container(
          height: 152,
          color: AppColors.primary,
          child: Center(
            child: ListTile(
              title: Text.rich( //Texto em variações na mesma linha
                TextSpan(text: "Olá", style: TextStyles.titleRegular,
                children: [
                  TextSpan(text: " Matheus", style: TextStyles.titleBoldBackground),
                ]
              ), style: TextStyles.titleRegular),
              subtitle: Text("Mantenha suas contas em dia.", style: TextStyles.captionShape),
              trailing: Container(//final do componente
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),  
                 ),
              ), 
            ),
          ),
        ),
      ),
      body: pages[homeController.currentPage],
      bottomNavigationBar: Container(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(onPressed: () {
              homeController.setPage(0);
              setState(() {
                
              });
            },
             icon: const Icon(Icons.home),
             color: AppColors.primary
             ),
            GestureDetector (
              onTap: () {
               // não entendi
              },
              child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(5)
              ),
              child: IconButton(onPressed: () {
                 Navigator.pushNamed(context, "/barcode_scanner");
              },
               icon: const Icon(
                 Icons.add_box_outlined),
                 color: AppColors.body
              ),
             ),
            ),
            IconButton(onPressed: () {},
             icon:  const Icon(Icons.description_outlined),
             color: AppColors.body
             ),
          ],
        ),
      ),
    );
  }
}