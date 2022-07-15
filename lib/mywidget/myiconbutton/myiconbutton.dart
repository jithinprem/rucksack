import 'package:flutter/material.dart';


class simpleIconButton extends StatelessWidget {
  var iconColor;
  var boxColor;
  var onpressedfunc;
  var boxicon;

  simpleIconButton(this.boxicon, this.iconColor, this.boxColor, this.onpressedfunc){

  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(9)),
          color: boxColor,
        ),
        child: Icon(boxicon, color: iconColor, size: 17,),
      ),
      onPressed: onpressedfunc,
    );
  }
}
