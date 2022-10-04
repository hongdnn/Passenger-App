import 'package:flutter/material.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_input_widget.dart';

class AddNoteToDriverWidget extends StatefulWidget {
  const AddNoteToDriverWidget({
    Key? key,
    this.onSaveNote,
    this.initialNote,
  }) : super(key: key);
  final Function(String? note)? onSaveNote;
  final String? initialNote;
  @override
  State<AddNoteToDriverWidget> createState() => _AddNoteToDriverWidgetState();
}

class _AddNoteToDriverWidgetState extends State<AddNoteToDriverWidget> {
  late final TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              widget.onSaveNote?.call(_noteController.text.trim());
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsConstant.cWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0.w),
                      topRight: Radius.circular(20.0.w),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 24.w,
                    right: 24.w,
                    top: 24.w,
                    bottom: 30.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        S(context).message_to_driver,
                        style: StylesConstant.ts16w500,
                      ),
                      SizedBox(height: 20.w),
                      CustomInputWidget(
                        onSubmitted: (String value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        textInputAction: TextInputAction.done,
                        controller: _noteController,
                        hintText: S(context).hint_text_message_to_driver,
                        maxLines: maxLineAddNoteToDriver,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
