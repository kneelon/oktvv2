
import 'package:oktvv2/data/model/firebase/search_model.dart';

abstract class FirebaseRepository {
  Future<List<SearchModel>> fetchSearchData();
}