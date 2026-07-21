import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SmsChatScreen extends StatefulWidget {
  final String phone;
  const SmsChatScreen({super.key, required this.phone});

  @override
  State<SmsChatScreen> createState() => _SmsChatScreenState();
}

class _SmsChatScreenState extends State<SmsChatScreen> {
  final Telephony telephony = Telephony.instance;

  List<SmsMessage> chats = [];

  @override
  void initState() {
    loadConversation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phone),
      ),
      body: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: chats.length,
        itemBuilder: (context, index) {
        final sms = chats[chats.length - 1 - index];
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)),
            child: Text(sms.body ?? ''),
          ),
        );
      }),
    );
  }

  Future<void> loadConversation() async {
    final allMessages = await telephony.getInboxSms(columns: [
      SmsColumn.ID,
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
      SmsColumn.DATE,
      SmsColumn.THREAD_ID,
    ], sortOrder: [
      OrderBy(SmsColumn.DATE, sort: Sort.DESC),
    ]);

    final messages = allMessages.where((sms) {
      return sms.address == widget.phone;
    }).toList();

    setState(() {
      chats = messages;
    });
  }
}
