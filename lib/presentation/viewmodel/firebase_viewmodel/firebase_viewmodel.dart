
import 'package:flutter/cupertino.dart';
import 'package:oktvv2/data/model/search_model.dart';
import 'package:oktvv2/domain/usecase/firebase_usecase/fetch_search_data_usecase.dart';

class FirebaseViewmodel extends ChangeNotifier {
  final FetchSearchDataUsecase _fetchSearchDataUsecase;

  FirebaseViewmodel(this._fetchSearchDataUsecase);

  List<SearchModel>? _searchEntity;
  List<SearchModel>? get searchEntity => _searchEntity;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchSearchDataViewModel() async {

    try {
      _isLoading = true;
      notifyListeners();
      _searchEntity = await _fetchSearchDataUsecase.call();
      debugPrint('>>> fetchSearchDataViewModel() $_searchEntity');
    } catch (e) {
      _searchEntity = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}