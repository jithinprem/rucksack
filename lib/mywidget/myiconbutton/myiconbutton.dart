import 'package:flutter/material.dart';


class simpleIconButton extends StatelessWidget {
  var iconColor;
  var boxColor;
  var onpressedfunc;
  var boxicon;
  var size;
  simpleIconButton(this.boxicon, this.iconColor, this.boxColor, this.onpressedfunc, this.size){
    this.size = this.size*1.0;
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
        child: Icon(boxicon, color: iconColor, size: size,),
      ),
      onPressed: onpressedfunc,
    );
  }
}
