
import 'package:oktvv2/data/model/search_model.dart';

abstract class FirebaseRemoteDatasource {
  Future<List<SearchModel>> fetchSearchData();
}