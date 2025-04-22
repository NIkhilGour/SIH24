import 'package:ayurvan/core/chatfunction.dart';
import 'package:ayurvan/widgets/typingdots.dart';
import 'package:flutter/material.dart';

class GeminiHerbalBot extends StatefulWidget {
  const GeminiHerbalBot({super.key});

  @override
  _GeminiHerbalBotState createState() => _GeminiHerbalBotState();
}

class _GeminiHerbalBotState extends State<GeminiHerbalBot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;

  void _sendMessage() async {
    final userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    setState(() {
      _messages.add({"text": userInput, "isUser": true});
      _isTyping = true;
    });

    _controller.clear();

    final botResponse = await getGeminiResponse(userInput);

    setState(() {
      _messages.add({"text": botResponse, "isUser": false});
      _isTyping = false;
    });
  }

  Widget buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser ? Colors.green[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text),
      ),
    );
  }

  Widget buildTypingIndicator() {
    return const TypingDots(); // Use the TypingDots widget here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("🌿 AyushBot - Medicinal Plant Assistant")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (_, index) {
                if (_isTyping && index == _messages.length) {
                  return buildTypingIndicator();
                }
                final msg = _messages[index];
                return buildMessageBubble(msg['text'], msg['isUser']);
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about a medicinal plant...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
