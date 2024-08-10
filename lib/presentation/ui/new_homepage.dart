import 'dart:math';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:oktvv2/main.dart';
import 'package:flutter/material.dart';
import 'package:oktvv2/presentation/utility/constants.dart';
import 'package:oktvv2/presentation/utility/custom_voice_to_text.dart';
import 'package:oktvv2/presentation/utility/get_default_url.dart';
import 'package:oktvv2/presentation/utility/size_config.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/confirm_delete_dialog.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/dialog_contact_developer.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/dialog_display_search_info.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/right_aligned_dialog.dart';
import 'package:oktvv2/presentation/widgets/alert_dialog/show_ok_dialog.dart';
import 'package:oktvv2/presentation/widgets/custom_button.dart';
import 'package:oktvv2/presentation/widgets/custom_floating_action_button.dart';
import 'package:oktvv2/presentation/widgets/custom_text_style.dart';
import 'package:oktvv2/presentation/widgets/toast_widget.dart';
import 'package:oktvv2/presentation/utility/global.dart' as global;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class NewHomepage extends StatefulWidget {
  final String availableUrl;
  const NewHomepage({super.key, required this.availableUrl});

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {

  late YoutubePlayerController _playerController;
  //late final WebViewController _webViewController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _favSearchController = TextEditingController();
  late SharedPreferences _sharedPreferences;
  late CustomVoiceToText _voiceToText;

  bool _isAClicked = false;
  bool _isBClicked = false;
  bool _isCClicked = false;
  bool _isDClicked = false;
  bool _isEClicked = false;
  bool _isFClicked = false;
  bool _isGClicked = false;
  bool _isHClicked = false;
  bool _isIClicked = false;
  bool _isJClicked = false;
  bool _isKClicked = false;
  bool _isLClicked = false;
  bool _isMClicked = false;
  bool _isNClicked = false;
  bool _isOClicked = false;
  bool _isPClicked = false;
  bool _isQClicked = false;
  bool _isRClicked = false;
  bool _isSClicked = false;
  bool _isTClicked = false;
  bool _isUClicked = false;
  bool _isVClicked = false;
  bool _isWClicked = false;
  bool _isXClicked = false;
  bool _isYClicked = false;
  bool _isZClicked = false;
  bool _is0Clicked = false;
  bool _is1Clicked = false;
  bool _is2Clicked = false;
  bool _is3Clicked = false;
  bool _is4Clicked = false;
  bool _is5Clicked = false;
  bool _is6Clicked = false;
  bool _is7Clicked = false;
  bool _is8Clicked = false;
  bool _is9Clicked = false;
  bool _isSpaceClicked = false;


  bool _isTextFieldShow = false;
  bool _isBrowser = false;
  bool _isKeyboardShow = false;
  bool _isFavoriteShow = false;
  bool _isClicked = false;
  bool _isVideoDone = false;
  bool _canVibrate = false;
  bool _isEmptyList = true;
  bool _isVibrateEnabled = true;
  List<String> _favUrlList = [];
  List<String> _favTitleList = [];
  List<String> _titleList = [];
  List<String> _urlList = [];
  List<String> _filteredTitleList = [];
  String _currentPlayingUrl = AppStrings.empty;
  String _textResult = AppStrings.empty;
  String _savedRandomUrl = AppStrings.empty;
  int _randomScore = 0;
  bool _isPlaying = false;
  bool _isPlayingDefaultUrl = false;
  String _playStatus = 'Wating...';
  IconData _iconPlayer = Icons.back_hand_outlined;


  void _initializeSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getStringList(AppStrings.titleList) != null) {
      _titleList = _sharedPreferences.getStringList(AppStrings.titleList)!;
    }
    if (_sharedPreferences.getStringList(AppStrings.urlList) != null) {
      _urlList = _sharedPreferences.getStringList(AppStrings.urlList)!;
      debugPrint('>>> MY URL LIST $_urlList');
    }
    if (_sharedPreferences.getStringList(AppStrings.favTitleList) != null) {
      _favTitleList = _sharedPreferences.getStringList(AppStrings.favTitleList)!;
      _filteredTitleList = _favTitleList;
      _favSearchController.addListener(_filterTitles);
    }
    if (_sharedPreferences.getStringList(AppStrings.favUrlList) != null) {
      _favUrlList = _sharedPreferences.getStringList(AppStrings.favUrlList)!;
    }
  }


  void _iconChanger(bool isPlaying) {

    if (isPlaying) {
      _iconPlayer = Icons.play_arrow;
      _playStatus = 'Now playing...';
      _isPlaying = true;
    } else {
      _iconPlayer = Icons.pause;
      _playStatus = 'Paused ';
      _isPlaying = false;
    }
    if (_currentPlayingUrl == _savedRandomUrl) {
      _playStatus = 'Waiting...';
      _iconPlayer = Icons.back_hand_outlined;
    }
  }

  void _checkVibration() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
    });
  }

  void _vibrate() {
    if (_canVibrate) {
      Vibrate.feedback(FeedbackType.light);
    }
  }

  void _validatePlayingDefaultUrl(String playingUrl) {
    setState(() {
      if (playingUrl.contains(AppStrings.cTime)) {
        _isPlayingDefaultUrl = true;
      } else {
        _isPlayingDefaultUrl = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeSharedPreference();
    if (widget.availableUrl.isEmpty) {
      _savedRandomUrl = getDefaultUrl();
      _currentPlayingUrl = _savedRandomUrl;
    } else {
      _currentPlayingUrl = widget.availableUrl;
    }

    _playerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(_currentPlayingUrl)!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          loop: false,
          mute: false,
          showLiveFullscreenButton: false,
        )
    );

    _playerController.addListener(_videoListener);
    _validatePlayingDefaultUrl(_currentPlayingUrl);
    _clearTextField();
    _voiceToText = CustomVoiceToText(
      stopFor: 6,
    );
    _voiceToText.addListener(_onSpeechResult);
    _initializeSpeech();
    _checkVibration();
  }

  void _initializeSpeech() {
    _voiceToText.initSpeech();
    setState(() {});
  }

  void _onSpeechResult() {
    setState(() {
      _textResult = _voiceToText.speechResult;
      if (_textResult.isNotEmpty) {
        _isFavoriteShow = false;
        _isBrowser = true;
        showToastWidget('Searching for ${_textResult.toUpperCase()}', global.successColor);
      }
    });
  }

  void _startListening() {
    _voiceToText.startListening();
  }

  void _stopListening() {
    _voiceToText.stop();
  }


  void _videoListener() {
    if (_playerController.value.playerState == PlayerState.ended) {
      debugPrint('SONG IS DONE');
    }
    if (_playerController.value.playerState == PlayerState.paused) {
      setState(() {
        _iconChanger(false);
      });
    } else {
      setState(() {
        _iconChanger(true);
      });
    }
  }


  void _filterTitles() {
    String query = _favSearchController.text.toLowerCase();
    setState(() {
      _filteredTitleList = _favTitleList
          .where((title) => title.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.removeListener(_videoListener);
    _playerController.dispose();
    _searchController.dispose();
    _favSearchController.removeListener(_filterTitles);
    _favSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        floatingActionButton: Consumer<ToggleProvider>(
          builder: (context, toggleProvider, child) {
            return CustomFloatingActionButton(
                onPress: () => toggleProvider.toggle(),
            );
          },
        ),
        body: IntrinsicHeight(
          child: Consumer<ToggleProvider>(
            builder: (context, toggleProvider, child) {
              return Row(
                children: <Widget>[
                  _buildPanelA(toggleProvider.isFullWidth),
                  toggleProvider.isFullWidth ? const SizedBox() :
                    _isFavoriteShow ? _buildFavoriteListView() : _buildPanelB(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPanelA(bool isFullWidth) =>
      SizedBox(
        width: isFullWidth ? SizeConfig.blockSizeHorizontal * 100 : SizeConfig.safeBlockHorizontal * 70,
        height: SizeConfig.safeBlockVertical * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: isFullWidth ? SizeConfig.safeBlockHorizontal * 100 :
                _isKeyboardShow && !_isBrowser ?
                  SizeConfig.safeBlockHorizontal * 63 :
                  SizeConfig.safeBlockHorizontal * 70,
              height: isFullWidth ? SizeConfig.safeBlockVertical * 100 :
                _isKeyboardShow && !_isBrowser ?
                  SizeConfig.safeBlockVertical * 63 :
                  SizeConfig.safeBlockVertical * 70,
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _playerController,
                  showVideoProgressIndicator: true,
                  onEnded: (YoutubeMetaData metaData) {
                    setState(() {
                      final random = Random();
                      _randomScore = random.nextInt(26) + 75;

                      _isVideoDone = true;
                      _isKeyboardShow = false;
                    });
                  },
                ),
                builder: (context, player) {
                  return player;
                },
              ),
            ),
            isFullWidth ? const SizedBox() :
              _isKeyboardShow && !_isBrowser ? _buildCustomKeyboard(context) : _buildKeyCustomKeyboard(),
          ],
        ),
      );

  Widget _buildKeyCustomKeyboard() =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  dialogDisplaySearchInfo(context);
                },
                child: Icon(
                  Icons.info_outline,
                  size: SizeConfig.safeBlockVertical * 8,
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 4),
              GestureDetector(
                onTap: () {
                  dialogContactDeveloper(
                      context,
                      'Contact Developer',
                      'Darwin Lumampao\nEmail: darwindlumampao@gmail.com\nMobile:+63906 7705930\nWhatsApp: +63906 7705930\nViber: +63906 7705930',
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: SizeConfig.safeBlockVertical * 2
                  ),
                  child: Icon(
                    Icons.settings_outlined,
                    size: SizeConfig.safeBlockVertical * 8,
                    color: global.blackBrown,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal * 48,
            height: SizeConfig.safeBlockVertical * 24,
            child: _isVideoDone && _urlList.isNotEmpty ?
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: SizeConfig.safeBlockHorizontal * .5),
                      Text('Score', style: textBold4(context)),
                      Container(
                        width: SizeConfig.safeBlockHorizontal * 7,
                        height: SizeConfig.safeBlockHorizontal * 7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            width: SizeConfig.safeBlockHorizontal * .6,
                            color: global.successColor,
                          )
                        ),
                        child: Center(
                          child: Text(
                            '$_randomScore',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_urlList.length > 1 && !_isPlayingDefaultUrl) {
                        setState(() {
                          _isPlayingDefaultUrl = false;
                          _isVideoDone = false;
                          _titleList.removeAt(0);
                          _urlList.removeAt(0);
                          _sharedPreferences.setStringList(AppStrings.titleList, _titleList);
                          _sharedPreferences.setStringList(AppStrings.urlList, _urlList).whenComplete((){
                            _currentPlayingUrl = _urlList[0];
                            _playerController.load(
                                YoutubePlayer.convertUrlToId(_currentPlayingUrl)!
                            );
                          });
                        });
                      } else {
                        setState(() {
                          if (_urlList.isNotEmpty) {
                            _isVideoDone = false;
                            _currentPlayingUrl = _urlList[0];
                            _playerController.load(
                                YoutubePlayer.convertUrlToId(_currentPlayingUrl)!
                            );
                          } else {
                            _isVideoDone = false;
                            _playerController.load(
                                YoutubePlayer.convertUrlToId(_savedRandomUrl)!
                            );
                          }
                        });
                      }
                    },
                    child: Image.asset(
                      width: SizeConfig.safeBlockHorizontal * 10,
                      height: SizeConfig.safeBlockHorizontal * 10,
                        'assets/play_button.png',
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 6),
                ],
              )
              : SizedBox(child: _buildSkipButtonIfDefaultUrl()),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: _voiceToText.isListening ? _stopListening : _startListening,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: SizeConfig.safeBlockVertical * .8,
                        color: _voiceToText.isListening ? global.successColor : global.blackBrown,
                      )
                  ),
                  child: Icon(
                    _voiceToText.isListening ? Icons.mic : Icons.mic_none,
                    color: _voiceToText.isListening ? global.successColor : global.blackBrown,
                    size: SizeConfig.safeBlockVertical * 8,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              InkWell(
                onTap: () {
                  setState(() {
                    _isKeyboardShow = !_isKeyboardShow;
                    _isBrowser = false;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 2),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          width: SizeConfig.safeBlockVertical * .8,
                          color: Colors.black54,
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
                      child: Icon(
                        Icons.keyboard_alt_outlined,
                        size: SizeConfig.safeBlockVertical * 6,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildSkipButtonIfDefaultUrl() =>
    _isPlayingDefaultUrl && _urlList.isNotEmpty ?
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.safeBlockVertical * 6,
          horizontal: SizeConfig.safeBlockHorizontal * 8,
        ),
        child: ElevatedButton(onPressed: () {
          setState(() {
            _isVideoDone = false;
            _isPlayingDefaultUrl = false;
            _currentPlayingUrl = _urlList[0];
            _playerController.load(
                YoutubePlayer.convertUrlToId(_currentPlayingUrl)!
            );
          });

        }, child: const Text('Skip this song')),
      )
        : const SizedBox();

  Widget _buildPanelB() =>
      Container(
        width: SizeConfig.safeBlockHorizontal * 30,
        height: SizeConfig.safeBlockVertical * 100,
        color: global.palette1,
        child: Column(
          children: <Widget>[
            _buildTopLayer(),
            _isEmptyList ? const SizedBox() : _buildQueueDisplay(),
            _buildListViewBuilder(),
          ],
        ),
      );

  Widget _buildTopLayer() =>
      (!_isBrowser && _isKeyboardShow) || (!_isBrowser && _isTextFieldShow) ?
      Container(
        width: SizeConfig.safeBlockHorizontal * 30,
        height: SizeConfig.safeBlockVertical * 15,
        decoration: BoxDecoration(
            border: Border.all(
              width: SizeConfig.safeBlockVertical * .2,
              color: Colors.black54,
            )
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.safeBlockVertical * 2,
            right: SizeConfig.safeBlockVertical * 1,
            left: SizeConfig.safeBlockVertical * 1,
          ),
          child: TextFormField(
            controller: _searchController,
            style: textBold3(context),
            cursorColor: Colors.black45,
            decoration: InputDecoration(
              hintText: 'Type here',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  bottom: SizeConfig.safeBlockVertical * 4,
                  left: SizeConfig.safeBlockVertical * 1,
                )
            ),
            onTap: null,
            enabled: false,
            maxLines: 2,
          ),
        ),
      ) : const SizedBox();

  Widget _buildQueueDisplay() =>
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * .4
        ),
        child: SizedBox(
          width: SizeConfig.safeBlockHorizontal * 30,
          height: SizeConfig.safeBlockVertical * 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _isBrowser ?
              customButton(context, _isFavoriteShow ? 'Browse' : 'Favorites', () {
                _initializeSharedPreference();
                setState(() {
                  _isFavoriteShow = !_isFavoriteShow;
                });
              }) :
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreenPage(availableUrl: _currentPlayingUrl)));
                },
                child: Text(_titleList.isNotEmpty ? '${_titleList.length - 1} Queue' : 'No Items'),
              ),
              customButton(
                context,
                _isBrowser ? 'VIEW LIST' : 'Browse',
                    () {
                  setState(() {
                    _isBrowser = !_isBrowser;
                    _isTextFieldShow = false;
                    _isKeyboardShow = false;
                  });
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildListViewBuilder() =>
      SizedBox(
        width: SizeConfig.safeBlockHorizontal * 30,
        height: _isKeyboardShow || _isTextFieldShow ? SizeConfig.safeBlockVertical * 70 : SizeConfig.safeBlockVertical * 90,
        child: _urlList.isNotEmpty ? ListView.builder(
          itemCount: _urlList.length,
          itemBuilder: (context, index) {
            _isEmptyList = false;
            return _validateAndDisplayItems(index);
          },
        ) : _buildPlaceHolder(),
      );

  Widget _buildPlaceHolder() {

    return Container(
      width: SizeConfig.safeBlockHorizontal * 30,
      height: SizeConfig.safeBlockVertical * 90,
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.safeBlockVertical * 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Empty items here, click Add button below!',
              style: textStyle2(context),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 2),
            ElevatedButton(
              onPressed: () => dialogDisplaySearchInfo(context),
              child: const Text(AppStrings.capAdd),
            ),
          ],
        ),
      ),
    );
  }

  Widget _validateAndDisplayItems(int index) {
    int playIndex = index;
    String remove = _urlList[index];
    String url = remove.replaceAll(AppStrings.replaceUrl, AppStrings.empty);

    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 22,
        height: SizeConfig.safeBlockVertical * 12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
            border: Border.all()
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.safeBlockVertical * .8),
              child: InkWell(
                onTap: () {
                  if (_playStatus != 'Waiting...') {
                    setState(() {
                      if (_playerController.value.isReady && !_playerController.value.isPlaying) {
                        _playerController.play();
                      } else {
                        _playerController.pause();
                      }
                    });
                  }
                },
                child: playIndex > 0 ? Container(
                  width: SizeConfig.blockSizeVertical * 6,
                  height: SizeConfig.blockSizeVertical * 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: global.blackBrown,
                        width: 2,
                      )
                  ),
                  child: Center(
                    child: Text(
                      '$playIndex',
                      style: textDark1(context),
                    ),
                  ),
                ) : Container(
                  width: SizeConfig.blockSizeVertical * 6,
                  height: SizeConfig.blockSizeVertical * 6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: _isPlaying ? global.successColor : global.errorColor,
                        width: 2,
                      )
                  ),
                  child: Center(
                    child: Icon(
                      _iconPlayer,
                      color: global.successColor,
                      size: SizeConfig.blockSizeVertical * 4,
                    ),
                  ),
                )
              ),
            ),
            playIndex > 0 ? GestureDetector(
              onTap: () {
                showToastWidget("Queue item's are not clickable", global.errorColor);
              },
              child: SizedBox(
                width: SizeConfig.safeBlockHorizontal * 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _titleList[playIndex],
                      style: textColored1(context, global.palette5, FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Video ID: $url',
                      style: textStyle1(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ) : SizedBox(
              width: SizeConfig.safeBlockHorizontal * 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _titleList[playIndex],
                          style: textColored1(context, global.palette5, FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          _playStatus,
                          style: textStyle2(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  _playStatus != 'Waiting...' ?
                    _urlList.length > 1 ?
                      InkWell(
                      onTap: () {
                        setState(() {
                          _titleList.removeAt(0);
                          _urlList.removeAt(0);
                          _sharedPreferences.setStringList(AppStrings.titleList, _titleList);
                          _sharedPreferences.setStringList(AppStrings.urlList, _urlList);
                          _playerController.load(
                              YoutubePlayer.convertUrlToId(_urlList[0])!
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: global.errorColor
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.safeBlockVertical * 1,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text('Skip', style: textStyle1(context),),
                              Icon(Icons.skip_next, size: SizeConfig.blockSizeVertical * 5),
                            ],
                          ),
                        ),
                      ),
                    ) : const SizedBox()
                    : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }





  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  Widget _buildFavoriteListView() {

    return Container(
        width: SizeConfig.safeBlockHorizontal * 30,
        height: SizeConfig.safeBlockVertical * 100,
        color: global.blackBrown,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2),
              child: SizedBox(
                height: SizeConfig.safeBlockVertical * 10,
                width: SizeConfig.safeBlockHorizontal * 29,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: SizeConfig.safeBlockVertical * 10,
                      width: SizeConfig.safeBlockHorizontal * 24,
                      decoration: BoxDecoration(
                        color: global.palette1,
                          borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 2),
                          border: Border.all(
                            width: SizeConfig.safeBlockVertical * .4,
                            color: global.textColorDark,
                          )
                      ),
                      child: TextFormField(
                        controller: _favSearchController,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _isKeyboardShow = !_isKeyboardShow;
                            _isBrowser = false;
                          });
                        },
                        maxLength: null,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: SizeConfig.safeBlockVertical * 1,
                              bottom: SizeConfig.safeBlockVertical * 3
                          ),
                          hintText: 'Search Favorites',
                          hintStyle: textStyle5(context),
                          border: InputBorder.none,
                          suffix: InkWell(
                            onTap: () {
                              _favSearchController.clear();
                              _searchController.clear();
                              _textResult = AppStrings.empty;
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: SizeConfig.safeBlockVertical * 1,
                              ),
                              child: Icon(
                                Icons.highlight_remove,
                                color: global.errorColor,
                                size: SizeConfig.safeBlockVertical * 5,
                              ),
                            ),
                          )
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isBrowser = true;
                          _isFavoriteShow = false;
                        });
                      },
                      child: Icon(
                        Icons.undo_outlined,
                        color: global.errorColor,
                        size: SizeConfig.safeBlockVertical * 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredTitleList.length,
                itemBuilder: (context, index) {
                  ///Don't use replaceAll() it will not match from _urlList
                  _filteredTitleList.sort();
                  String url = _favUrlList[index];
                  return _displayFavItems(_filteredTitleList[index], url, index);
                },
              ),
            ),
          ],
        )
    );
  }

  Widget _displayFavItems(String title, String url, int index) {

    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1),
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 22,
        height: SizeConfig.safeBlockVertical * 12,
        decoration: BoxDecoration(
          color: global.palette1,
          borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
          border: Border.all()
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  debugPrint('>>> _displayFavItems $url');
                  if (!_isItemAlreadyInTheList(url)) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return RightAlignedDialog(
                          title: title,
                          addFavorite: AppStrings.capConfirm,
                          addItem: AppStrings.capCancel,
                          onAddItemClicked: () {
                            setState(() {
                              _isClicked = false;
                            });
                          },
                          onFavoriteClicked: () {
                            setState(() {
                              _isClicked = false;
                              _titleList.add(title);
                              _urlList.add(url);
                              _sharedPreferences.setStringList(AppStrings.titleList, _titleList);
                              _sharedPreferences.setStringList(AppStrings.urlList, _urlList).whenComplete(() {
                                showToastWidget('Item added to List', global.successColor);
                              });
                            });
                          },
                          onClosed: () {
                            setState(() {
                              _isClicked = false;
                            });
                          },
                        );
                      },
                    );
                  }

                },
                child: SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textColored1(context, global.palette5, FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              deleteButton(context, () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDeleteDialog(
                      onConfirmClicked: () {
                        setState(() {
                          _isClicked = false;
                          _favTitleList.removeAt(index);
                          _favUrlList.removeAt(index);
                          _sharedPreferences.setStringList(AppStrings.favTitleList, _favTitleList);
                          _sharedPreferences.setStringList(AppStrings.favUrlList, _favUrlList);
                        });
                      },
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  bool _isItemAlreadyInTheList(String url) {
    bool result = false;
    for (int i = 0; i < _urlList.length; i++) {
      String checkUrl = _urlList[i];
      if (checkUrl == url) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ShowOkDialog(
              title: 'Item exists',
              description: 'This item is already added in the queue list',
              onTap: () {
                setState(() {
                  _isClicked = false;
                });
              },
            );
          },
        );
        result = true;
      }
    }
    return result;
  }

  bool _isItemAlreadyInTheFavList(String url) {
    bool result = false;
    for (int i = 0; i < _favUrlList.length; i++) {
      String checkUrl = _favUrlList[i];
      if (checkUrl == url) {
        result = true;
      }
    }
    return result;
  }












  //-------------------------------------CUSTOM KEYBOARD BELOW------------------------------------------------------------

  Widget _buildCustomKeyboard(context) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLetters(context),
            _buildNumbers(context),
          ],
        ),
      );

  Widget _buildLetters(context) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildFirstLayer(context),
          _buildSecondLayer(context),
          _buildThirdLayer(context),
          _buildFourthLayer(context),
        ],
      );

  Widget _buildFirstLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButtons(context, 'Q', _isQClicked),
            _buildButtons(context, 'W', _isWClicked),
            _buildButtons(context, 'E', _isEClicked),
            _buildButtons(context, 'R', _isRClicked),
            _buildButtons(context, 'T', _isTClicked),
            _buildButtons(context, 'Y', _isYClicked),
            _buildButtons(context, 'U', _isUClicked),
            _buildButtons(context, 'I', _isIClicked),
            _buildButtons(context, 'O', _isOClicked),
            _buildButtons(context, 'P', _isPClicked),
          ],
        ),
      );

  Widget _buildSecondLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButtons(context, 'A', _isAClicked),
            _buildButtons(context, 'S', _isSClicked),
            _buildButtons(context, 'D', _isDClicked),
            _buildButtons(context, 'F', _isFClicked),
            _buildButtons(context, 'G', _isGClicked),
            _buildButtons(context, 'H', _isHClicked),
            _buildButtons(context, 'J', _isJClicked),
            _buildButtons(context, 'K', _isKClicked),
            _buildButtons(context, 'L', _isLClicked),
          ],
        ),
      );

  Widget _buildThirdLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButtons(context, 'Z', _isZClicked),
            _buildButtons(context, 'X', _isXClicked),
            _buildButtons(context, 'C', _isCClicked),
            _buildButtons(context, 'V', _isVClicked),
            _buildButtons(context, 'B', _isBClicked),
            _buildButtons(context, 'N', _isNClicked),
            _buildButtons(context, 'M', _isMClicked),
            _buildBackspace(context),
          ],
        ),
      );

  Widget _buildFourthLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildEnter(context),
            _buildSpaceBar(context),
            _buildVibrationSettings(),
          ],
        ),
      );

  Widget _buildVibrationSettings() =>
    GestureDetector(
      onTap: () {
        _isVibrateEnabled = !_isVibrateEnabled;
        if (_isVibrateEnabled) {
          showToastWidget('Vibrate On', global.successColor);
        } else {
          showToastWidget('Vibrate Off', global.errorColor);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.safeBlockHorizontal * .5,
          bottom: SizeConfig.safeBlockHorizontal * .5,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all()
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * .5),
            child: Icon(
              Icons.vibration_outlined,
              size: SizeConfig.safeBlockHorizontal * 2,
            ),
          ),
        ),
      ),
    );

  Widget _buildBackspace(context) =>
      Padding(
        padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 1),
        child: GestureDetector(

          onLongPress: () {
            setState(() {
              _textResult = AppStrings.empty;
              _searchController.clear();
            });
          },
          onTapDown: (status) {
            _keyboardStateListener('Backspace');
            if (_isVibrateEnabled) {
              _vibrate();
            }
          },
          onTap: () {
            if (_textResult.isNotEmpty) {
              _keyboardOnClickEvent('Backspace');
            }
          },
          child: Container(
              width: SizeConfig.safeBlockVertical * 16,
              height: SizeConfig.safeBlockVertical * 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * .5),
                color: Colors.grey[800],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Backspace', style: TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.4, color: global.palette1)),
                  SizedBox(height: SizeConfig.blockSizeVertical * .4),
                  Image.asset(
                      'assets/arrow.webp',
                      width: SizeConfig.blockSizeVertical * 8,
                    color: global.palette1,
                  ),
                ],
              )
          ),
        ),
      );

  Widget _buildEnter(context) =>
      Padding(
        padding: EdgeInsets.only(
          right: SizeConfig.safeBlockVertical * 1,
          bottom: SizeConfig.safeBlockVertical * 1,
        ),
        child: InkWell(
          onTap: () {
            if (_textResult.isNotEmpty) {
              setState(() {
                _isBrowser = !_isBrowser;
              });
            } else {
              showToastWidget('You must enter a text', global.errorColor);
            }
          },
          onTapDown: (status) {
            if (_isVibrateEnabled) {
              _vibrate();
            }
          },
          child: Container(
            width: SizeConfig.safeBlockVertical * 16,
            height: SizeConfig.safeBlockVertical * 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * .5),
              color: global.successColor,
            ),
            child: Center(
              child: Text('SEARCH', style: textColored2(context, global.palette1, FontWeight.bold)),
            ),
          ),
        ),
      );

  Widget _buildSpaceBar(context) =>
      Padding(
        padding: EdgeInsets.only(
          right: SizeConfig.safeBlockVertical * 1,
          bottom: SizeConfig.safeBlockVertical * 1,
        ),
        child: InkWell(
          onTapUp: (status) {
            setState(() {
              _clearAllKeyboardState();
            });
          },
          onTapDown: (status) {
            _keyboardStateListener('SPACE');
            if (_isVibrateEnabled) {
              _vibrate();
            }
          },
          onTap: () {
            if (_textResult.isNotEmpty) {
              _keyboardOnClickEvent('SPACE');
            }
          },
          child: Container(
            width: SizeConfig.safeBlockVertical * 70,
            height: SizeConfig.safeBlockVertical * 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * .5),
              color: _isSpaceClicked ? global.palette1 : Colors.grey[800],
            ),
            child: Center(
              child: Text(
                'SPACE',
                style: textColored2(
                  context,
                  _isSpaceClicked ? global.blackBrown : global.palette1,
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildNumbers(context) =>
      Column(
        children: <Widget>[
          _build1stLayer(context),
          _build2ndLayer(context),
          _build3rdLayer(context),
          _build4thLayer(context),
        ],
      );

  Widget _build1stLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtons(context, '7', _is7Clicked),
            _buildButtons(context, '8', _is8Clicked),
            _buildButtons(context, '9', _is9Clicked),
          ],
        ),
      );

  Widget _build2ndLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtons(context, '4', _is4Clicked),
            _buildButtons(context, '5', _is5Clicked),
            _buildButtons(context, '6', _is6Clicked),
          ],
        ),
      );

  Widget _build3rdLayer(context) =>
      Padding(
        padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * .8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButtons(context, '1', _is1Clicked),
            _buildButtons(context, '2', _is2Clicked),
            _buildButtons(context, '3', _is3Clicked),
          ],
        ),
      );

  Widget _build4thLayer(context) =>
      Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.safeBlockVertical * .8,
          bottom: SizeConfig.safeBlockVertical * 1,
        ),
        child: Row(
          children: [
            InkWell(
              onTapUp: (status) {
                setState(() {
                  _clearAllKeyboardState();
                });
              },
              onTapDown: (status) {
                _keyboardStateListener('0');
                if (_isVibrateEnabled) {
                  _vibrate();
                }
              },
              onTap: () {
                _keyboardOnClickEvent('0');
              },
              child: Container(
                width: SizeConfig.safeBlockVertical * 12,
                height: SizeConfig.safeBlockVertical * 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * .5),
                  color: _is0Clicked ? global.palette1 : Colors.grey[800],
                ),
                child: Center(
                  child: Text(
                    '0',
                    style: textColored2(
                      context,
                      _is0Clicked ? global.blackBrown : global.palette1,
                      FontWeight.bold,
                    )),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.safeBlockVertical * 2),
            InkWell(
              onTap: () {
                setState(() {
                  _isKeyboardShow = !_isKeyboardShow;
                  _isBrowser = false;
                  _favSearchController.clear();
                  _searchController.clear();
                  _textResult = AppStrings.empty;
                  _clearTextField();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 1),
                    border: Border.all(
                        color: Colors.black54,
                        width: SizeConfig.safeBlockVertical * .5
                    )
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockVertical * 1
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.keyboard_hide_outlined,
                        color: global.palette1,
                        size: SizeConfig.safeBlockVertical * 6,
                      ),
                      Icon(
                        Icons.keyboard_hide_outlined,
                        color: global.palette1,
                        size: SizeConfig.safeBlockVertical * 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildButtons(context, String text, bool isClicked) =>
      InkWell(
        onTapUp: (status) {
          setState(() {
            _clearAllKeyboardState();
          });
        },
        onTapDown: (status) {
          _keyboardStateListener(text);
          if (_isVibrateEnabled) {
            _vibrate();
          }
        },
        onTap: () {
          _keyboardOnClickEvent(text);
        },
        child: Padding(
          padding: EdgeInsets.only(right: SizeConfig.safeBlockVertical * 1),
          child: Container(
            width: SizeConfig.safeBlockVertical * 9,
            height: SizeConfig.safeBlockVertical * 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConfig.safeBlockVertical * 1),
              color: isClicked ? global.palette1 : Colors.grey[800],
            ),
            child: Center(
              child: Text(
                text,
                style: textColored2(
                  context,
                  isClicked ? global.textColorDark : global.palette1,
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );


  void _keyboardOnClickEvent(String text) {
    setState(() {
      if (_textResult.isNotEmpty) {
        if (text == 'SPACE') {
          _textResult += ' ';
        }
        if (text == 'Backspace') {
          _textResult = _textResult.substring(0, _textResult.length -1);
        }
        if (text != 'Backspace' && text != 'SPACE') {
          _textResult += text.toLowerCase();
        }
      } else {
        _textResult += text;
      }
      _searchController.text = _textResult;
      if (_isFavoriteShow) {
        _favSearchController.text = _textResult;
      }
    });
  }

  void _clearAllKeyboardState() {
    _isAClicked = false;
    _isBClicked = false;
    _isCClicked = false;
    _isDClicked = false;
    _isEClicked = false;
    _isFClicked = false;
    _isGClicked = false;
    _isHClicked = false;
    _isIClicked = false;
    _isJClicked = false;
    _isKClicked = false;
    _isLClicked = false;
    _isMClicked = false;
    _isNClicked = false;
    _isOClicked = false;
    _isPClicked = false;
    _isQClicked = false;
    _isRClicked = false;
    _isSClicked = false;
    _isTClicked = false;
    _isUClicked = false;
    _isVClicked = false;
    _isWClicked = false;
    _isXClicked = false;
    _isYClicked = false;
    _isZClicked = false;
    _is0Clicked = false;
    _is1Clicked = false;
    _is2Clicked = false;
    _is3Clicked = false;
    _is4Clicked = false;
    _is5Clicked = false;
    _is6Clicked = false;
    _is7Clicked = false;
    _is8Clicked = false;
    _is9Clicked = false;
    _is0Clicked = false;
    _isSpaceClicked = false;
  }

  void _clearTextField() {
    if (!_isKeyboardShow) {
      setState(() {
        _favSearchController.clear();
        _searchController.clear();
        _textResult = AppStrings.empty;
      });
    }
  }

  void _keyboardStateListener(String text) {
    setState(() {
      switch (text) {
        case 'A':
          _isAClicked = true;
          break;
        case 'B':
          _isBClicked = true;
          break;
        case 'C':
          _isCClicked = true;
          break;
        case 'D':
          _isDClicked = true;
          break;
        case 'E':
          _isEClicked = true;
          break;
        case 'F':
          _isFClicked = true;
          break;
        case 'G':
          _isGClicked = true;
          break;
        case 'H':
          _isHClicked = true;
          break;
        case 'I':
          _isIClicked = true;
          break;
        case 'J':
          _isJClicked = true;
          break;
        case 'K':
          _isKClicked = true;
          break;
        case 'L':
          _isLClicked = true;
          break;
        case 'M':
          _isMClicked = true;
          break;
        case 'N':
          _isNClicked = true;
          break;
        case 'O':
          _isOClicked = true;
          break;
        case 'P':
          _isPClicked = true;
          break;
        case 'Q':
          _isQClicked = true;
          break;
        case 'R':
          _isRClicked = true;
          break;
        case 'S':
          _isSClicked = true;
          break;
        case 'T':
          _isTClicked = true;
          break;
        case 'U':
          _isUClicked = true;
          break;
        case 'V':
          _isVClicked = true;
          break;
        case 'W':
          _isWClicked = true;
          break;
        case 'X':
          _isXClicked = true;
          break;
        case 'Y':
          _isYClicked = true;
          break;
        case 'Z':
          _isZClicked = true;
          break;
        case '0':
          _is0Clicked = true;
          break;
        case '1':
          _is1Clicked = true;
          break;
        case '2':
          _is2Clicked = true;
          break;
        case '3':
          _is3Clicked = true;
          break;
        case '4':
          _is4Clicked = true;
          break;
        case '5':
          _is5Clicked = true;
          break;
        case '6':
          _is6Clicked = true;
          break;
        case '7':
          _is7Clicked = true;
          break;
        case '8':
          _is8Clicked = true;
          break;
        case '9':
          _is9Clicked = true;
          break;
        case 'SPACE':
          _isSpaceClicked = true;
          break;
      }

    });
  }

}
