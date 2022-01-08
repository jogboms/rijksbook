import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class Art with _$Art {
  const factory Art({
    required String id,
    required String objectNumber,
    required String title,
    required String longTitle,
    required String principalOrFirstMaker,
    required bool hasImage,
    required bool showImage,
    required ArtImage webImage,
    required ArtImage headerImage,
    required ArtLinks links,
  }) = _Art;

  factory Art.fromJson(Map<String, dynamic> json) => _$ArtFromJson(json);
}

@freezed
class ArtDetail with _$ArtDetail {
  const factory ArtDetail({
    required String id,
    required String objectNumber,
    required List<ArtColor> colors,
    required List<ArtColor> normalizedColors,
    required String title,
    required List<String> titles,
    required String longTitle,
    required String subTitle,
    required String scLabelLine,
    required ArtLabel label,
    required String description,
    required List<String> objectTypes,
    required List<String> objectCollection,
    required String principalMaker,
    required String principalOrFirstMaker,
    required List<ArtMaker> principalMakers,
    required String? plaqueDescriptionEnglish,
    required List<String> materials,
    required List<String> productionPlaces,
    required List<String> techniques,
    required List<String> physicalProperties,
    required bool hasImage,
    required bool showImage,
    required List<String> historicalPersons,
    required List<String> documentation,
    required List<ArtDimension> dimensions,
    required String physicalMedium,
    required ArtImage webImage,
    required ArtDating dating,
  }) = _ArtDetail;

  factory ArtDetail.fromJson(Map<String, dynamic> json) => _$ArtDetailFromJson(json);
}

@freezed
class ArtColor with _$ArtColor {
  const factory ArtColor({required double percentage, required String hex}) = _ArtColor;

  factory ArtColor.fromJson(Map<String, dynamic> json) => _$ArtColorFromJson(json);
}

extension ArtColorExtension on ArtColor {
  int? get hexAsInt => int.tryParse('ff${hex.replaceAll('#', '').trim()}', radix: 16);
}

@freezed
class ArtDating with _$ArtDating {
  const factory ArtDating({
    required String presentingDate,
    required int sortingDate,
    required int period,
    required int yearEarly,
    required int yearLate,
  }) = _ArtDating;

  factory ArtDating.fromJson(Map<String, dynamic> json) => _$ArtDatingFromJson(json);
}

@freezed
class ArtDimension with _$ArtDimension {
  const factory ArtDimension({
    required String unit,
    required String type,
    @JsonKey(fromJson: stringToDoubleParser) required double value,
    String? part,
  }) = _ArtDimension;

  factory ArtDimension.fromJson(Map<String, dynamic> json) => _$ArtDimensionFromJson(json);
}

@freezed
class ArtLabel with _$ArtLabel {
  const factory ArtLabel({
    required String? title,
    required String? makerLine,
    required String? description,
    required String? notes,
    required DateTime date,
  }) = _ArtLabel;

  factory ArtLabel.fromJson(Map<String, dynamic> json) => _$ArtLabelFromJson(json);
}

@freezed
class ArtLinks with _$ArtLinks {
  const factory ArtLinks({String? web, String? self, String? search}) = _ArtLinks;

  factory ArtLinks.fromJson(Map<String, dynamic> json) => _$ArtLinksFromJson(json);
}

@freezed
class ArtMaker with _$ArtMaker {
  const factory ArtMaker({
    required String name,
    required String unFixedName,
    String? placeOfBirth,
    @JsonKey(fromJson: stringToDateParser) required DateTime dateOfBirth,
    @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfDeath,
    String? placeOfDeath,
    required List<String> occupation,
    required List<String> roles,
    String? nationality,
    String? biography,
    required String labelDesc,
  }) = _ArtMaker;

  factory ArtMaker.fromJson(Map<String, dynamic> json) => _$ArtMakerFromJson(json);
}

extension ArtMakerExtension on ArtMaker {
  String get initials => unFixedName.split(' ').take(2).map((String element) => element[0].toUpperCase()).join('.');
}

@freezed
class ArtImage with _$ArtImage {
  const factory ArtImage({required String guid, required int width, required int height, required String url}) =
      _ArtImage;

  factory ArtImage.fromJson(Map<String, dynamic> json) => _$ArtImageFromJson(json);
}

extension ArtImageExtension on ArtImage {
  double get aspectRatio => width / height;
}

@visibleForTesting
double stringToDoubleParser(String value) => double.tryParse(value) ?? 0.0;

@visibleForTesting
DateTime stringToDateParser(String value) {
  final List<String> parts = value.split('-');
  if (parts.length == 3) {
    return DateTime.parse(value);
  }
  final String? month = parts.elementAtOrNull(1);
  final String? day = parts.elementAtOrNull(2);
  return DateTime(
    int.tryParse(parts[0].replaceAll(RegExp('[^0-9]'), '')) ?? 0,
    month != null ? int.tryParse(month) ?? 1 : 1,
    day != null ? int.tryParse(day) ?? 1 : 1,
  );
}

@visibleForTesting
DateTime? stringToDateNullableParser([String? value]) => value == null ? null : stringToDateParser(value);

extension ListExtension<E> on List<E> {
  @visibleForTesting
  E? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } catch (_) {
      return null;
    }
  }
}
