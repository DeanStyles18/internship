class Autogenerated {
  String? message;
  int? totalRecords;
  int? currentRecords;
  List<Data>? data;

  Autogenerated({
    this.message,
    this.totalRecords,
    this.currentRecords,
    this.data,
  });

  Autogenerated.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    totalRecords = json['totalRecords'] as int?;
    currentRecords = json['currentRecords'] as int?;
    if (json['data'] != null) {
      data = List<Data>.from(json['data'].map((v) => Data.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'totalRecords': totalRecords,
      'currentRecords': currentRecords,
      'data': data?.map((v) => v.toJson()).toList(),
    };
  }
}

class Data {
  int? categoriesId;
  String? categoriesUuid;
  String? categoryName;
  String? categorySlug;
  String? categoryDescription;
  int? isDefaultCategory;
  String? status;
  String? createdByUuid; // Changed from Null to String?
  String? createdByName; // Changed from Null to String?
  String? modifiedByUuid; // Changed from Null to String?
  String? modifiedByName; // Changed from Null to String?
  String? createTs;

  Data({
    this.categoriesId,
    this.categoriesUuid,
    this.categoryName,
    this.categorySlug,
    this.categoryDescription,
    this.isDefaultCategory,
    this.status,
    this.createdByUuid,
    this.createdByName,
    this.modifiedByUuid,
    this.modifiedByName,
    this.createTs,
  });

  Data.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'] as int?;
    categoriesUuid = json['categories_uuid'] as String?;
    categoryName = json['category_name'] as String?;
    categorySlug = json['category_slug'] as String?;
    categoryDescription = json['category_description'] as String?;
    isDefaultCategory = json['is_default_category'] as int?;
    status = json['status'] as String?;
    createdByUuid = json['created_by_uuid'] as String?;
    createdByName = json['created_by_name'] as String?;
    modifiedByUuid = json['modified_by_uuid'] as String?;
    modifiedByName = json['modified_by_name'] as String?;
    createTs = json['create_ts'] as String?;
  }

  Map<String, dynamic> toJson() {
    return {
      'categories_id': categoriesId,
      'categories_uuid': categoriesUuid,
      'category_name': categoryName,
      'category_slug': categorySlug,
      'category_description': categoryDescription,
      'is_default_category': isDefaultCategory,
      'status': status,
      'created_by_uuid': createdByUuid,
      'created_by_name': createdByName,
      'modified_by_uuid': modifiedByUuid,
      'modified_by_name': modifiedByName,
      'create_ts': createTs,
    };
  }
}
