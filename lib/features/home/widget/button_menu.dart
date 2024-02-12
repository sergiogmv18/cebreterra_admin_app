import 'package:auto_size_text/auto_size_text.dart';
import 'package:cebreterra/config/style.dart';
import 'package:cebreterra/shared/models/responsive.dart';
import 'package:cebreterra/utils/ui/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonMenu extends StatelessWidget {
  final String? route;
  final String? title;
  final IconData? icon;
  const ButtonMenu({super.key, this.icon, this.route, this.title});
  
  @override
  Widget build(BuildContext context) {
    return ButtonCustom(
      backgroundColor: CustomColors.pantone5615,
      onPressed:(){
          Navigator.of(context).pushNamedAndRemoveUntil(route!, (route) => false);        
      }, 
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width:MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            FaIcon(
              icon, 
              color: CustomColors.colorFront
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 10 : 20,
            ),
            AutoSizeText(
              title!,
              maxLines: 1,
              style: Responsive.isMobile(context) ? Theme.of(context).textTheme.titleMedium!.copyWith(color:CustomColors.colorFront ) : Theme.of(context).textTheme.titleLarge!.copyWith(color: CustomColors.colorFront),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
