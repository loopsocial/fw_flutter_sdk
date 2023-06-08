import 'package:json_annotation/json_annotation.dart';

part 'app_language_info.g.dart';

@JsonSerializable()
class AppLanguageInfo {
  String? language;
  String? displayName;

  AppLanguageInfo({
    this.language,
    this.displayName,
  });

  factory AppLanguageInfo.fromJson(Map<String, dynamic> json) =>
      _$AppLanguageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppLanguageInfoToJson(this);
}
