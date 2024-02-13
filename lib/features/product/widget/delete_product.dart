
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/entities/product.dart';
import 'package:cebreterra/shared/models/products.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/ui/alert.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:cebreterra/utils/ui/text_button.dart';
import 'package:flutter/material.dart';

class DeleteProduct extends StatelessWidget{
  final ProductCebreterra product;
  const DeleteProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialogCustom(
      title:'Atencion',
      content:Text(
        'Desea eliminar este producto?',
        style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineSmall! : Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButtonCustom(
          title: 'No',
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: CustomColors.colorFront,
          backgroundColor: CustomColors.activeButtonColor 
        ),
        TextButtonCustom(
          title: 'Si',
          onPressed: ()async {
            showCircularLoadingDialog(context);
            Map<String, dynamic>response = await Product().deleteProduct(product);
            if(response['success'] == false){
              Navigator.of(context).pop();
              showMessageErrorServer(context, 
                errorServer:response['errorCode'], 
                onPressed:(){
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              );
              return;
            }
            Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.product, (route) => false);
          },
          backgroundColor: CustomColors.cancelActionButtonColor ,
          textColor: CustomColors.colorFront,
        )
      ],
    );
  }
}

/*
 * Delete Product
 * @author  SGV             - 20231019
 * @version 1.0             - 20231019 - initial release                                             
 * @return  <ProductCebreterra>  product to deleted 
*/
deleteProduct(BuildContext context, {required ProductCebreterra productCebreterraWk})async{
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return DeleteProduct(product: productCebreterraWk);
    }
  );
}