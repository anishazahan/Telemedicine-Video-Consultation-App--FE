import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/network/api_response.dart';
import '../data/chat_models.dart';
import '../data/socket_service.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key, required this.conversationId});
  final String conversationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final messages = useState<List<ChatMessage>>([
      ChatMessage(id: 'm1', senderId: 'doctor', body: 'Hello, how are you feeling today?', createdAt: DateTime.now()),
    ]);

    useEffect(() {
      ref.read(socketServiceProvider).connect().then((socket) {
        socket.emit('conversation:join', {'conversationId': conversationId});
        socket.on('message:new', (data) {
          final json = asMap(data);
          final sender = asMap(json['sender']);
          messages.value = [
            ChatMessage(
              id: stringValue(json['_id'] ?? json['id'], const Uuid().v4()),
              senderId: stringValue(sender['_id'] ?? sender['id'], 'doctor'),
              body: stringValue(json['body']),
              createdAt: dateValue(json['createdAt']),
            ),
            ...messages.value,
          ];
        });
      });
      return null;
    }, [conversationId]);

    return Scaffold(
      appBar: AppBar(title: const Text('Secure chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: messages.value.length,
              itemBuilder: (_, index) {
                final message = messages.value[index];
                final mine = message.senderId == 'me';
                return Align(
                  alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: mine ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(message.body, style: TextStyle(color: mine ? Colors.white : null)),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Write a message'))),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () async {
                      final text = controller.text.trim();
                      if (text.isEmpty) return;
                      controller.clear();
                      final message = ChatMessage(id: const Uuid().v4(), senderId: 'me', body: text, createdAt: DateTime.now());
                      messages.value = [message, ...messages.value];
                      final socket = await ref.read(socketServiceProvider).connect();
                      socket.emit('message:send', {'conversationId': conversationId, 'body': text});
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
