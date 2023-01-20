import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChattingRoom1 extends StatefulWidget {
  const ChattingRoom1({Key? key}) : super(key: key);

  @override
  State<ChattingRoom1> createState() => _ChattingRoom1State();
}

class _ChattingRoom1State extends State<ChattingRoom1> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _messages = [];

  static const _key = 'messages';

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messages = prefs.getStringList(_key) ?? [];
    setState(() {
      _messages.addAll(messages);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_key, _messages);
  }

  void _sendMessage() {
    final String message = _messageController.text;
    // Send the message here (e.g. to a server or message queue)
    setState(() {
      _messages.add(message);
    });
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    _messageController.clear();
    _saveMessages();
  }

  void _deleteAllMessages() async {
    setState(() {
      _messages.clear();
    });
    _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('김파수'),
        backgroundColor: Colors.orangeAccent,
        actions: [
          TextButton(
            onPressed: () {
              _deleteAllMessages();
            },
            child: const Text(
              '메시지 삭제',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              controller: _scrollController,
              itemBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text(_messages[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child:
                  TextField(
                    onChanged: (text) {
                      setState(() {});
                    },
                    onSubmitted: (String str) {
                      setState(() {
                        if (str.isNotEmpty) {
                          _sendMessage();
                        }
                      });
                    },
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.sentiment_satisfied),
                        onPressed: () {
                          // Add the emoji to the message
                          _messageController.text += '😊';
                          // Move the cursor to the right of the emoji
                          _messageController.selection =
                              TextSelection.collapsed(
                                  offset: _messageController.text.length);
                          // Call setState to update the send button
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed:
                      _messageController.text.isNotEmpty ? _sendMessage : null,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0))),
                  child: const Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
