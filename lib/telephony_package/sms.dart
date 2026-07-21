import 'package:telephony/telephony.dart';

class SmsService {
  final Telephony telephony = Telephony.instance;

  Future<List<SmsMessage>> getAllMessages() async {
    bool? granted = await telephony.requestPhoneAndSmsPermissions;

    if (granted != true) {
      return [];
    }

    final messages = await telephony.getInboxSms(columns: [
      SmsColumn.ID,
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
      SmsColumn.DATE,
      SmsColumn.THREAD_ID,
    ], sortOrder: [
      OrderBy(SmsColumn.DATE, sort: Sort.DESC),
    ]);
    return messages;
  }
}
