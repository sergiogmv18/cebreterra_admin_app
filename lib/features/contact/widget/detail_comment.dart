import 'package:animate_do/animate_do.dart';
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/entities/contact.dart';
import 'package:cebreterra/shared/models/model_contact.dart';
import 'package:cebreterra/utils/ui/alert.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';



class CommentDetails extends StatefulWidget {
  final ContactCebreterra contactWk;
  const CommentDetails({super.key,  required this.contactWk});
  @override
   CommentDetailsState createState() => CommentDetailsState();
}
class CommentDetailsState extends State<CommentDetails> {
  String? newStatus;
  @override
  void initState() {
    newStatus = widget.contactWk.getStatus()!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  text:widget.contactWk.getComments(),
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
                  text:widget.contactWk.getFullName(),
                  style:  Theme.of(context).textTheme.titleSmall!  
                
                ),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: 'Numero de Telefono: ',
                  style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
                  
                ),
                TextSpan(
                  text:widget.contactWk.getPhoneNumber(),
                  style: Theme.of(context).textTheme.titleSmall!  
                  
                ),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: 'Correo electronico:',
                  style:Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold) 
            
                ),
                TextSpan(
                  text:widget.contactWk.getEmail(),
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
          if(newStatus != widget.contactWk.getStatus())...[
            FadeInUp(
              child:ElevatedButton(
                onPressed: () async{
                  widget.contactWk.setStatus(newStatus);
                  showCircularLoadingDialog(context);
                  Map<String, dynamic>response = await Contact().registerOrEditContact(widget.contactWk);
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.colorFront, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]
        ]
      ), 
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
}

 showDetailsOfDoubts(BuildContext context, ContactCebreterra contactWk)async{
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return AlertDialogCustom(
            title:'Detalles',
            content: CommentDetails(contactWk:contactWk),
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















