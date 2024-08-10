import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/ui/new_homepage.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/utility/global.dart' as global;


class GetStartedPage extends StatefulWidget {
  final String url;
  const GetStartedPage({super.key, required this.url});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  
  
  void _delayedFunction() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewHomepage(availableUrl: widget.url)));
    });
  }

  @override
  void initState() {
    super.initState();
    _delayedFunction();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: global.palette2,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 2
                ),
                child: Text(
                  'OKTV',
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(
                  'assets/images/app_icon.png',
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
