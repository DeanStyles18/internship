/// message : "Video Statiscs"
/// data : {"youtube_views_count":"2967","youtube_likes_count":"59","youtube_favorites_count":"0","youtube_comment_count":"0","youtube_video_publish_date":"2024-10-09T05:08:57Z"}

class ShortDetailsResponse {
  ShortDetailsResponse({
      String? message, 
      Data? data,}){
    _message = message;
    _data = data;
}

  ShortDetailsResponse.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _message;
  Data? _data;
ShortDetailsResponse copyWith({  String? message,
  Data? data,
}) => ShortDetailsResponse(  message: message ?? _message,
  data: data ?? _data,
);
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// youtube_views_count : "2967"
/// youtube_likes_count : "59"
/// youtube_favorites_count : "0"
/// youtube_comment_count : "0"
/// youtube_video_publish_date : "2024-10-09T05:08:57Z"

class Data {
  Data({
      String? youtubeViewsCount, 
      String? youtubeLikesCount, 
      String? youtubeFavoritesCount, 
      String? youtubeCommentCount, 
      String? youtubeVideoPublishDate,}){
    _youtubeViewsCount = youtubeViewsCount;
    _youtubeLikesCount = youtubeLikesCount;
    _youtubeFavoritesCount = youtubeFavoritesCount;
    _youtubeCommentCount = youtubeCommentCount;
    _youtubeVideoPublishDate = youtubeVideoPublishDate;
}

  Data.fromJson(dynamic json) {
    _youtubeViewsCount = json['youtube_views_count'].toString();
    _youtubeLikesCount = json['youtube_likes_count'].toString();
    _youtubeFavoritesCount = json['youtube_favorites_count'].toString();
    _youtubeCommentCount = json['youtube_comment_count'].toString();
    _youtubeVideoPublishDate = json['youtube_video_publish_date'].toString();
  }
  String? _youtubeViewsCount;
  String? _youtubeLikesCount;
  String? _youtubeFavoritesCount;
  String? _youtubeCommentCount;
  String? _youtubeVideoPublishDate;
Data copyWith({  String? youtubeViewsCount,
  String? youtubeLikesCount,
  String? youtubeFavoritesCount,
  String? youtubeCommentCount,
  String? youtubeVideoPublishDate,
}) => Data(  youtubeViewsCount: youtubeViewsCount ?? _youtubeViewsCount,
  youtubeLikesCount: youtubeLikesCount ?? _youtubeLikesCount,
  youtubeFavoritesCount: youtubeFavoritesCount ?? _youtubeFavoritesCount,
  youtubeCommentCount: youtubeCommentCount ?? _youtubeCommentCount,
  youtubeVideoPublishDate: youtubeVideoPublishDate ?? _youtubeVideoPublishDate,
);
  String? get youtubeViewsCount => _youtubeViewsCount;
  String? get youtubeLikesCount => _youtubeLikesCount;
  String? get youtubeFavoritesCount => _youtubeFavoritesCount;
  String? get youtubeCommentCount => _youtubeCommentCount;
  String? get youtubeVideoPublishDate => _youtubeVideoPublishDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['youtube_views_count'] = _youtubeViewsCount;
    map['youtube_likes_count'] = _youtubeLikesCount;
    map['youtube_favorites_count'] = _youtubeFavoritesCount;
    map['youtube_comment_count'] = _youtubeCommentCount;
    map['youtube_video_publish_date'] = _youtubeVideoPublishDate;
    return map;
  }

}