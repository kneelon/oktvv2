
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';
import 'package:oktvv2/presentation/utility/global.dart' as global;


showConfirmAlertDialog(
    BuildContext context,
    String title,
    String description,
    Function onConfirmClicked,
    ) {
  SizeConfig().init(context);
  Widget icon = Container(
    width: SizeConfig.safeBlockVertical * 16,
    height: SizeConfig.safeBlockVertical * 16,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50.0),
      border: Border.all(
        color: global.appBarColor,
        width: 3,
      )
    ),
    child: Icon(
      Icons.question_mark,
      color: global.appBarColor,
      size: SizeConfig.safeBlockVertical * 8,
    ),
  );

  Widget cancelButton = GestureDetector(
    onTap: () => Navigator.of(context).pop(),
    child: Container(
      width: SizeConfig.safeBlockVertical * 30,
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
        border: Border.all(
          color: global.appBarColor,
          width: 1.6
        ),
      ),
      child: Center(
        child: Text(
          'NO',
          textAlign: TextAlign.center,
          style: textColored4(context, global.appBarColor, FontWeight.bold),),
      ),
    ),
  );
  Widget confirmButton = GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
      onConfirmClicked.call();
    },
    child: Container(
      width: SizeConfig.safeBlockVertical * 30,
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
        color: global.appBarColor,
      ),
      child: Center(
        child: Text(
          'YES',
          textAlign: TextAlign.center,
          style: textColored4(context, Colors.white, FontWeight.bold),),
      ),
    ),
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.alertDialogBgColor,
    title: Center(
        child: Column(
          children: [
            icon,
            SizedBox(height: SizeConfig.safeBlockVertical * 4),
            Text(
              title,
              style: textBold6(context),
            ),
          ],
        )),
    content: Text(
      description,
      style: textStyle3(context),
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          cancelButton,
          confirmButton,
        ],
      ),
      SizedBox(height: SizeConfig.safeBlockVertical * 6),
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

showConfirmDeleteDialog(
    BuildContext context,
    String title,
    String description,
    Function onConfirmClicked,
    ) {
  SizeConfig().init(context);
  Widget icon = Container(
    width: SizeConfig.safeBlockVertical * 16,
    height: SizeConfig.safeBlockVertical * 16,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: global.palette3,
          width: 3,
        )
    ),
    child: Icon(
      Icons.delete_forever_outlined,
      color: global.errorColor,
      size: SizeConfig.safeBlockVertical * 8,
    ),
  );

  Widget cancelButton = GestureDetector(
    onTap: () => Navigator.of(context).pop(),
    child: Container(
      width: SizeConfig.safeBlockVertical * 30,
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
        border: Border.all(
            color: global.errorColor,
            width: 1.6
        ),
      ),
      child: Center(
        child: Text(
          'NO',
          textAlign: TextAlign.center,
          style: textColored4(context, global.errorColor, FontWeight.bold),),
      ),
    ),
  );
  Widget confirmButton = GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
      onConfirmClicked.call();
    },
    child: Container(
      width: SizeConfig.safeBlockVertical * 30,
      height: SizeConfig.safeBlockVertical * 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
        color: global.errorColor,
      ),
      child: Center(
        child: Text(
          'YES',
          textAlign: TextAlign.center,
          style: textColored4(context, Colors.white, FontWeight.bold),),
      ),
    ),
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.alertDialogBgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    title: Center(
        child: Column(
          children: [
            icon,
            SizedBox(height: SizeConfig.safeBlockVertical * 4),
            Text(
              title,
              style: textColored6(context, global.errorColor, FontWeight.w400),
            ),
          ],
        )),
    content: Text(
      description,
      style: textStyle3(context),
      textAlign: TextAlign.center,
    ),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockVertical * 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cancelButton,
            SizedBox(width: SizeConfig.safeBlockVertical * 3),
            confirmButton,
          ],
        ),
      ),
      SizedBox(height: SizeConfig.safeBlockVertical * 6),
    ],
  );
  showCustomDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


////////////////////////////////////////////////////////////////////////////////////////////////////////

