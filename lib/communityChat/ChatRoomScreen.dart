import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String senderId;
  final String senderName;
  final String messageText;
  final DateTime timestamp;

  ChatMessage({
    required this.senderId,
    required this.senderName,
    required this.messageText,
    required this.timestamp,
  });
}

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  late String _currentUserName;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    fetchMessagesFromFirebase();
  }

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      // Check if the user signed in with Google
      if (_currentUser!.providerData
          .any((userInfo) => userInfo.providerId == 'google.com')) {
        // Fetch display name from Google user object
        setState(() {
          _currentUserName = _currentUser!.displayName ?? '';
        });
      } else {
        // If not signed in with Google, fetch display name from Firestore
        FirebaseFirestore.instance
            .collection('Users')
            .doc(_currentUser!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            setState(() {
              _currentUserName = documentSnapshot['firstName'];
            });
          }
        });
      }
    }
  }

  String getCurrentUserId() {
    if (_currentUser != null) {
      return _currentUser!.uid;
    } else {
      return '';
    }
  }

  void sendMessageToFirebase(ChatMessage message) {
    DatabaseReference messagesRef =
        FirebaseDatabase.instance.reference().child('messages');
    messagesRef.push().set({
      'senderId': message.senderId,
      'senderName': message.senderName,
      'messageText': message.messageText,
      'timestamp': message.timestamp.toUtc().toString(),
    }).then((_) {
      setState(() {
        _messages.add(message);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }).catchError((error) {
      print("Error sending message: $error");
    });
  }

  void fetchMessagesFromFirebase() {
    DatabaseReference messagesRef =
        FirebaseDatabase.instance.reference().child('messages');

    messagesRef.once().then((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, value) {
          String senderId = value['senderId'];
          String senderName = value['senderName'];
          String messageText = value['messageText'];
          DateTime timestamp = DateTime.parse(value['timestamp']);
          ChatMessage message = ChatMessage(
            senderId: senderId,
            senderName: senderName,
            messageText: messageText,
            timestamp: timestamp,
          );
          setState(() {
            _messages.add(message);
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        });
      }
    }).catchError((error) {
      print("Error fetching messages: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sort messages based on timestamp
    _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () {
                    _showDeleteMessageDialog(index);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment:
                          _messages[index].senderId == getCurrentUserId()
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        _messages[index].senderId != getCurrentUserId()
                            ? CircleAvatar(
                                child: Text(_messages[index]
                                    .senderName
                                    .substring(0, 1)),
                              )
                            : SizedBox(),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: _messages[index].senderId ==
                                      getCurrentUserId()
                                  ? Colors.blue
                                  : Colors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                                bottomLeft: _messages[index].senderId ==
                                        getCurrentUserId()
                                    ? Radius.circular(16.0)
                                    : Radius.circular(0.0),
                                bottomRight: _messages[index].senderId ==
                                        getCurrentUserId()
                                    ? Radius.circular(0.0)
                                    : Radius.circular(16.0),
                              ),
                            ),
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _messages[index].senderName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  _messages[index].messageText,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _messages[index].senderId == getCurrentUserId()
                            ? SizedBox(width: 8.0)
                            : SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      String userId = getCurrentUserId();
                      DateTime timestamp = DateTime.now();
                      ChatMessage message = ChatMessage(
                        senderId: userId,
                        senderName: _currentUserName,
                        messageText: messageText,
                        timestamp: timestamp,
                      );
                      sendMessageToFirebase(message);
                      _messageController.clear();
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteMessageDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Message?'),
          content: Text('Are you sure you want to delete this message?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _messages.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
