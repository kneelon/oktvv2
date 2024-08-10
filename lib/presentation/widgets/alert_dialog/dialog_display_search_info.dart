
import 'package:oktvv2/presentation/utility/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';


dialogDisplaySearchInfo(
    BuildContext context,
    ) {

  Widget myTitle = Padding(
    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
    child: Text(
      'How to Add item',
      style: textBold3(context),
    ),
  );

  Widget myDescription = Center(
    child: Image.asset(
      'assets/show_info.webp',
      scale: 2,
    ),
  );

  Widget onCloseClick = InkWell(
    onTap: () {
      Navigator.of(context).pop(false);
      //onCloseClicked.call();
    },
    child: Container(
      width: SizeConfig.safeBlockVertical * 63,
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeConfig.safeBlockVertical * 2,
        ),
        color: global.palette6,
      ),
      child: Center(
        child: Text(
          'Close',
          style: textColored4(context, global.palette1, FontWeight.w300),
        ),
      ),
    ),
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.backGroundColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: Center(
        child: myTitle),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockVertical * 12,
        ),
        child: Column(
          children: [
            myDescription,
            SizedBox(height: SizeConfig.safeBlockVertical * 6,),
            onCloseClick,
            SizedBox(height: SizeConfig.safeBlockVertical * 6),
          ],
        ),
      ),
    ],
  );
  showCustomDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

////////////////////////////////////////////////////////////////////////////////