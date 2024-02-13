import 'package:cebreterra/shared/models/responsive.dart';
import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color backgroundColor;
  final Color? textColor;
  const TextButtonCustom({super.key, required this.onPressed, required this.title, this.textColor, this.backgroundColor = Colors.transparent});
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Container(
        padding:EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Text(
          title,
          style: Responsive.isTablet(context)? Theme.of(context).textTheme.headlineSmall!.copyWith(color:textColor, fontWeight: FontWeight.bold) : Theme.of(context).textTheme.titleMedium!.copyWith(color:textColor, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      style:  ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0)),  
        foregroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        backgroundColor:MaterialStateProperty.all<Color>(backgroundColor),
       shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (Set<MaterialState> states) {
                // Si el botón está desactivado, no aplicamos ningún shape
                if (states.contains(MaterialState.disabled)) {
                  return  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Ajusta el radio según sea necesario
                ); // Ajusta el radio según sea necesario;
                }
                // Si el botón está en su estado normal, aplicamos bordes redondeados
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Ajusta el radio según sea necesario
                );
              },
            ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return Colors.transparent;
            if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))
              return Colors.transparent;
            return null; // Defer to the widget's default.
          },
        ),
      ),
    );
  }
}