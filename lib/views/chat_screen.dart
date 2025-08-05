import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/components/chat_bubble.dart';
import '../viewmodels/chat_viewmodel.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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

  void _addMessage(ChatViewModel vm, String text) {
    vm.addUserMessage(text);
    _listKey.currentState?.insertItem(vm.messages.length - 1);
    _scrollToBottom();
    Future.delayed(const Duration(seconds: 1), () {
      vm.addBotMessage('Thinking...');
      _listKey.currentState?.insertItem(vm.messages.length - 1);
      _scrollToBottom();
      Future.delayed(const Duration(seconds: 5), () {
        final botIndex = vm.messages.lastIndexWhere(
          (m) => !m.isUser && m.text == '...thinking...',
        );
        if (botIndex != -1) {
          vm.updateBotMessage(botIndex, 'This is a sample response.');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Chats',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://placehold.co/100x100/A0A0A0/FFFFFF?text=User',
                        ),
                      ),
                      title: const Text('MD Nahid Hossen'),
                      subtitle: const Text('md.nahidhossen1911@gmail.com'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 0,
              ),
              child: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withOpacity(0.05),
                Colors.lightBlue.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Consumer<ChatViewModel>(
                    builder: (context, vm, child) {
                      return ListView.builder(
                        key: _listKey,
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 200, top: 16),
                        itemCount: vm.messages.length,
                        itemBuilder: (context, index) {
                          final msg = vm.messages[index];
                          return ChatBubble(message: msg);
                        },
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent[400],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          final vm = Provider.of<ChatViewModel>(
                            context,
                            listen: false,
                          );
                          if (_controller.text.isNotEmpty) {
                            _addMessage(vm, _controller.text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
