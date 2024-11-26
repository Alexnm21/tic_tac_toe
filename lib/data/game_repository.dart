import 'package:cloud_firestore/cloud_firestore.dart';

class GameRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'games';

  Future<String> addGame({String? xName, String? oName}) async {
    try {
      final gameData = {
        'xTurn': true,
        'xName': xName ?? '',
        'oName': oName ?? '',
        'winnerBoxes': [],
        'board': [
          ['', '', ''],
          ['', '', ''],
          ['', '', ''],
        ],
        'scoreboard': {
          'xScore': 0,
          'oScore': 0,
          'drawScore': 0,
        },
        'playAgain': [],
      };

      final DocumentReference docRef =
          await _firestore.collection(_collectionName).add(gameData);

      return docRef.id;
    } catch (e) {
      throw Exception('Could not create the game');
    }
  }

  Stream<Map<String, dynamic>> getGameStream(String gameId) {
    return _firestore
        .collection(_collectionName)
        .doc(gameId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data()!;
      } else {
        throw Exception('Game not found');
      }
    });
  }

  Future<void> updateGame(
      String gameId, Map<String, dynamic> updateData) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(gameId)
          .update(updateData);
    } catch (e) {
      throw Exception('No se pudo actualizar el juego: $e');
    }
  }

  Future<void> deleteGame(String gameId) async {
    try {
      await _firestore.collection(_collectionName).doc(gameId).delete();
    } catch (e) {
      throw Exception('No se pudo eliminar el juego: $e');
    }
  }
}
