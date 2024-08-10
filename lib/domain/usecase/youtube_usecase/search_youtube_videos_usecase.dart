
import 'package:oktvv2/data/model/youtube/search_response_model.dart';
import 'package:oktvv2/domain/repository/youtube_repository.dart';

class SearchYoutubeVideosUsecase {
  final YoutubeRepository repository;

  const SearchYoutubeVideosUsecase({required this.repository});

  Future<SearchResponseModel> call(String searchInput) async {
    return await repository.searchYoutubeVideos(searchInput);
  }
}