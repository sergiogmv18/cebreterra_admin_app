

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cebreterra/config/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBarCustom extends PreferredSize {
  final bool? showButtonReturn;
  final String? route;
  final Object? arguments;
  final String? title;
   AppBarCustom({super.key, this.showButtonReturn = false, this.route, this.arguments, this.title}): super(preferredSize: const Size(100, 200), child: Container());
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize:const Size(100, 200),
      child:ClipPath(
        clipper: WaveClipperTwo(flip: true),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          constraints:const BoxConstraints(maxHeight: 300),
          padding: const EdgeInsets.only(bottom: 30),
          color: CustomColors.tableColor2,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: showButtonReturn == true ? IconButton(
                  onPressed: ()async{
                    Navigator.of(context).pushNamedAndRemoveUntil(route!, (route) => false,arguments:arguments);
                  },
                  icon: const FaIcon(FontAwesomeIcons.circleArrowLeft),
                  color: CustomColors.pantone720,
                  iconSize: 30,
                ): Container()
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/banner.png', height: MediaQuery.of(context).size.height * 0.12),
                      AutoSizeText(
                        title.toString().toUpperCase(),
                        maxLines: 1,
                        style:Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Container(),
                ),
              ],
            )
          ),
        ),
      );
  }
}