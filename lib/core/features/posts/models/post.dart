import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @JsonKey(name: '_id', includeToJson: false) String? id,
    required String title,
    required String content,
    String? imageUrl,
    Map<String, dynamic>? creator,
    @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
