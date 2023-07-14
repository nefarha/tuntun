// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tun_tun/app/data/models/userModel.dart';

class ChatModel {
  String text;
  UserModel sender_account;
  UserModel recevier_account;
  DateTime send_at;
  bool isRead;
  ChatModel({
    required this.text,
    required this.sender_account,
    required this.recevier_account,
    required this.send_at,
    required this.isRead,
  });

  ChatModel copyWith({
    String? text,
    UserModel? sender_account,
    UserModel? recevier_account,
    DateTime? send_at,
    bool? isRead,
  }) {
    return ChatModel(
      text: text ?? this.text,
      sender_account: sender_account ?? this.sender_account,
      recevier_account: recevier_account ?? this.recevier_account,
      send_at: send_at ?? this.send_at,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'sender_account': sender_account.toMap(),
      'recevier_account': recevier_account.toMap(),
      'send_at': send_at.millisecondsSinceEpoch,
      'isRead': isRead,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      text: map['text'] as String,
      sender_account:
          UserModel.fromMap(map['sender_account'] as Map<String, dynamic>),
      recevier_account:
          UserModel.fromMap(map['recevier_account'] as Map<String, dynamic>),
      send_at: DateTime.fromMillisecondsSinceEpoch(map['send_at'] as int),
      isRead: map['isRead'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(text: $text, sender_account: $sender_account, recevier_account: $recevier_account, send_at: $send_at, isRead: $isRead)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.sender_account == sender_account &&
        other.recevier_account == recevier_account &&
        other.send_at == send_at &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return text.hashCode ^
        sender_account.hashCode ^
        recevier_account.hashCode ^
        send_at.hashCode ^
        isRead.hashCode;
  }
}
