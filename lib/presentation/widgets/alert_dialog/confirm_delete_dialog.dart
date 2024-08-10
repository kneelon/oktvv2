import 'package:oktvv2/presentation/utility/constants.dart';
import 'package:oktvv2/presentation/utility/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';
import 'package:oktvv2/presentation/utility/constants.dart' as constants;

class ConfirmDeleteDialog extends StatelessWidget {

  final Function onConfirmClicked;
  const ConfirmDeleteDialog({
    super.key,
    required this.onConfirmClicked,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      children: [
        Positioned(
          right: 0,
          top: 1,
          bottom: 1,
          child: Dialog(
            child: Container(
              width: SizeConfig.blockSizeVertical * 16,
              height: SizeConfig.blockSizeVertical * 36,
              //color: Colors.greenAccent,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockVertical * 2
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${AppStrings.capDelete}?',
                      style: textColored3(context, global.errorColor, FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Are you sure do you want to delete this item?',
                      style: textColored2(context, global.textColorDark, FontWeight.normal),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _cancelButton(context),
                          _confirmButton(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _confirmButton(context) =>
    GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onConfirmClicked.call();
      },
      child: Container(
        width: SizeConfig.safeBlockVertical * 28,
        height: SizeConfig.safeBlockVertical * 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.safeBlockVertical * 2,
          ),
          color: global.errorColor,
        ),
        child: Center(
          child: Text(
            AppStrings.capDelete,
            style: textColored2(context, global.palette1, FontWeight.bold),
          ),
        ),
      ),
    );

  Widget _cancelButton(context) =>
    GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: SizeConfig.safeBlockVertical * 28,
          height: SizeConfig.safeBlockVertical * 7,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.safeBlockVertical * 2,
            ),
            color: global.palette5,
          ),
          child: Center(
            child: Text(
              AppStrings.capCancel,
              style: textColored2(context, global.palette1, FontWeight.bold),
            ),
          ),
        ),
      );
}
