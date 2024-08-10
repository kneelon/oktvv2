import 'package:oktvv2/presentation/utility/constants.dart';
import 'package:oktvv2/presentation/utility/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';
import 'package:oktvv2/presentation/utility/constants.dart' as constants;

class ShowOkDialog extends StatelessWidget {

  final String title;
  final String description;
  final Function onTap;
  const ShowOkDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
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
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockVertical * 2),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       const SizedBox(),
                    //       Text(
                    //         title,
                    //         style: textColored3(context, global.palette5, FontWeight.bold),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       InkWell(
                    //         onTap: () => Navigator.of(context).pop(),
                    //         child: Icon(
                    //           Icons.highlight_remove,
                    //           color: global.errorColor,
                    //           size: SizeConfig.safeBlockVertical * 5,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    Text(
                      title,
                      style: textColored3(context, global.palette5, FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      description,
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
                          _closeButton(context),
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

  // Widget _addItemButton(context) =>
  //   GestureDetector(
  //     onTap: () {
  //       Navigator.of(context).pop();
  //       onAddItemClicked.call();
  //     },
  //     child: Container(
  //       width: SizeConfig.safeBlockVertical * 28,
  //       height: SizeConfig.safeBlockVertical * 7,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(
  //           SizeConfig.safeBlockVertical * 2,
  //         ),
  //         border: Border.all(
  //           width: SizeConfig.blockSizeVertical * .4,
  //           color: global.textColorDark,
  //         )
  //       ),
  //       child: Center(
  //         child: Text(
  //           addItem,
  //           style: textColored2(context, global.textColorDark, FontWeight.bold),
  //         ),
  //       ),
  //     ),
  //   );

  Widget _closeButton(context) =>
    GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          onTap.call();
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
              AppStrings.capClose,
              style: textColored2(context, global.palette1, FontWeight.bold),
            ),
          ),
        ),
      );
}
