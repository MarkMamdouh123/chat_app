import 'package:scholar_chat/constants.dart';

class MessageModel {
  final String message;
  final String id;

  MessageModel({required this.id, required this.message});

  factory MessageModel.fromJson(json) {
    return MessageModel(message: json[kMessageDocument], id: json[kID]);
  }
}
