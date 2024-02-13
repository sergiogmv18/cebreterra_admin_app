
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/product/widget/delete_product.dart';
import 'package:cebreterra/shared/entities/product.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:cebreterra/utils/ui/text_button.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductCebreterra productWk;
  const ProductDetailsScreen({super.key, required this.productWk});
  @override
   ProductDetailsScreenState createState() => ProductDetailsScreenState();
}
class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductCebreterra productWk = ProductCebreterra();
    int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    productWk = widget.productWk;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        showButtonReturn: true,
        route: RoutesPath.product,
        title:productWk.getName(),
      ),
      backgroundColor: CustomColors.colorFront,
      body: Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StatefulBuilder(builder:(BuildContext context, StateSetter setState) {
                return ZoomIn(
                  child: Column(
                  children: [
                    CarouselSlider(
                      items:productWk.getPhotosPath()!.map((item) => Image.network(
                        'https://cebreterra.com/storade/product/$item',
                        filterQuality: FilterQuality.high, 
                        fit: BoxFit.cover, 
                        width:MediaQuery.of(context).size.width * 0.9, 
                        height: MediaQuery.of(context).size.height * 0.3,
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
                      )).toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height * 0.3,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: productWk.getPhotosPath()!.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 18.0,
                              height: 18.0,
                              margin:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black).withOpacity(_current == entry.key ? 0.9 : 0.4)
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                );
              }),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:Column(
                  children: [
// NAME PRODUCT
                    FadeInLeft(
                      child:Text(
                        productWk.getName()!, 
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      )
                    ),
                    const SizedBox(height: 10),
// DESCRIPTION PRODUCT
                    FadeInLeft(
                      child:Text(
                        productWk.getDescription()!, 
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      )
                    ),
// DIMENSIONES       
                    FlipInX(
                      delay: const Duration(milliseconds: 700),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
// CATEGORIES
                            if(productWk.getCategoryId() != null)...[
                              TextSpan(
                                text: "Categoria:",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
/*
                              WidgetSpan(
                                child: FutureBuilder(
                                  future:CategoryCebreterraController().getSpecificCategory(productWk.getCategoryId()!),
                                  builder: (context, app){
                                    if(app.connectionState == ConnectionState.done){
                                      CategoryCebreterra? category = app.data;
                                      if(category != null){
                                        return  Text(
                                          category.getName()!,
                                          style: Theme.of(context).textTheme.titleMedium,
                                        );
                                      }
                                      return Text(
                                        'No definida',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      );
                                  }
                                  return circularProgressIndicator(context);
                                  }
                                ),
                              ),
                              */
                              const TextSpan(
                                text: "\n",
                              )
                            ],
// HEIGHT 
                            if(productWk.getHeight() != null && productWk.getHeight()!.isNotEmpty && productWk.getHeight() != '0')...[
                              TextSpan(
                                text: "Altura:",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "${productWk.getHeight()}cm \n",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
// WIDTH                     
                            if(productWk.getWidth() != null && productWk.getWidth()!.isNotEmpty && productWk.getWidth() != '0')...[
                              TextSpan(
                                text: "Largura:",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "${productWk.getWidth()}cm \n",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
// WEIGHT        
                            if(productWk.getWeight() != null && productWk.getWeight()!.isNotEmpty && productWk.getWeight() != '0')...[
                              TextSpan(
                                text: "Peso:",
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: "${productWk.getWeight()}kg  \n",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ] 
                          ],
                        ),
                      ),
                      )
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 700),
                      child: Text(
                        '€${productWk.getPrice()}',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: CustomColors.activeButtonColor),
                      )
                    ),
                  ],
                ),
              ),   
              const SizedBox(height:20),
// ACTIONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButtonCustom(
                    title: 'Editar',
                    onPressed: () {
                    },
                    textColor: CustomColors.colorFront,
                    backgroundColor: CustomColors.activeButtonColor   
                  ),
                  TextButtonCustom(
                    title: 'Eliminar',
                    onPressed: () {
                       deleteProduct(context, productCebreterraWk:productWk);
                    },
                    textColor: CustomColors.colorFront,
                    backgroundColor: CustomColors.cancelActionButtonColor   
                  ),
                ],
              ) 
            ],
          ),
        ),
      ),
    );
  }
}