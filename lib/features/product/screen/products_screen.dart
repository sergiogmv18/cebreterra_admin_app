import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/product/widget/product.dart';
import 'package:cebreterra/shared/models/products.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
   ProductsScreenState createState() => ProductsScreenState();
}
class ProductsScreenState extends State<ProductsScreen> {
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
        title:'Productos',
      ),
      backgroundColor: CustomColors.colorFront,
      floatingActionButton: IconButton(
        onPressed: ()async{
          Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.registerOrEditProduct, (route) => false);    
        }, 
        icon:const FaIcon(FontAwesomeIcons.circlePlus),
        color:  CustomColors.pantone5615,
        iconSize:Responsive.isTablet(context) ? 70: 50,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.topCenter,
        child:Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future:Product().getAllProduct(),
              builder: (context, app){
                if(app.connectionState == ConnectionState.done){
                  List? allProduct = app.data;
                  if(allProduct != null && allProduct.isNotEmpty){
                    return Column(
                      children:List.generate(allProduct.length, (index){
                        return  FadeInUp(
                          duration: Duration(seconds: 1+index),
                          child:ProductWidget(product: allProduct[index]),
                        );
                      })
                    );
                  }
                  return Text(
                    'No se a registrado un Producto',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  
                  );
                }
                return circularProgressIndicator(context);
              }
            ),
          ) 
        ),
      ),
    );
  }

 
}


