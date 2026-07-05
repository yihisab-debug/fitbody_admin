import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models.dart';

class ChatService {
  final _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _threads =>
      _db.collection('chat_threads');

  CollectionReference<Map<String, dynamic>> _messages(String userId) =>
      _threads.doc(userId).collection('messages');

  Stream<List<ChatMessage>> messagesStream(String userId) => _messages(userId)
      .orderBy('createdAt')
      .snapshots()
      .map((s) => s.docs.map(ChatMessage.fromDoc).toList());

  Stream<List<ChatThread>> threadsStream() => _threads
      .orderBy('lastMessageTime', descending: true)
      .snapshots()
      .map((s) => s.docs.map(ChatThread.fromDoc).toList());

  Future<void> sendMessage({
    required String threadUserId,
    required String text,
    required String senderRole,
  }) async {
    final t = text.trim();
    if (t.isEmpty) return;
    final me = FirebaseAuth.instance.currentUser!;

    await _messages(threadUserId).add(ChatMessage(
      id: '', text: t, senderId: me.uid, senderRole: senderRole,
      createdAt: DateTime.now(),
    ).toMap());

    final update = <String, dynamic>{
      'lastMessage': t,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'lastSenderRole': senderRole,
    };
    if (senderRole == 'user') {
      update.addAll({
        'userId': me.uid,
        'userName': me.displayName ?? 'Пользователь',
        'userEmail': me.email ?? '',
        'userPhoto': me.photoURL,
      });
    }
    await _threads.doc(threadUserId).set(update, SetOptions(merge: true));
  }
}
