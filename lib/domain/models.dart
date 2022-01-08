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
    @JsonKey(fromJson: _stringToDoubleParser) required double value,
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
    required String? placeOfBirth,
    @JsonKey(fromJson: _dateOfBirthParser) required DateTime dateOfBirth,
    @JsonKey(fromJson: _dateOfBirthNullableParser) required DateTime? dateOfDeath,
    required String? placeOfDeath,
    required List<String> occupation,
    required List<String> roles,
    required String? nationality,
    required String? biography,
    required String labelDesc,
  }) = _ArtMaker;

  factory ArtMaker.fromJson(Map<String, dynamic> json) => _$ArtMakerFromJson(json);
}

@freezed
class ArtImage with _$ArtImage {
  const factory ArtImage({required String guid, required int width, required int height, required String url}) =
      _ArtImage;

  factory ArtImage.fromJson(Map<String, dynamic> json) => _$ArtImageFromJson(json);
}

double _stringToDoubleParser(String value) => double.parse(value);

DateTime _dateOfBirthParser(String value) {
  final List<String> parts = value.split('-');
  if (parts.length == 3) {
    return DateTime.parse(value);
  }
  final String? month = parts.elementAtOrNull(1);
  final String? day = parts.elementAtOrNull(2);
  return DateTime(
    int.parse(parts[0]),
    month != null ? int.parse(month) : 0,
    day != null ? int.parse(day) : 0,
  );
}

DateTime? _dateOfBirthNullableParser(String? value) => value == null ? null : _dateOfBirthParser(value);

extension ListExtension<E> on List<E> {
  E? elementAtOrNull(int index) {
    try {
      return elementAt(index);
    } catch (_) {
      return null;
    }
  }
}
