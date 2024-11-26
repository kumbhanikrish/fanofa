import 'package:flutter/material.dart';

customAppBar(
    {required String text,
    List<Widget>? actions,
    Widget? leading,
    Color? backgroundColor}) {
  return AppBar(
    backgroundColor: Colors.red,
    title: customText(
      text: text,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    actions: actions,
    leading: leading,
  );
}

customText(
    {required String text,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    int? maxLines,
    TextOverflow? overflow}) {
  return Text(
    text,
    maxLines: maxLines,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: overflow,
    ),
  );
}

titleAndText({
  required String title,
  required String text,
}) {
  return Row(
    children: [
      customText(
        text: '$title  :',
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
      customText(
        text: '  $text',
      ),
    ],
  );
}

customIconButton({required void Function()? onPressed, IconData? icon}) {
  return IconButton(
    color: Colors.white,
    onPressed: onPressed,
    icon: Icon(
      icon,
    ),
  );
}

customTextFormFiled({TextEditingController? controller, String? hintText}) {
  return TextFormField(
    cursorColor: Colors.grey,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12),
      filled: true,
      fillColor: Colors.grey.shade100,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
    ),
  );
}

customRadioListView(
    {required value,
    required String text,
    required groupValue,
    required void Function(dynamic)? onChanged}) {
  return RadioListTile(
    activeColor: Colors.red,
    title: customText(text: text),
    value: value,
    groupValue: groupValue,
    onChanged: onChanged,
  );
}
