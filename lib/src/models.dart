import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String text;
  final String senderId;
  final String senderRole;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.text,
    required this.senderId,
    required this.senderRole,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'text': text,
        'senderId': senderId,
        'senderRole': senderRole,
        'createdAt': FieldValue.serverTimestamp(),
      };

  factory ChatMessage.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      text: d['text'] as String? ?? '',
      senderId: d['senderId'] as String? ?? '',
      senderRole: d['senderRole'] as String? ?? 'user',
      createdAt: (d['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}

class ChatThread {
  final String userId;
  final String userName;
  final String userEmail;
  final String? userPhoto;
  final String lastMessage;
  final DateTime? lastMessageTime;
  final String lastSenderRole;

  ChatThread({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPhoto,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastSenderRole,
  });

  factory ChatThread.fromDoc(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ChatThread(
      userId: doc.id,
      userName: d['userName'] as String? ?? 'Пользователь',
      userEmail: d['userEmail'] as String? ?? '',
      userPhoto: d['userPhoto'] as String?,
      lastMessage: d['lastMessage'] as String? ?? '',
      lastMessageTime: (d['lastMessageTime'] as Timestamp?)?.toDate(),
      lastSenderRole: d['lastSenderRole'] as String? ?? 'user',
    );
  }
}
