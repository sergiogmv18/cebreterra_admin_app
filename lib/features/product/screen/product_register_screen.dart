import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/entities/category.dart';
import 'package:cebreterra/shared/entities/product.dart';
import 'package:cebreterra/shared/models/model_category.dart';
import 'package:cebreterra/shared/models/products.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/alert.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/button.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:cebreterra/utils/ui/text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterOrEditProduct extends StatefulWidget {
  final ProductCebreterra? productCebreterraWk ;
  const RegisterOrEditProduct({super.key,  this.productCebreterraWk});
  @override
   RegisterOrEditProductState createState() => RegisterOrEditProductState();
}
class RegisterOrEditProductState extends State<RegisterOrEditProduct> {
  ProductCebreterra productCebreterraWk = ProductCebreterra();
  bool edit = false;
  bool showProccessLoad = true;
  final formKey = GlobalKey<FormState>();
  List<CategoryCebreterra>? allCategories = [];
  CategoryCebreterra? categoryCebreterraSelected;
  List allPhotos = [];
    @override
  void initState() {
    initialSetup();
    super.initState();
  }

  /*
  * Initial setup
  * @author  SGV
  * @version 1.0 - 20211210 - initial release
  * @return  void
  */
  Future<void> initialSetup() async {
    if(widget.productCebreterraWk != null){
      productCebreterraWk = widget.productCebreterraWk!;
      edit = true;
    }
    allCategories = await ModelCategoryCebreterra().getAllCategories();
    setState(() {
      showProccessLoad = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.colorFront,
      appBar: AppBarCustom(
        showButtonReturn: true,
        route: RoutesPath.product,
        title:edit ?productCebreterraWk.getName() :'Registrar nuevo producto'
      ),
      body:showProccessLoad? circularProgressIndicator(context): Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
// NAME 
                    TextFormFieldCustom(
                      initialValue: productCebreterraWk.getName() ?? '',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      labelText:'Nombre',
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please insert a valid value';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        if (text.trim().isEmpty) {
                          productCebreterraWk.setName(null);
                        } else {
                          productCebreterraWk.setName(text);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
// DESCRIPTION
                    TextFormFieldCustom(
                      initialValue: productCebreterraWk.getDescription() ?? '',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                      labelText:'Descipción',
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please insert a valid value';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        if (text.trim().isEmpty) {
                          productCebreterraWk.setDescription(null);
                        } else {
                          productCebreterraWk.setDescription(text);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
// Categories
                    if(allCategories != null && allCategories!.isNotEmpty)...[
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10), 
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          color: CustomColors.colorFront,
                            borderRadius: BorderRadius.circular(FunctionsClass.borderRadius), // Border radius de 20
                            border: Border.all(
                              color: CustomColors.colorDark, // Color del borde
                              width: 1.0, // Ancho del borde
                            ),
                          ),
                          child: DropdownButton<CategoryCebreterra>(
                            value:categoryCebreterraSelected ?? allCategories![0],
                            underline: Container(),
                            onChanged: (CategoryCebreterra? newValue) {
                              if(newValue != null){
                                setState(() {
                                  categoryCebreterraSelected = newValue;
                                  productCebreterraWk.setCategoryId(newValue.getServerId()); 
                                });
                              }
                            },
                            items:allCategories!.map<DropdownMenuItem<CategoryCebreterra>>((CategoryCebreterra value) {
                              return DropdownMenuItem<CategoryCebreterra>(
                                value: value,
                                child: SizedBox(
                                  width:MediaQuery.of(context).size.width * 0.76,
                                  child: Text(
                                    value.getName()!,
                                    style:  Theme.of(context).textTheme.titleMedium,
                                    textAlign: TextAlign.start
                                  )
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
// PRICE
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        initialValue: productCebreterraWk.getPrice() ?? '',
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        labelText:'precio',
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please insert a valid value';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (text.trim().isEmpty) {
                            productCebreterraWk.setPrice(null);
                          } else {
                            productCebreterraWk.setPrice(text);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        initialValue: productCebreterraWk.getHeight() ?? '',
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        labelText:'altura',
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please insert a valid value';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (text.trim().isEmpty) {
                            productCebreterraWk.setheigh(null);
                          } else {
                            productCebreterraWk.setheigh(text);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        initialValue: productCebreterraWk.getWidth() ?? '',
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        labelText:'anchura',
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please insert a valid value';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (text.trim().isEmpty) {
                            productCebreterraWk.setWidth(null);
                          } else {
                            productCebreterraWk.setWidth(text);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        initialValue: productCebreterraWk.getWeight() ?? '',
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        labelText:'Peso',
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return 'please insert a valid value';
                          }
                          return null;
                        },
                        onChanged: (text) {
                          if (text.trim().isEmpty) {
                            productCebreterraWk.setWeight(null);
                          } else {
                            productCebreterraWk.setWeight(text);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        onPressed: () async{
                          List? photos = await FunctionsClass().addFilesPicker(context, returnValue: true,allowMultiple: true);
                          if(photos != null && photos.isNotEmpty){
                            if(allPhotos.isNotEmpty){
                              for(Map specificPhoto in photos){
                                bool isAlreadySaved = Product.checkAndSave(base64String:specificPhoto['base64String'], list:allPhotos);
                                  if(!isAlreadySaved){
                                    String generatedNamePhoto = FunctionsClass().generateRandomNumber(); 
                                    specificPhoto['nameFile'] = generatedNamePhoto;
                                    setState(() {
                                      allPhotos.add({'nameFile':specificPhoto['nameFile'],'extension':specificPhoto['extension'], 'imgBase64':specificPhoto['base64String']},);
                              //  imgBase64 = photos[0]['base64String'];
                              //  extension = photos[0]['extension'];
                              //  dataOfImg = photos[0];
                              //  showBase64 = true;
                                    });
                                  }  
                                }
                              }else{
                                for(Map specificPhoto in photos){
                                  String generatedNamePhoto = FunctionsClass().generateRandomNumber(); 
                                  specificPhoto['nameFile'] = generatedNamePhoto;
                                  setState(() {
                                   allPhotos.add({ 'nameFile':specificPhoto['nameFile'],'extension':specificPhoto['extension'],'imgBase64':specificPhoto['base64String']});
                                //  imgBase64 = photos[0]['base64String'];
                                //  extension = photos[0]['extension'];
                                //  dataOfImg = photos[0];
                                //  showBase64 = true;
                                  });
                                }
                              }   
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.camera),
                          color: CustomColors.activeButtonColor,
                          iconSize: 40,
                        ),
                        Container(
                          height:allPhotos.isEmpty ? 0 : 200,
                          child: SingleChildScrollView(
                            scrollDirection:Axis.horizontal,
                            child: Row(
                              children: [
                                for(int photo = 0; photo < allPhotos.length; photo ++)...[
                                  Container(
                                   padding: const EdgeInsets.only(left: 10, right: 10),
                                    child:Column(
                                      children: [
                                        Image.memory(
                                          showContainerImg(allPhotos[photo]['imgBase64']),
                                          height: 140,
                                          fit: BoxFit.fitHeight, 
                                        ),
                                        IconButton(
                                        onPressed: () async{
                                          setState(() {
                                             allPhotos.removeAt(photo);
                                          });
                                        },
                                        icon: const FaIcon(FontAwesomeIcons.trash),
                                        color: CustomColors.cancelActionButtonColor,
                                        iconSize: 40,
                                      ),
                                      ],
                                    ) 
                                  )
                                ]
                              ]
                            ),
                          ),
                        ),


                        if(allPhotos.isNotEmpty)...[
                          if(edit)...[

                          ]else...[
                         
                          ]

                        ],
                        const SizedBox(height: 20),
                        FadeInUp(
                          child:ButtonCustom(
                          backgroundColor: CustomColors.activeButtonColor,
                          onPressed: () async{
                            if (formKey.currentState!.validate() && allPhotos.isNotEmpty) {
                              productCebreterraWk.setPhotosPath(allPhotos);
                              showCircularLoadingDialog(context);
                              Map<String, dynamic>response = await Product().registerOrEditProducts(productCebreterraWk);
                              if(response['success'] == false && response['error'] != 303){
                                Navigator.of(context).pop();
                                showMessageErrorServer(context, 
                                  errorServer:response['error'], 
                                  onPressed:(){
                                    Navigator.of(context).pop();
                                  }
                                );
                                return;
                              }
                                Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.product, (route) => false);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: AutoSizeText(
                              edit ? 'Guardar cambios':'Guardar nuevo Producto',
                              maxLines: 1,
                              style: Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium!.copyWith(color:CustomColors.colorFront ) : Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.colorFront),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ) 
            ),        
          ),
        ),
      );
    }

/*
 * Convert base64 to bytes and return or value for show imagen of event
 * @author  SGV             - 20231019
 * @version 1.0             - 20231019 - initial release
 * @param   <String>  - img  - image in format base64                                               
 * @return  <widget>  widget 
 */
  showContainerImg(String img){
    Uint8List bytes = base64Decode(img);
    return bytes;
  }
  }
