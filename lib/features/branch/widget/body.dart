import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/branch/controller/branch_controller.dart';
import 'package:cebreterra/features/branch/widget/select_branch.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BranchBody extends StatelessWidget {
  const BranchBody({super.key});
  
  @override
  Widget build(BuildContext context) {
    var selectionModel = Provider.of<BranchController>(context);
    return FadeInUp(
      duration: const Duration(milliseconds: 2000),
      child:Column(
        children: [
          if(selectionModel.selectedBranch != null)...[
            Row(
              children: [
                Text(
                  "sucursal ${selectionModel.selectedBranch!.getCountry()} seleccionada",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.activeButtonColor),
                  textAlign:TextAlign.center,
                ),
              ],
            )  
          ],
          SizedBox(
            height: Responsive.isMobile(context) ? 10 : 20,
          ),
          Text(
            "Seleccione sucursal",
            style:Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium : Theme.of(context).textTheme.titleLarge,
            textAlign:TextAlign.center,
          ),  
          const SelectBranch(),
        ],
      ) 
    );
  }
}