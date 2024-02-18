
import 'package:cebreterra/config/route.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/features/contact/widget/detail_comment.dart';
import 'package:cebreterra/shared/entities/contact.dart';
import 'package:cebreterra/shared/models/model_contact.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/helpers/functions_class.dart';
import 'package:cebreterra/utils/ui/circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Comment extends StatelessWidget{
  final ContactCebreterra contactWk;
  const Comment({super.key, required this.contactWk});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4.0, // Elevación del Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(FunctionsClass.borderRadius), 
      ),
      color: CustomColors.tableColor2,
      child:Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        transformAlignment: Alignment.center,
        width:MediaQuery.of(context).size.width,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text:contactWk.getComments() ?? 'Comentario',
                    style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineSmall!.copyWith(color: CustomColors.colorFront) : Theme.of(context).textTheme.titleMedium!.copyWith(color: CustomColors.colorFront),
                  ),
                ]
              ),
              textAlign: TextAlign.start,
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
                    showDetailsOfDoubts(context, contactWk);
                  },
                ),
                IconButton(
                  onPressed: ()async{
                  showCircularLoadingDialog(context);
                    await Contact().deleteSpecificContact(contactWk);
                    Navigator.of(context).pushNamedAndRemoveUntil(RoutesPath.contact, (route) => false);
                  },
                  icon: const FaIcon(FontAwesomeIcons.trash),
                  color: CustomColors.kSecondaryColor,
                  iconSize: 30,
                ) 
              ], 
            )
          ],
        )
      ),
    );

  }
}