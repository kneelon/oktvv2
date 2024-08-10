
import 'package:oktvv2/data/datasource/remote/youtube/implement_youtube_remote_data_source.dart';
import 'package:oktvv2/data/model/youtube/search_response_model.dart';
import 'package:oktvv2/domain/repository/youtube_repository.dart';

class ImplementYoutubeRepository implements YoutubeRepository {
  final ImplementYoutubeRemoteDataSource remoteDataSource;

  ImplementYoutubeRepository(this.remoteDataSource);

  @override
  Future<SearchResponseModel> searchYoutubeVideos(String searchInput) async {
    return await remoteDataSource.searchYoutubeVideos(searchInput);
  }
}