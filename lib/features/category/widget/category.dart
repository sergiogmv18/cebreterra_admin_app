
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/entities/category.dart';
import 'package:cebreterra/shared/models/model_category.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryWidget extends StatelessWidget{
  final CategoryCebreterra categoryWk;
  const CategoryWidget({super.key, required this.categoryWk});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FunctionsClass.borderRadius), 
      ),
      color: CustomColors.tableColor2,
      child:Container(
        transformAlignment: Alignment.center,
        width:MediaQuery.of(context).size.width,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width:MediaQuery.of(context).size.width * 0.3,
              child: ClipRRect(  
                borderRadius:const BorderRadius.only(topLeft: Radius.circular(FunctionsClass.borderRadius), bottomLeft:  Radius.circular(FunctionsClass.borderRadius)),
                child: Image.network(
                  categoryWk.getPhotoPath() != null ? 'https://cebreterra.com/storade/categories/${categoryWk.getPhotoPath()}' : '',
                  width:MediaQuery.of(context).size.width,
                  height:MediaQuery.of(context).size.width * 0.3,
                  filterQuality:FilterQuality.high,
                  fit: BoxFit.cover, 
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/banner.png', 
                      width:MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.width * 0.3,
                      filterQuality:FilterQuality.high,
                      fit: BoxFit.cover, 
                    );
                  },
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: circularProgressIndicator(context),
                      );
                    }
                  }
                ),
              ),
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width * 0.57,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryWk.getName()!,
                    style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineMedium!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold) : Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('ver mas',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith( 
                            decorationColor: Colors.black,         // Color del subrayado
                            decorationThickness: 1.5,decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: ()async{
                          Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.editOrRegisterCategory, (route) => false, arguments:categoryWk); 
                        },
                      ),
                      IconButton(
                        onPressed: ()async{
                          showCircularLoadingDialog(context);
                          await ModelCategoryCebreterra().deleteSpecificCategory(categoryWk);
                          Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.categories, (route) => false);
                        },
                        icon: const FaIcon(FontAwesomeIcons.trash),
                        color: CustomColors.kSecondaryColor,
                        iconSize: 30,
                      ) 
                    ], 
                  ),
                ],
              )
            ),
          ],
        )
      ),
    );
  }
}