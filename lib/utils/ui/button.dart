import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final Color backgroundColor;
  const ButtonCustom({super.key, required this.onPressed, required this.child, this.backgroundColor = Colors.transparent});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: child,
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