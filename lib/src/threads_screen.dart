import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'auth_service.dart';
import 'chat_service.dart';
import 'chat_view.dart';
import 'models.dart';
import 'theme.dart';

class ThreadsScreen extends StatelessWidget {
  const ThreadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = ChatService();
    final auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обращения пользователей'),
        actions: [
          IconButton(
            tooltip: 'Выйти',
            icon: const Icon(Icons.logout),
            onPressed: () => auth.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<List<ChatThread>>(
        stream: chat.threadsStream(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final threads = snap.data!;
          if (threads.isEmpty) {
            return const Center(
              child: Text('Пока нет обращений от пользователей.',
                  style: TextStyle(color: AppColors.textSecondary)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: threads.length,
            separatorBuilder: (_, __) => const SizedBox(height: 6),
            itemBuilder: (context, i) {
              final t = threads[i];
              final time = t.lastMessageTime != null
                  ? DateFormat('dd.MM HH:mm').format(t.lastMessageTime!) : '';
              final prefix = t.lastSenderRole == 'admin' ? 'Вы: ' : '';
              return Card(
                color: AppColors.card,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.purple,
                    backgroundImage:
                        t.userPhoto != null ? NetworkImage(t.userPhoto!) : null,
                    child: t.userPhoto == null
                        ? const Icon(Icons.person, color: Colors.white) : null,
                  ),
                  title: Text(t.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('$prefix${t.lastMessage}',
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textSecondary)),
                  trailing: Text(time,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 11)),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChatView(
                      title: t.userName,
                      threadUserId: t.userId,
                      myRole: 'admin',
                    ),
                  )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
