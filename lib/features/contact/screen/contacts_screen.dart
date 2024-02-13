import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/contact/controllers/contact_controller.dart';
import 'package:cebreterra/features/contact/widget/comment.dart';
import 'package:cebreterra/shared/entities/contact.dart';
import 'package:cebreterra/shared/models/model_contact.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/alert.dart';
import 'package:cebreterra/utils/ui/app_bar.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactCebreterraScreen extends StatefulWidget {
  const ContactCebreterraScreen({super.key});
  @override
   ContactCebreterraScreenState createState() => ContactCebreterraScreenState();
}
class ContactCebreterraScreenState extends State<ContactCebreterraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      var selectionModel = Provider.of<ContactController>(context);
      return PopScope(
      canPop : false,
      onPopInvoked: (v) => FunctionsClass().onWillPop(context,backToScreen: false, routeName: RoutesPath.home),
      child: Scaffold(
        appBar: AppBarCustom(
          showButtonReturn: true,
          route: RoutesPath.home,
          title:'Preguntas o Comentarios',
        ),
        backgroundColor: CustomColors.colorFront,
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
                const SizedBox(height: 20),
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
                  child: DropdownButton<String>(
                    value: selectionModel.searchStatus,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      if(newValue != null){
                        selectionModel.updateSelectedOption(newValue);  
                      }
                    },
                    items: Contact.allStatus().map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox(
                          width:MediaQuery.of(context).size.width * 0.76,
                          child: Text(
                            showTranslateOfStatus(value),
                            style:  Theme.of(context).textTheme.titleMedium,
                            textAlign: TextAlign.start
                          )
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: FutureBuilder(
                      future:selectionModel.searchStatus == Contact.allStatus()[0] ?Contact().getAll() : Contact().getAllContactForStatus(selectionModel.searchStatus),
                      builder: (context, app){
                        if(app.connectionState == ConnectionState.done){
                          List? allContacts = app.data;
                          if(allContacts != null && allContacts.isNotEmpty){
                            return Wrap(
                            // spacing: 20,
                              runSpacing: 20,
                              children:List.generate(allContacts.length, (index){
                                return  FadeInUp(
                                  duration: const Duration(milliseconds: 1500),
                                  child: Comment(contactWk:allContacts[index])
                                );
                            }
                          )
                        );
                      }
                      return Text(
                        'No hay dudas ni comentarios de los usuarios',
                        style: Theme.of(context).textTheme.titleMedium,
                      
                      );
                      }
                      return circularProgressIndicator(context);
                    }
                  ),
              
                  ) 
                ),
              ],
            ),
          ),
        )
      );
    }

  showTranslateOfStatus(String status){
    switch(status){
      case ContactCebreterra.statusAprovatedANDShow:
      return 'Aprovados y mostrados';
      case ContactCebreterra.statusCheck:
      return 'Respondido';
      case ContactCebreterra.statusPending:
      return 'Pendientes';
      default: 
      return 'Todos';
    }
  }


  showDetailsOfDoubts(ContactCebreterra doubts)async{
    // buscar personId dele
    String? newStatus = doubts.getStatus()!;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialogCustom(
            title:'Detalles',
            content:Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              transformAlignment: Alignment.center,
              //width:MediaQuery.of(context).size.width* 0.8,
              child:Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  SelectableText.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Comentario: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                          TextSpan(
                          text:doubts.getComments(),
                          style:Theme.of(context).textTheme.titleSmall!  
                          
                        ),
                        const TextSpan(text: '\n\n'),
                        TextSpan(
                          text: 'Datos de Usuario: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Nombre :',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        TextSpan(
                          text:doubts.getFullName(),
                          style:  Theme.of(context).textTheme.titleSmall!  
                        
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Numero de Telefono: ',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                          
                        ),
                        TextSpan(
                          text:doubts.getPhoneNumber(),
                          style: Theme.of(context).textTheme.titleSmall!  
                          
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(
                          text: 'Correo electronico:',
                          style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                    
                        ),
                        TextSpan(
                          text:doubts.getEmail(),
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                        )
                      ]
                    ),
                    textAlign: TextAlign.start,
                  ),
                  RadioListTile<String>(
                    title: Text(
                      showTranslateOfStatus(ContactCebreterra.statusAprovatedANDShow),
                      style:Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: ContactCebreterra.statusAprovatedANDShow,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(showTranslateOfStatus( ContactCebreterra.statusCheck),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value: ContactCebreterra.statusCheck,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title:Text(showTranslateOfStatus( ContactCebreterra.statusPending),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                    ),
                    value:ContactCebreterra.statusPending,
                    groupValue: newStatus,
                    onChanged: (value) {
                      setState(() {
                        newStatus = value;
                      });
                    },
                  ),
                  if(newStatus != doubts.getStatus())...[
                    FadeInUp(
                      child:ElevatedButton(
                        onPressed: () async{
                          doubts.setStatus(newStatus);
                          showCircularLoadingDialog(context);
                          Map<String, dynamic>response = await Contact().registerOrEditContact(doubts);
                          if(response['success'] == false){
                            Navigator.of(context).pop();
                            showMessageErrorServer(context,  errorServer:response['errorCode'],  onPressed:(){
                                Navigator.of(context).pop();
                              }
                            );
                            return;
                          }
                          Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.contact, (route) => false); 
                        },
                        style: ElevatedButton.styleFrom(  
                          elevation: 6,
                          backgroundColor: CustomColors.pantone5615,// Color de fondo blanco
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Border radius de 20
                          ),
                        ),
                        child:Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                          child: Text(
                            'SALVAR',
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ]
                ]
              ), 
            ),
            actions: [
              TextButton(
                onPressed:(){
                  Navigator.of(context).pop();
                }, 
                child:Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: CustomColors.activeButtonColor) 
                
                )
              )
            ],
          );
        });
      }
    );
  }

}
