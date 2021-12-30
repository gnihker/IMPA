import 'package:cloud_firestore/cloud_firestore.dart';

class Detail {
  final String method;
  final String route;
  final String key;
  final String imgType;
  final String description;

  Detail({
    required this.method,
    required this.route,
    required this.key,
    required this.imgType,
    required this.description,
  });

  factory Detail.fromJson(dynamic json) {
    return Detail(
      method: json['method'] as String,
      route: json['route'] as String,
      key: json['key'] as String,
      imgType: json['imgType'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'method': method,
      'route': route,
      'key': key,
      'imgType': imgType,
      'description': description,
    };
  }

  static Detail fromMap(Map<String, dynamic> map) {
    return Detail(
      method: map['method'],
      route: map['route'],
      key: map['key'],
      imgType: map['imgType'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return 'Detail { method: $method, route: $route, key: $key, imgType: $imgType, description: $description}';
  }
}

class Model {
  final Detail detail;
  final String detailRoute;
  final String label;

  const Model({
    required this.detail,
    required this.detailRoute,
    required this.label,
  });

  factory Model.fromJson(dynamic json) {
    return Model(
      detail: json['detail'] as Detail,
      detailRoute: json['detailRoute'] as String,
      label: json['label'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail,
      'detailRoute': detailRoute,
      'label': label,
    };
  }

  static Model fromMap(Map<String, dynamic> map) {
    return Model(
      detail: map['detail'],
      detailRoute: map['detailRoute'],
      label: map['label'],
    );
  }

  factory Model.fromDocument(DocumentSnapshot documentSnapshot) {
    return Model(
      detail: documentSnapshot['detail'],
      detailRoute: documentSnapshot['detailRoute'],
      label: documentSnapshot['label'],
    );
  }

  @override
  String toString() {
    return 'Detail { detail: $detail, detailRoute: $detailRoute, label: $label}';
  }
}
