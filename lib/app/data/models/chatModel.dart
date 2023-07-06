// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tun_tun/app/data/models/userModel.dart';

class ChatModel {
  String id;
  String text;
  UserModel sender_account;
  UserModel recevier_account;
  DateTime send_at;
  ChatModel({
    required this.id,
    required this.text,
    required this.sender_account,
    required this.recevier_account,
    required this.send_at,
  });

  ChatModel copyWith({
    String? id,
    String? text,
    UserModel? sender_account,
    UserModel? recevier_account,
    DateTime? send_at,
  }) {
    return ChatModel(
      id: id ?? this.id,
      text: text ?? this.text,
      sender_account: sender_account ?? this.sender_account,
      recevier_account: recevier_account ?? this.recevier_account,
      send_at: send_at ?? this.send_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'sender_account': sender_account.toMap(),
      'recevier_account': recevier_account.toMap(),
      'send_at': send_at.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      text: map['text'] as String,
      sender_account:
          UserModel.fromMap(map['sender_account'] as Map<String, dynamic>),
      recevier_account:
          UserModel.fromMap(map['recevier_account'] as Map<String, dynamic>),
      send_at: DateTime.fromMillisecondsSinceEpoch(map['send_at'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, text: $text, sender_account: $sender_account, recevier_account: $recevier_account, send_at: $send_at)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.sender_account == sender_account &&
        other.recevier_account == recevier_account &&
        other.send_at == send_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        sender_account.hashCode ^
        recevier_account.hashCode ^
        send_at.hashCode;
  }
}
