
import 'package:flutter/material.dart';
import 'package:oktvv2/data/model/youtube/search_response_model.dart';
import 'package:oktvv2/domain/usecase/youtube_usecase/search_youtube_videos_usecase.dart';
import 'package:provider/provider.dart';

class YoutubeViewmodel extends ChangeNotifier {
  final SearchYoutubeVideosUsecase _searchYoutubeVideosUsecase;

  YoutubeViewmodel(this._searchYoutubeVideosUsecase);

  SearchResponseModel? _searchModel;
  SearchResponseModel? get searchModel => _searchModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> searchYoutubeVideosViewmodel({required String searchInput}) async {
    try {
      _isLoading = true;
      notifyListeners();
      _searchModel = await _searchYoutubeVideosUsecase.call(searchInput);
    } catch (e) {
      _searchModel = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}