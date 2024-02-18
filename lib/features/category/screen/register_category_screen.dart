import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/entities/category.dart';
import 'package:cebreterra/shared/models/model_category.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/alert.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/button.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:cebreterra/utils/ui/text_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterCategory extends StatefulWidget {
  final CategoryCebreterra? currentCategoryWK;
 const  RegisterCategory({super.key, this.currentCategoryWK});
  @override
  State<RegisterCategory> createState() => _RegisterCategoryState();
}
class _RegisterCategoryState extends State<RegisterCategory> {
  final formKey = GlobalKey<FormState>();
  CategoryCebreterra categoryWk = CategoryCebreterra();
  String? generatedNumber;
  String extension = '';
  String? imgBase64;
  bool showBase64 = false;
  Map? dataOfImg;
  String? oldNameFile;
  bool edit = false;
  @override
  void initState() {
    if(widget.currentCategoryWK != null){
      categoryWk = widget.currentCategoryWK!;
      oldNameFile = categoryWk.getPhotoPath();
      edit = true;
    }
    generatedNumber = FunctionsClass().generateRandomNumber(); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        showButtonReturn: true,
        route: RoutesPath.categories,
        title:edit ?'categoria (${categoryWk.getName()})' :'Registrar nueva categoria'
      ),
      backgroundColor: CustomColors.colorFront,
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child:Form(
            key: formKey,
            child: Column(
            children:[
              FadeInUp(
                duration:const Duration(milliseconds: 800),
                child: TextFormFieldCustom(
                  initialValue: categoryWk.getName() ?? '',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.name,
                  labelText:'Nombre de categoria',
                  validator: (text) {
                    if (text!.trim().isEmpty) {
                      return 'Por favor inserir un valor valido';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    if (text.trim().isEmpty) {
                      categoryWk.setName('');
                    } else {
                      categoryWk.setName(text);
                    }
                  },
                ),
              ),

  // SHOW SELECTED IMG 
              if(imgBase64 != null)...[
                FadeInUp(
                  duration:const Duration(milliseconds: 900),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 30),
                      if(showBase64)...[
                         ClipRRect(  
                          borderRadius:const BorderRadius.all(Radius.circular(FunctionsClass.borderRadius)),
                          child:Image.memory(
                            FunctionsClass.showContainerImg(imgBase64!), 
                            width:MediaQuery.of(context).size.width,   
                            fit: BoxFit.fitWidth, 
                          ),
                        ),
                      ]else...[
                        ClipRRect(  
                          borderRadius:const BorderRadius.all(Radius.circular(FunctionsClass.borderRadius)),
                          child: Image.network(
                            'https://cebreterra.com/storade/categories/${categoryWk.getPhotoPath()}',
                            filterQuality:FilterQuality.high, 
                            width:MediaQuery.of(context).size.width,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset(
                                'assets/images/loading.gif', 
                                width:MediaQuery.of(context).size.width,
                                filterQuality:FilterQuality.high,
                                fit: BoxFit.fitWidth, 
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
                    ],
                    IconButton(
                      iconSize: 30,
                      onPressed:(){
                        setState(() {
                          imgBase64 = null;
                          categoryWk.setPhotoPath(imgBase64);
                        }); 
                      }, 
                      icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
                    )
                  ],
                ),
              ),
            ]else...[
              if(categoryWk.getPhotoPath() != null)...[
                const SizedBox(height: 20),
                FadeInUp(
                  duration:const Duration(seconds:1 ),
                  child: ClipRRect(  
                    borderRadius:const BorderRadius.all(Radius.circular(FunctionsClass.borderRadius)),
                    child: Image.network(
                      'https://cebreterra.com/storade/categories/${categoryWk.getPhotoPath()!}',
                      filterQuality:FilterQuality.high, 
                      width:MediaQuery.of(context).size.width,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/loading.gif', 
                          width:MediaQuery.of(context).size.width,
                          filterQuality:FilterQuality.high,
                          fit: BoxFit.fitWidth, 
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
                IconButton(
                  iconSize: 30,
                  onPressed:(){
                    setState(() {
                      categoryWk.setPhotoPath(null);
                    });
                  }, 
                  icon: FaIcon(FontAwesomeIcons.trash, size: 30, color: CustomColors.cancelActionButtonColor)
                )
              ]
            ],
            const SizedBox(height: 20),
            FadeInUp(
              child:ButtonCustom(
                backgroundColor: CustomColors.activeButtonColor,
                onPressed: () async{
                  List? photos = await FunctionsClass().addFilesPicker(context, returnValue: true);
                  if(photos != null && photos.isNotEmpty){
                    setState(() {
                      imgBase64 = photos[0]['base64String'];
                      extension = photos[0]['extension'];
                      dataOfImg = photos[0];
                      dataOfImg!['nameFile'] = generatedNumber;
                      showBase64 = true;
                    });
                    categoryWk.setPhotoPath(imgBase64!);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.image, 
                        color: CustomColors.colorFront
                      ),
                      AutoSizeText(
                      'Adicionar imagen',
                        maxLines: 1,
                        style: Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium!.copyWith(color:CustomColors.colorFront ) : Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.colorFront),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              child:ButtonCustom(
              backgroundColor: CustomColors.activeButtonColor,
              onPressed: () async{
                if (formKey.currentState!.validate() && categoryWk.getPhotoPath() != null) {
                  showCircularLoadingDialog(context);
                  Map<String, dynamic>response = await ModelCategoryCebreterra().registerOrEditCategory(categoryWk, dataOfImg: dataOfImg, oldNameFile:oldNameFile);
                  if(response['success'] == false){
                    Navigator.of(context).pop();
                    showMessageErrorServer(context, 
                      errorServer:response['errorCode'], 
                      onPressed:(){
                        Navigator.of(context).pop();
                      }
                    );
                    return;
                  }
                  Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.categories, (route) => false);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: AutoSizeText(
                  edit ? 'Guardar cambios':'Guardar nueva categoria',
                  maxLines: 1,
                  style: Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium!.copyWith(color:CustomColors.colorFront ) : Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.colorFront),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      )
    ),
  )
  ),
);
  }
}