
import 'package:oktvv2/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:oktvv2/data/datasource/remote/implement_firebase_remote_datasource.dart';
import 'package:oktvv2/data/model/search_model.dart';
import 'package:oktvv2/domain/repository/firebase_repository.dart';

class ImplementFirebaseRepository implements FirebaseRepository {
  final ImplementFirebaseRemoteDatasource _firebaseRemoteDatasource;

  ImplementFirebaseRepository(this._firebaseRemoteDatasource);

  @override
  Future<List<SearchModel>> fetchSearchData() async {
    return await _firebaseRemoteDatasource.fetchSearchData();
  }
}