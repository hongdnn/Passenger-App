import 'package:flutter/material.dart';
import 'package:passenger/core/util/localization.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/styles.dart';
import 'package:passenger/util/widgets/custom_button.dart';

class ConfirmSelectPaymentWidget extends StatelessWidget {
  const ConfirmSelectPaymentWidget({Key? key, required this.onConfirm})
      : super(key: key);

  final VoidCallback onConfirm;

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        S(context).confirm_to_change_payment_method_title,
                        style: StylesConstant.ts20w500,
                      ),
                      SizedBox(height: 8.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 64.w),
                        child: Text(
                          S(context).confirm_to_change_payment_method_msg,
                          style: StylesConstant.ts14w400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 40.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: CustomButton(
                              params: CustomButtonParams(
                                text: S(context).cancel,
                                textStyle: StylesConstant.ts16w500.copyWith(
                                  color: ColorsConstant.cFFA33AA3,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: CustomButton(
                              params: CustomButtonParams.primary(
                                text: S(context).confirm,
                                onPressed: () {
                                  onConfirm();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          )
                        ],
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