addItemAlertDialog(
    BuildContext context,
    String title,
    String label,
    TextEditingController controller,
    String cancelBtnTxt,
    String confirmBtnTxt,
    Function onConfirmClicked,
    ) {

  Widget confirmButton = GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
      onConfirmClicked.call();
    },
    child: Container(
      width: SizeConfig.safeBlockVertical * 72,
      height: SizeConfig.safeBlockVertical * 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeConfig.safeBlockVertical * 2,
        ),
        color: global.palette5,
      ),
      child: Center(
        child: Text(
          confirmBtnTxt,
          style: textColored4(context, global.palette1, FontWeight.w300),
        ),
      ),
    ),
  );

  Widget cancelButton = GestureDetector(
    onTap: () {
      controller.clear();
      Navigator.of(context).pop();
    },
    child: Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.safeBlockVertical * 6,
        top: SizeConfig.safeBlockVertical * 2.4,
      ),
      child: Container(
        width: SizeConfig.safeBlockVertical * 64,
        height: SizeConfig.safeBlockVertical * 9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            SizeConfig.safeBlockVertical * 2,
          ),
          color: global.palette3,
        ),
        child: Center(
          child: Text(
            'Close',
            style: textColored4(context, global.palette1, FontWeight.w300),
          ),
        ),
      ),
    ),
  );

  Widget textFormField = Container(
    width: SizeConfig.safeBlockVertical * 72,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        SizeConfig.safeBlockVertical * 2
      ),
      border: Border.all(
        width: SizeConfig.safeBlockVertical * .3,
        color: global.palette5,
      )
    ),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: textStyle3(context),
      decoration: InputDecoration(
        label: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: textStyle3(context),),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 2,
          horizontal: SizeConfig.safeBlockVertical * 2
        ),
        border: InputBorder.none,
      ),
    ),
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.alertDialogBgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    title: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: textColored5(context, global.palette3, FontWeight.bold)
        )),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockVertical * 12,
        ),
        child: Column(
          children: [
            textFormField,
            SizedBox(height: SizeConfig.safeBlockVertical * 6,),
            confirmButton,
            cancelButton,
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

showInformationAlertDialog(
    BuildContext context,
    String title,
    String description,
    ) {

  Widget icon = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(
        color: global.errorColor,
        width: SizeConfig.safeBlockVertical * .5,
      )
    ),
    child: Padding(
      padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 2),
      child: Icon(
        Icons.warning_amber_outlined,
        color: global.errorColor,
        size: SizeConfig.safeBlockVertical * 10,
      ),
    ),
  );

  Widget myTitle = Padding(
    padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
    child: Text(
        title,
        style: textColored5(context, global.errorColor, FontWeight.bold)
    ),
  );

  Widget myDescription = Center(
    child: Text(
      description,
      textAlign: TextAlign.center,
      style: textStyle3(context),
    ),
  );

  Widget confirmButton = GestureDetector(
    onTap: () {
      Navigator.of(context).pop(false);
    },
    child: Container(
      width: SizeConfig.safeBlockVertical * 72,
      height: SizeConfig.safeBlockVertical * 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeConfig.safeBlockVertical * 2,
        ),
        color: global.palette5,
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
    backgroundColor: global.alertDialogBgColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: Center(
        child: Column(
          children: [
            icon,
            myTitle,
          ],
        )),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockVertical * 12,
        ),
        child: Column(
          children: [
            myDescription,
            SizedBox(height: SizeConfig.safeBlockVertical * 6,),
            confirmButton,
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


showLoadingAlertDialog(
    BuildContext context,
    String description,
    bool isDismisable,
    ) {

  Widget myDescription = Center(
    child: Text(
      description,
      textAlign: TextAlign.center,
      style: textStyle5(context),
    ),
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.alertDialogBgColor,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
    ),
    title: Center(
        child: Text(
            'Loading',
            style: textColored5(context, global.errorColor, FontWeight.bold)
        )),
    actions: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockVertical * 12,
        ),
        child: Column(
          children: [
            myDescription,
            Padding(
              padding: EdgeInsets.all(
                SizeConfig.safeBlockVertical * 4
              ),
              child: const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: global.palette3,
                  strokeWidth: 6,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
  showCustomDialog(
    context: context,
    barrierDismissible: isDismisable,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

////////////////////////////////////////////////////////////////////////////////


showOkAlertDialog(
  BuildContext context,
  String title,
  String description,
  String confirmBtnTxt,
  Color confirmColor,
  Function onConfirmClicked,
  bool isDismisable,
) {
  Widget confirmButton = TextButton(
    child: Text(
      confirmBtnTxt,
      style: TextStyle(
          color: confirmColor,
          fontSize: SizeConfig.safeBlockVertical * 3.06,
          letterSpacing: 1),
    ),
    onPressed: () {
      Navigator.of(context).pop();
      onConfirmClicked.call();
    },
  );

  CustomDialog alert = CustomDialog(
    backgroundColor: global.alertDialogBgColor,
    title: Center(
        child: Text(
      title,
      style: textColored3(context, global.appBarColor, FontWeight.bold),
    )),
    content: Text(
      description,
      textAlign: TextAlign.center,
      style: textStyle3(context)
    ),
    actions: [
      Column(
        children: [
          SizedBox(
            height: 1.0,
            child: Center(
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 5.0,
                color: Colors.black38,
              ),
            ),
          ),
          confirmButton
        ],
      ),
    ],
  );
  showCustomDialog(
    context: context,
    barrierDismissible: isDismisable,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

////////////////////////////////////////////////////////////////////////////////////////////////////////



