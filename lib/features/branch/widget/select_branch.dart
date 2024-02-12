import 'package:cebreterra/shared/models/model_branch.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/ui/button.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectBranch extends StatelessWidget {
  const SelectBranch({super.key});
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:Branch().getAll(),
        builder: (context, app){
         if(app.connectionState == ConnectionState.done){
            List? allBranch = app.data;
            if(allBranch != null && allBranch.isNotEmpty){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(allBranch.length, (index){
                 return  ButtonCustom(
                    onPressed:(){
                      
                    }, 
                    child: SvgPicture.asset(
                      'assets/images/${allBranch[index].getIso()}.svg',
                      width:MediaQuery.of(context).size.width * 0.4,
                    ),
                  );
                },
              )
            );
          }
          return Text(
            'No se a podido cargar los datos',
            style: Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          
          );
        }
        return circularProgressIndicator(context);
      }
    );
  }
}