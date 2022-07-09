import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropD{

  var mystr;

  Widget DropDown(ini_dis, List<String> genderItems, selectedValue ){
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      isExpanded: true,
      hint: Text(
        ini_dis,
        style: TextStyle(fontSize: 14),
      ),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.white24,
      ),
      iconSize: 30,
      buttonHeight: 60,
      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      items: genderItems
          .map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select gender.';
        }
      },
      onChanged: (value) {
        selectedValue = value.toString();
        this.mystr = value.toString();
        print(selectedValue);
      },
      onSaved: (value) {
        selectedValue = value.toString();
        print(selectedValue);
      },
    );
  }

}

Widget DropDown(ini_dis, List<String> genderItems, selectedValue ){
  return DropdownButtonFormField2(
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    isExpanded: true,
    hint: Text(
      ini_dis,
      style: TextStyle(fontSize: 14),
    ),
    icon: const Icon(
      Icons.arrow_drop_down,
      color: Colors.white24,
    ),
    iconSize: 30,
    buttonHeight: 60,
    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    items: genderItems
        .map((item) =>
        DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return 'Please select gender.';
      }
    },
    onChanged: (value) {
      selectedValue = value.toString();
      print(value);
    },
    onSaved: (value) {
      selectedValue = value.toString();
      print(selectedValue);
    },
  );
}