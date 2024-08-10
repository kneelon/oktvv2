
import 'package:oktvv2/data/model/search_model.dart';
import 'package:oktvv2/domain/repository/firebase_repository.dart';

class FetchSearchDataUsecase {
  final FirebaseRepository? repository;

  FetchSearchDataUsecase({this.repository});

  Future<List<SearchModel>> call() async {
    return await repository!.fetchSearchData();
  }
}