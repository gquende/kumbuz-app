import 'package:flutter/material.dart';
//
// final _dynamicTagController = DynamicTagController<TagData<ButtonData>>()
//
// TextFieldTags<DynamicTagData<ButtonData>>(
// textfieldTagsController: _dynamicTagController,
// initialTags:[
// DynamicTagData<ButtonData>(
// 'cat',
// const ButtonData(
// Color.fromARGB(255, 132, 204, 255),
// "😽",
// ),
// ),
// DynamicTagData<ButtonData>(
// 'penguin',
// const ButtonData<ButtonData>(
// Color.fromARGB(255, 255, 131, 228),
// '🐧',
// ),
// ),
// DynamicTagData<ButtonData>(
// 'tiger',
// const ButtonData(
// Color.fromARGB(255, 222, 255, 132),
// '🐯',
// ),
// ),
// ],
// textSeparators: const [' ', ','],
// validator: (DynamicTagData<ButtonData> tag){
// if (tag.tag == 'lion') {
// return 'Not envited per tiger request';
// } else if (_dynamicTagController.getTags!
//     .any((element) => element.tag == tag.tag)) {
// return 'Already in the club';
// }
// return null;
// },
// inputFieldBuilder: (context, inputFieldValues){
// return TextField(
// controller: inputFieldValues.textEditingController,
// focusNode: inputFieldValues.focusNode,
// );
// }
// )

class ButtonData {
  final Color buttonColor;
  final String emoji;
  const ButtonData(this.buttonColor, this.emoji);
}
