part of dash_chat_2;

/// {@category Models}
class ChatMessage {
  ChatMessage({
    required this.user,
    required this.createdAt,
    String? id,
    this.text = '',
    this.medias = const <ChatMedia>[],
    this.read,
    this.channel,
    this.facilityId,
    this.orgId,
    this.residentId,
    this.friendId,
    this.familyHubUserId,
    this.from,
    this.to,
    this.sharedByResident,
    this.likes = const <Like>[],
    this.quickReplies,
    this.customProperties,
    this.mentions,
    this.status = MessageStatus.none,
    this.replyTo,
  }) {
    this.id = id ?? const Uuid().v4().toString();
  }

  /// Create a ChatMessage instance from chat message json data
  factory ChatMessage.fromMessageJson({
    required Map<String, dynamic> jsonData,
    required String id,
  }) {
    return ChatMessage(
      id: id,
      user: ChatUser.fromJson(jsonData['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(jsonData['createdAt'].toString()).toLocal(),
      likes: jsonData
          .getValueOrDefault<List>('likes', [])
          .map(
            (x) => Like.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
      text: jsonData['text']?.toString() ?? '',
      medias: jsonData['medias'] != null
          ? (jsonData['medias'] as List<dynamic>)
              .map((dynamic media) =>
                  ChatMedia.fromJson(media as Map<String, dynamic>))
              .toList()
          : <ChatMedia>[],
      read: jsonData['read'] != null ? jsonData['read'] as bool? : false,
      channel: jsonData.getValueOrDefault<String>('channel', ''),
      facilityId: jsonData.getValueOrDefault<String>('facilityId', ''),
      orgId: jsonData.getValueOrDefault<String>('orgId', ''),
      residentId: jsonData.getValueOrDefault<String>('residentId', ''),
      friendId: jsonData.getValueOrDefault<String>('friendId', ''),
      familyHubUserId:
          jsonData.getValueOrDefault<String>('familyHubUserId', ''),
      from: jsonData.getValueOrDefault<String>('from', ''),
      to: jsonData.getValueOrDefault<String>('to', ''),
      sharedByResident:
          jsonData.getValueOrDefault<bool>('sharedByResident', false),
      quickReplies: jsonData['quickReplies'] != null
          ? (jsonData['quickReplies'] as List<dynamic>)
              .map((dynamic quickReply) =>
                  QuickReply.fromJson(quickReply as Map<String, dynamic>))
              .toList()
          : <QuickReply>[],
      customProperties: jsonData['customProperties'] as Map<String, dynamic>?,
      mentions: jsonData['mentions'] != null
          ? (jsonData['mentions'] as List<dynamic>)
              .map((dynamic mention) =>
                  Mention.fromJson(mention as Map<String, dynamic>))
              .toList()
          : <Mention>[],
      status: MessageStatus.parse(jsonData['status'].toString()),
      replyTo: jsonData['replyTo'] != null
          ? ChatMessage.fromMessageJson(
              id: id, jsonData: jsonData['replyTo'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Create a ChatMessage instance from comment json data
  factory ChatMessage.fromCommentJson({
    required Map<String, dynamic> jsonData,
    required String id,
  }) {
    return ChatMessage(
      id: id,
      user: ChatUser(
        id: jsonData['senderId']?.toString() ?? '',
        firstName: jsonData['senderName']?.toString() ?? '',
        profileImage: jsonData['senderPhotoUrl']?.toString() ?? '',
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          (jsonData['createdAt'] as Timestamp).millisecondsSinceEpoch),
      likes: jsonData
          .getValueOrDefault<List>('likes', [])
          .map(
            (x) => Like.fromMap(x as Map<String, dynamic>),
          )
          .toList(),
      text: jsonData['text']?.toString() ?? '',
      medias: jsonData['medias'] != null
          ? (jsonData['medias'] as List<dynamic>)
              .map((dynamic media) =>
                  ChatMedia.fromJson(media as Map<String, dynamic>))
              .toList()
          : <ChatMedia>[],
      read: jsonData['read'] != null ? jsonData['read'] as bool? : false,
      quickReplies: jsonData['quickReplies'] != null
          ? (jsonData['quickReplies'] as List<dynamic>)
              .map((dynamic quickReply) =>
                  QuickReply.fromJson(quickReply as Map<String, dynamic>))
              .toList()
          : <QuickReply>[],
      customProperties: jsonData['customProperties'] as Map<String, dynamic>?,
      mentions: jsonData['mentions'] != null
          ? (jsonData['mentions'] as List<dynamic>)
              .map((dynamic mention) =>
                  Mention.fromJson(mention as Map<String, dynamic>))
              .toList()
          : <Mention>[],
      status: MessageStatus.parse(jsonData['status'].toString()),
      replyTo: null,
    );
  }

  /// some custom fields for 'chat' feature
  String? channel;
  String? facilityId;
  String? orgId;
  String? residentId;
  String? friendId;
  String? familyHubUserId;
  String? from;
  String? to;

  /// This field is used when resident share media without duplicating in gallery
  bool? sharedByResident;

  /// id of message
  String? id;

  /// Text of the message (optional because you can also just send a media)
  String text;

  /// Author of the message
  ChatUser user;

  /// List of medias of the message
  List<ChatMedia>? medias;

  /// is message was seen or unseen
  bool? read;

  /// A list of quick replies that users can use to reply to this message
  List<QuickReply>? quickReplies;

  /// A list of custom properties to extend the existing ones
  /// in case you need to store more things.
  /// Can be useful to extend existing features
  Map<String, dynamic>? customProperties;

  /// Date of the message
  DateTime createdAt;

  /// likes
  List<Like> likes;

  /// Mentionned elements in the message
  List<Mention>? mentions;

  /// Status of the message TODO:
  MessageStatus? status;

  /// If the message is a reply of another one TODO:
  ChatMessage? replyTo;

  /// Convert a ChatMessage into a message json
  Map<String, dynamic> toMessageJson() {
    return <String, dynamic>{
      'id': id,
      'user': user.toJson(),
      'createdAt': createdAt.toUtc().toIso8601String(),
      'text': text,
      'read': read,
      'channel': channel,
      'facilityId': facilityId,
      'orgId': orgId,
      'residentId': residentId,
      'friendId': friendId,
      'familyHubUserId': familyHubUserId,
      'from': from,
      'to': to,
      'sharedByResident': sharedByResident,
      'likes': likes.map((Like like) => like.toMap()).toList(),
      'medias': medias?.map((ChatMedia media) => media.toJson()).toList(),
      'quickReplies': quickReplies
          ?.map((QuickReply quickReply) => quickReply.toJson())
          .toList(),
      'customProperties': customProperties,
      'mentions': mentions,
      'status': status.toString(),
      'replyTo': replyTo?.toMessageJson(),
    };
  }

  /// Convert a ChatMessage into a comment json
  Map<String, dynamic> toCommentJson() {
    return <String, dynamic>{
      'createdAt': Timestamp.fromDate(createdAt.toUtc()),
      'text': text,
      'read': read,
    };
  }
}

class MessageStatus {
  const MessageStatus._internal(this._value);
  final String _value;

  @override
  String toString() => _value;

  static MessageStatus parse(String value) {
    switch (value) {
      case 'none':
        return MessageStatus.none;
      case 'read':
        return MessageStatus.read;
      case 'received':
        return MessageStatus.received;
      case 'pending':
        return MessageStatus.pending;
      default:
        return MessageStatus.none;
    }
  }

  static const MessageStatus none = MessageStatus._internal('none');
  static const MessageStatus read = MessageStatus._internal('read');
  static const MessageStatus received = MessageStatus._internal('received');
  static const MessageStatus pending = MessageStatus._internal('pending');
}
