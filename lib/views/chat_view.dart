import 'package:bongoai/utils/assets_path.dart';
import 'package:bongoai/utils/components/chat_welcome.dart';
import 'package:bongoai/utils/components/profile_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/components/chat_bubble.dart';
import '../viewmodels/chat_viewmodel.dart';

class ChatView extends StatefulWidget {
  ChatView({super.key});

  static const String routeName = '/chat';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Consumer<ChatViewModel>(
                  builder: (context, vm, child) {
                    vm.onMessageAdded = (index) {
                      _listKey.currentState?.insertItem(index);
                      _scrollToBottom();
                    };

                    return ListView.builder(
                      key: _listKey,
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 200, top: 16),
                      itemCount: vm.messages.isEmpty ? 1 : vm.messages.length,
                      itemBuilder: (context, index) {
                        if (vm.messages.isEmpty) {
                          return const Center(
                            child: ChatWelcome(name: "Nahid"),
                          );
                        }
                        final msg = vm.messages[index];
                        return ChatBubble(message: msg);
                      },
                    );
                  },
                ),
              ),
              _textAndSendSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textAndSendSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 6,
              decoration: InputDecoration(hintText: 'Ask what’s on mind...'),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.white),
              onPressed: () {
                final vm = Provider.of<ChatViewModel>(context, listen: false);
                if (_controller.text.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                  vm.sendMessage(_controller.text);
                  _controller.clear();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          const Text(
            'BangoAI',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      forceMaterialTransparency: true,
      actions: [
        IconButton(
          icon: Image.asset(AssetsPath.writeIcon, width: 28),
          onPressed: () {
            Provider.of<ChatViewModel>(context, listen: false).resetMessages();
          },
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            showProfileDialog(context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.cyan.shade100,
            radius: 19,
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/160839491?v=4',
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  TextField(decoration: InputDecoration(hintText: 'Search')),
                  const SizedBox(height: 20),
                  const Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ChatViewModel>(
                builder: (context, value, child) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: value.conversations.length,
                    itemBuilder: (context, index) {
                      final conv = value.conversations[index];
                      return InkWell(
                        onTap: () {
                          value.switchConversation(index);
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          child: Text(
                            conv.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
