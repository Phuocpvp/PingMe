import 'dart:convert';

class ChatDTO {
  String? id; // Thêm trường id
  String? chatName;
  String? avatar;
  ChatType chatType;
  bool isDeleted;
  List<GroupChatMember>? groupChat;

  ChatDTO({
    this.id, // Khởi tạo id
    this.chatName,
    this.avatar,
    this.chatType = ChatType.PERSONAL,
    this.isDeleted = false,
    this.groupChat,
  });

  factory ChatDTO.fromJson(Map<String, dynamic> json) {
    return ChatDTO(
      id: json['_id'], // Gán id từ JSON
      chatName: json['ChatName'],
      avatar: json['Avatar'],
      chatType: ChatType.values.firstWhere(
          (e) => e.toString() == 'ChatType.${json['ChatType']}',
          orElse: () => ChatType.PERSONAL),
      isDeleted: json['IsDeleted'] ?? false,
      groupChat: (json['GroupChat'] as List<dynamic>?)
          ?.map((e) => GroupChatMember.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Thêm id vào JSON
      'ChatName': chatName,
      'Avatar': avatar,
      'ChatType': chatType.toString().split('.').last,
      'IsDeleted': isDeleted,
      'GroupChat': groupChat?.map((e) => e.toJson()).toList(),
    };
  }
}

enum ChatType {
  PERSONAL,
  GROUP,
}

class GroupChatMember {
  String userId;
  String role;

  GroupChatMember({
    required this.userId,
    required this.role,
  });

  factory GroupChatMember.fromJson(Map<String, dynamic> json) {
    return GroupChatMember(
      userId: json['userId'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'role': role,
    };
  }
}
