
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:oktvv2/data/datasource/remote/firebase_remote_datasource.dart';
import 'package:oktvv2/data/model/search_model.dart';
import 'package:oktvv2/presentation/utility/constants.dart';

class ImplementFirebaseRemoteDatasource implements FirebaseRemoteDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<SearchModel>> fetchSearchData() async {
    try {
      final snapshot = await _firestore.collection(AppStrings.search).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => SearchModel.fromJson(doc.data())).toList();
      } else {
        debugPrint('>>> fetchSearchData() No documents found.');
        return [];
      }
    } catch (e) {
      debugPrint('>>> fetchSearchData() Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}