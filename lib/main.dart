import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktvv2/data/datasource/remote/firebase/firebase_remote_datasource.dart';
import 'package:oktvv2/data/datasource/remote/firebase/implement_firebase_remote_datasource.dart';
import 'package:oktvv2/data/datasource/remote/youtube/implement_youtube_remote_data_source.dart';
import 'package:oktvv2/data/repository/implement_firebase_repository.dart';
import 'package:oktvv2/data/repository/implement_youtube_repository.dart';
import 'package:oktvv2/domain/repository/firebase_repository.dart';
import 'package:oktvv2/domain/usecase/firebase_usecase/fetch_search_data_usecase.dart';
import 'package:oktvv2/domain/usecase/youtube_usecase/search_youtube_videos_usecase.dart';
import 'package:oktvv2/firebase_options.dart';
import 'package:oktvv2/presentation/ui/get_started_page.dart';
import 'package:oktvv2/presentation/ui/homepage.dart';
import 'package:oktvv2/presentation/utility/constants.dart';
import 'package:oktvv2/presentation/viewmodel/firebase_viewmodel.dart';
import 'package:oktvv2/presentation/viewmodel/youtube_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    //appleProvider: AppleProvider.appAttest,
  );

  String availableUrl = AppStrings.empty;
  List<String> urlList = [];

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getStringList(AppStrings.urlList) != null) {
    urlList = sharedPreferences.getStringList(AppStrings.urlList)!;
    if (urlList.isNotEmpty) {
      availableUrl = urlList[0];
    }
  }


  final firebaseRemoteDataSource = ImplementFirebaseRemoteDatasource();
  final firebaseRepository = ImplementFirebaseRepository(firebaseRemoteDataSource);

  final youtubeRemoteDataSource = ImplementYoutubeRemoteDataSource();
  final youtubeRepository = ImplementYoutubeRepository(youtubeRemoteDataSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseViewmodel>(create: (_) => FirebaseViewmodel(FetchSearchDataUsecase(repository: firebaseRepository))),
        ChangeNotifierProvider<YoutubeViewmodel>(create: (_) => YoutubeViewmodel(SearchYoutubeVideosUsecase(repository: youtubeRepository))),
        ChangeNotifierProvider(create: (_) => ToggleProvider(),
        ),
      ],
      child: MyApp(availableUrl: availableUrl)),
  );
}

class ToggleProvider with ChangeNotifier {
  bool _isFullWidth = false;

  bool get isFullWidth => _isFullWidth;

  void toggle() {
    _isFullWidth = !_isFullWidth;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final String availableUrl;
  const MyApp({super.key, required this.availableUrl});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OKTV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreenPage(availableUrl: availableUrl),
      //home: const TestPage(),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  final String availableUrl;
  const SplashScreenPage({super.key, required this.availableUrl});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  Widget build(BuildContext context) {
    return GetStartedPage(url: widget.availableUrl);
  }
}

