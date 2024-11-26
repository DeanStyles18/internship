class Data {
  int? finalVideoPageId;
  String? artist;
  String? title;
  String? youtubeDescription;
  String? youtubeLink;
  String? youtubeTags;
  String? categories;
  String? smallImg;
  String? mediumImg;
  String? largeImg;
  String? standardImg;
  String? maxresImg;
  String? slug;
  String? youtubePublishDate;
  int? viewPageCount;
  int? youtubeViewCount;
  int? youtubeLikeCount;
  String? lyrics;
  String? originalCredits;
  String? artistSlug;
  int? viewCount;
  int? likeCount;
  int? favoriteCount;
  int? commentCount;
  String? duration;
  String? definition;
  String? caption;
  String? insertDt;

  Data({
    this.finalVideoPageId,
    this.artist,
    this.title,
    this.youtubeDescription,
    this.youtubeLink,
    this.youtubeTags,
    this.categories,
    this.smallImg,
    this.mediumImg,
    this.largeImg,
    this.standardImg,
    this.maxresImg,
    this.slug,
    this.youtubePublishDate,
    this.viewPageCount,
    this.youtubeViewCount,
    this.youtubeLikeCount,
    this.lyrics,
    this.originalCredits,
    this.artistSlug,
    this.viewCount,
    this.likeCount,
    this.favoriteCount,
    this.commentCount,
    this.duration,
    this.definition,
    this.caption,
    this.insertDt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    finalVideoPageId = json['final_video_page_id'] is int
        ? json['final_video_page_id'] as int
        : int.tryParse(json['final_video_page_id'] as String? ?? '');
    artist = json['artist'];
    title = json['title'];
    youtubeDescription = json['youtube_description'];
    youtubeLink = json['youtube_link'];
    youtubeTags = json['youtube_tags'];
    categories = json['categories'];
    smallImg = json['small_img'];
    mediumImg = json['medium_img'];
    largeImg = json['large_img'];
    standardImg = json['standard_img'];
    maxresImg = json['maxres_img'];
    slug = json['slug'];
    youtubePublishDate = json['youtube_publish_date'];
    viewPageCount = json['view_page_count'] is int
        ? json['view_page_count'] as int
        : int.tryParse(json['view_page_count'] as String? ?? '');
    youtubeViewCount = json['youtube_view_count'] is int
        ? json['youtube_view_count'] as int
        : int.tryParse(json['youtube_view_count'] as String? ?? '');
    youtubeLikeCount = json['youtube_like_count'] is int
        ? json['youtube_like_count'] as int
        : int.tryParse(json['youtube_like_count'] as String? ?? '');
    lyrics = json['lyrics'];
    originalCredits = json['original_credits'];
    artistSlug = json['artist_slug'];
    viewCount = json['view_count'] is int
        ? json['view_count'] as int
        : int.tryParse(json['view_count'] as String? ?? '');
    likeCount = json['like_count'] is int
        ? json['like_count'] as int
        : int.tryParse(json['like_count'] as String? ?? '');
    favoriteCount = json['favorite_count'] is int
        ? json['favorite_count'] as int
        : int.tryParse(json['favorite_count'] as String? ?? '');
    commentCount = json['comment_count'] is int
        ? json['comment_count'] as int
        : int.tryParse(json['comment_count'] as String? ?? '');
    duration = json['duration'];
    definition = json['definition'];
    caption = json['caption'];
    insertDt = json['insert_dt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['final_video_page_id'] = this.finalVideoPageId;
    data['artist'] = this.artist;
    data['title'] = this.title;
    data['youtube_description'] = this.youtubeDescription;
    data['youtube_link'] = this.youtubeLink;
    data['youtube_tags'] = this.youtubeTags;
    data['categories'] = this.categories;
    data['small_img'] = this.smallImg;
    data['medium_img'] = this.mediumImg;
    data['large_img'] = this.largeImg;
    data['standard_img'] = this.standardImg;
    data['maxres_img'] = this.maxresImg;
    data['slug'] = this.slug;
    data['youtube_publish_date'] = this.youtubePublishDate;
    data['view_page_count'] = this.viewPageCount;
    data['youtube_view_count'] = this.youtubeViewCount;
    data['youtube_like_count'] = this.youtubeLikeCount;
    data['lyrics'] = this.lyrics;
    data['original_credits'] = this.originalCredits;
    data['artist_slug'] = this.artistSlug;
    data['view_count'] = this.viewCount;
    data['like_count'] = this.likeCount;
    data['favorite_count'] = this.favoriteCount;
    data['comment_count'] = this.commentCount;
    data['duration'] = this.duration;
    data['definition'] = this.definition;
    data['caption'] = this.caption;
    data['insert_dt'] = this.insertDt;
    return data;
  }
}
