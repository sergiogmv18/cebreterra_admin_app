
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/product/widget/delete_product.dart';
import 'package:cebreterra/shared/entities/product.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductWidget extends StatelessWidget{
  final ProductCebreterra product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child:Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FunctionsClass.borderRadius),
         // side: BorderSide(color:CustomColors.pantone5615, width: 2),
        ),
        color: CustomColors.tableColor2,
        child: SizedBox(
          width:MediaQuery.of(context).size.width,
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight:MediaQuery.of(context).size.width * 0.4, // Establece el alto máximo deseado
                ),
                width:MediaQuery.of(context).size.width * 0.4,
                child: ClipRRect(  
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(FunctionsClass.borderRadius), bottomLeft:  Radius.circular(FunctionsClass.borderRadius)),
                  child: Image.network(
                    'https://cebreterra.com/storade/product/${product.getPhotosPath()![0]}',
                    fit: BoxFit.fitWidth, 
                    filterQuality:FilterQuality.high, 
                    width: MediaQuery.of(context).size.width,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset('assets/images/loading.gif', 
                        fit: BoxFit.fitWidth, 
                        filterQuality:FilterQuality.high, 
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
              Container(
                width:Responsive.isTablet(context)? MediaQuery.of(context).size.width * 0.56: MediaQuery.of(context).size.width * 0.47,
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.getName()!,
                      style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineMedium!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold) : Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.getDescription()!,
                      style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineSmall!.copyWith(color: CustomColors.colorFront) : Theme.of(context).textTheme.titleSmall!.copyWith(color: CustomColors.colorFront),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text('ver mas',
                            style:Responsive.isTablet(context)? 
                             Theme.of(context).textTheme.headlineSmall!.copyWith( 
                                color: CustomColors.colorDark,
                                decorationColor: CustomColors.colorDark,
                                decorationThickness: 1.5,decoration: TextDecoration.underline
                            ) :
                            Theme.of(context).textTheme.titleMedium!.copyWith( 
                              color: CustomColors.colorDark,
                              decorationColor: CustomColors.colorDark,
                              decorationThickness: 1.5,decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: ()async{
                            Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.productDetails, (route) => false, arguments:product); 
                          },
                        ),
                        IconButton(
                          onPressed: ()async{
                           deleteProduct(context, productCebreterraWk:product);
                          },
                          icon: const FaIcon(FontAwesomeIcons.trash),
                          color: CustomColors.kSecondaryColor,
                          iconSize: 30,
                        ) 
                      ], 
                    )
                  ]
                ),
              ),
            ],
          )
        ),
      )
    ); 

  }
}