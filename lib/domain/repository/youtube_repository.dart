
import 'package:oktvv2/data/model/youtube/search_response_model.dart';

abstract class YoutubeRepository {
  Future<SearchResponseModel> searchYoutubeVideos(String searchInput);
}