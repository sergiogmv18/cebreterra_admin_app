import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/branch/widget/body.dart';
import 'package:cebreterra/features/home/widget/body.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
   HomeScreenState createState() => HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop : false,
      onPopInvoked: (v) => FunctionsClass().onWillPop(context,backToScreen: false, routeName: RoutesPath.home),
      child: Scaffold(
        appBar:AppBarCustom(
          showButtonReturn: false,
          title:'inicio',
        ),
        backgroundColor: CustomColors.colorFront,
        body: Container(
          alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child:Text(
                  "Administrador Cebreterra",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign:TextAlign.center,
                ),
              ),
             const BranchBody(),
            const SizedBox(height: 30),
            const HommeBody(),
          ],
        ),
      ),
        )
    );
  }


}
