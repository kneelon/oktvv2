import 'package:oktvv2/presentation/utility/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';

Widget customButton(context, String title, VoidCallback onPress) {
  SizeConfig().init(context);

  return InkWell(
    onTap: () {
      onPress.call();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 1),
        color: global.palette4,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 3,
          vertical: SizeConfig.blockSizeVertical * 1,
        ),
        child: Text(title, style: textColored1(context, global.palette1, FontWeight.bold),),
      ),
    ),
  );
}

Widget deleteButton(context, VoidCallback onPress) {
  SizeConfig().init(context);

  return InkWell(
    onTap: () {
      onPress.call();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: global.errorColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical * .8),
        child: Icon(
          Icons.delete_forever_outlined,
          color: global.palette1,
          size: SizeConfig.safeBlockVertical * 5,
        ),
      ),
    ),
  );
}