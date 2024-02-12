import 'package:cebreterra/features/home/widget/button_menu.dart';
import 'package:cebreterra/shared/models/button_menu.dart';
import 'package:flutter/material.dart';

class HommeBody extends StatelessWidget {
  const HommeBody({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Wrap(
          alignment:WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment:WrapCrossAlignment.center,
          runSpacing: 10,
          spacing: 10,
          children:List.generate(ModelButtonMenu.getAllButtonMenu().length, (index){
           return ButtonMenu(
              icon:ModelButtonMenu.getAllButtonMenu()[index].icon,
              title:ModelButtonMenu.getAllButtonMenu()[index].title,
              route:ModelButtonMenu.getAllButtonMenu()[index].route,
            );
          })
        )
      ) 
    );
  }
}
  
  
  
 