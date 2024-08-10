
import 'package:oktvv2/data/model/search_model.dart';

abstract class FirebaseRepository {
  Future<List<SearchModel>> fetchSearchData();
}