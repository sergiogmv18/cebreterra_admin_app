
import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/category/widget/category.dart';
import 'package:cebreterra/shared/models/model_category.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryebreterraScreen extends StatefulWidget {
  const CategoryebreterraScreen({super.key});
  @override
   CategoryebreterraScreenState createState() => CategoryebreterraScreenState();
}
class CategoryebreterraScreenState extends State<CategoryebreterraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        showButtonReturn: true,
        route: RoutesPath.home,
        title:'Categorias'
      ),
      backgroundColor: CustomColors.colorFront,
      floatingActionButton: IconButton(
        onPressed: ()async{
          Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.editOrRegisterCategory, (route) => false);
        }, 
        icon:const FaIcon(FontAwesomeIcons.circlePlus),
        color:  CustomColors.pantone5615,
        iconSize: 50,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future:ModelCategoryCebreterra().getAllCategories(),
          builder: (context, app){
            if(app.connectionState == ConnectionState.done){
              List? allCategories = app.data;
              if(allCategories != null && allCategories.isNotEmpty){
                return ListView.builder(
                  itemCount: allCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  FadeInUp(
                      duration: Duration(seconds: 1+index),
                      child:CategoryWidget(categoryWk: allCategories[index]),
                    );
                  },
                );    
              }
              return Text(
                'No se a registrado una categoria para los productos',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center, 
              );
            }
            return circularProgressIndicator(context);
          }
        ),
      ),
    );
  }
}

