
import 'package:oktvv2/data/model/firebase/search_model.dart';

abstract class FirebaseRemoteDatasource {
  Future<List<SearchModel>> fetchSearchData();
}