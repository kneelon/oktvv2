
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oktvv2/data/datasource/remote/youtube/youtube_remote_datasource.dart';
import 'package:oktvv2/data/model/youtube/search_response_model.dart';
import 'package:oktvv2/domain/services/dio_services.dart';
import 'package:oktvv2/presentation/utility/constants.dart';

class ImplementYoutubeRemoteDataSource implements YoutubeRemoteDatasource {
  DioServices dioServices = DioServices();

  @override
  Future<SearchResponseModel> searchYoutubeVideos(String searchInput) async {
    late SearchResponseModel model;

    try {
       final response = await dioServices.getRequest('/search?key=${Api.apiKey}&part=snippet&q=$searchInput&type=video');
        debugPrint('>>> URL $response');
       if (response.statusCode == 200) {
         model = SearchResponseModel.fromJson(response.data);
         debugPrint('>>> searchYoutubeVideos() $model');
         return model;
       }
    } catch (e) {
      debugPrint('>>> searchYoutubeVideos() $e');
    }
    return model;
  }
}
