
class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final int time;

  MessageModel({
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      time: map['time'] as int,
    );
  }
}
