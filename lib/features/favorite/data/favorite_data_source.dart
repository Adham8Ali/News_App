import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/models/article_model.dart';

class FavoriteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ArticleModel>> getUserFavorites() async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) return [];

    final snapshot = await _firestore.collection('users').doc(uid).get();

    if (!snapshot.exists) return [];

    final List<dynamic> data = snapshot.data()?['favorite'] ?? [];

    return data
        .map((e) => ArticleModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> addToFavorite(ArticleModel article) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      'favorite': FieldValue.arrayUnion([article.toJson()]),
    });
  }

  Future<void> removeFromFavorite(ArticleModel article) async {
    final uid = _auth.currentUser!.uid;

    await _firestore.collection('users').doc(uid).update({
      'favorite': FieldValue.arrayRemove([article.toJson()]),
    });
  }
}
