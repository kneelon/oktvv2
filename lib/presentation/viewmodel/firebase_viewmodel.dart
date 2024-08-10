
import 'package:flutter/cupertino.dart';
import 'package:oktvv2/data/model/firebase/search_model.dart';
import 'package:oktvv2/domain/usecase/firebase_usecase/fetch_search_data_usecase.dart';

class FirebaseViewmodel extends ChangeNotifier {
  final FetchSearchDataUsecase _fetchSearchDataUsecase;

  FirebaseViewmodel(this._fetchSearchDataUsecase);

  List<SearchModel>? _searchModel;
  List<SearchModel>? get searchEntity => _searchModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchSearchDataViewModel() async {

    try {
      _isLoading = true;
      notifyListeners();
      _searchModel = await _fetchSearchDataUsecase.call();
      debugPrint('>>> fetchSearchDataViewModel() $_searchModel');
    } catch (e) {
      _searchModel = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}