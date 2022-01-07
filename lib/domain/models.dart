class Art {
  Art({
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.longTitle,
    required this.principalOrFirstMaker,
    required this.hasImage,
    required this.showImage,
    required this.webImage,
    required this.headerImage,
    required this.url,
  });

  final String id;
  final String objectNumber;
  final String title;
  final String longTitle;
  final String principalOrFirstMaker;
  final bool hasImage;
  final bool showImage;
  final ArtImage webImage;
  final ArtImage headerImage;
  final String url;

  @override
  bool operator ==(covariant Art other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType && id == other.id && objectNumber == other.objectNumber;

  @override
  int get hashCode => id.hashCode ^ objectNumber.hashCode;

  @override
  String toString() =>
      'Art{id: $id, objectNumber: $objectNumber, title: $title, longTitle: $longTitle, principalOrFirstMaker: $principalOrFirstMaker, hasImage: $hasImage, showImage: $showImage, webImage: $webImage, headerImage: $headerImage, url: $url}';
}

class ArtDetail {
  ArtDetail({
    required this.id,
    required this.objectNumber,
    required this.colors,
    required this.title,
    required this.titles,
    required this.longTitle,
    required this.subTitle,
    required this.scLabelLine,
    required this.label,
    required this.description,
    required this.objectTypes,
    required this.objectCollection,
    required this.principalMaker,
    required this.principalOrFirstMaker,
    required this.principalMakers,
    required this.plaqueDescriptionEnglish,
    required this.materials,
    required this.productionPlaces,
    required this.hasImage,
    required this.showImage,
    required this.historicalPersons,
    required this.documentation,
    required this.dimensions,
    required this.physicalMedium,
    required this.webImage,
    required this.dating,
  });

  final String id;
  final String objectNumber;
  final List<ArtColor> colors;
  final String title;
  final List<String> titles;
  final String longTitle;
  final String subTitle;
  final String scLabelLine;
  final ArtLabel label;
  final String description;
  final List<String> objectTypes;
  final List<String> objectCollection;
  final String principalMaker;
  final String principalOrFirstMaker;
  final List<ArtMaker> principalMakers;
  final String plaqueDescriptionEnglish;
  final List<String> materials;
  final List<String> productionPlaces;
  final bool hasImage;
  final bool showImage;
  final List<String> historicalPersons;
  final List<String> documentation;
  final List<ArtDimension> dimensions;
  final String physicalMedium;
  final ArtImage webImage;
  final ArtDating dating;

  @override
  bool operator ==(covariant ArtDetail other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType && id == other.id && objectNumber == other.objectNumber;

  @override
  int get hashCode => id.hashCode ^ objectNumber.hashCode;

  @override
  String toString() =>
      'ArtDetail{id: $id, objectNumber: $objectNumber, colors: $colors, title: $title, titles: $titles, longTitle: $longTitle, subTitle: $subTitle, scLabelLine: $scLabelLine, label: $label, description: $description, objectTypes: $objectTypes, objectCollection: $objectCollection, principalMaker: $principalMaker, principalOrFirstMaker: $principalOrFirstMaker, principalMakers: $principalMakers, plaqueDescriptionEnglish: $plaqueDescriptionEnglish, materials: $materials, productionPlaces: $productionPlaces, hasImage: $hasImage, showImage: $showImage, historicalPersons: $historicalPersons, documentation: $documentation, dimensions: $dimensions, physicalMedium: $physicalMedium, webImage: $webImage, dating: $dating}';
}

class ArtImage {
  ArtImage({required this.guid, required this.url, required this.width, required this.height});

  final String guid;
  final String url;
  final int width;
  final int height;

  @override
  bool operator ==(covariant ArtImage other) =>
      identical(this, other) || runtimeType == other.runtimeType && guid == other.guid;

  @override
  int get hashCode => guid.hashCode;

  @override
  String toString() => 'ArtImage{guid: $guid, url: $url, width: $width, height: $height}';
}

class ArtMaker {
  ArtMaker({
    required this.name,
    required this.bio,
    required this.unFixedName,
    required this.nationality,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.placeOfDeath,
    required this.dateOfDeath,
    required this.labelDesc,
    required this.occupation,
    required this.roles,
  });

  final String name;
  final String? bio;
  final String unFixedName;
  final String nationality;
  final String placeOfBirth;
  final DateTime dateOfBirth;
  final String? placeOfDeath;
  final DateTime? dateOfDeath;
  final String? labelDesc;
  final List<String> occupation;
  final List<String> roles;

  @override
  bool operator ==(covariant ArtMaker other) =>
      identical(this, other) || runtimeType == other.runtimeType && name == other.name && bio == other.bio;

  @override
  int get hashCode => name.hashCode ^ bio.hashCode;

  @override
  String toString() =>
      'ArtMaker{name: $name, bio: $bio, unFixedName: $unFixedName, nationality: $nationality, placeOfBirth: $placeOfBirth, dateOfBirth: $dateOfBirth, placeOfDeath: $placeOfDeath, dateOfDeath: $dateOfDeath, labelDesc: $labelDesc, occupation: $occupation, roles: $roles}';
}

class ArtDimension {
  ArtDimension({required this.unit, required this.type, required this.value});

  final String unit;
  final String type;
  final double value;

  @override
  bool operator ==(covariant ArtDimension other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType && unit == other.unit && type == other.type && value == other.value;

  @override
  int get hashCode => unit.hashCode ^ type.hashCode ^ value.hashCode;

  @override
  String toString() => 'ArtDimension{unit: $unit, type: $type, value: $value}';
}

class ArtColor {
  ArtColor({required this.percentage, required this.hex});

  final double percentage;
  final String hex;

  @override
  bool operator ==(covariant ArtColor other) =>
      identical(this, other) || runtimeType == other.runtimeType && percentage == other.percentage && hex == other.hex;

  @override
  int get hashCode => percentage.hashCode ^ hex.hashCode;

  @override
  String toString() => 'ArtColor{percentage: $percentage, hex: $hex}';
}

class ArtDating {
  ArtDating({
    required this.presentingDate,
    required this.sortingDate,
    required this.period,
    required this.yearEarly,
    required this.yearLate,
  });

  final int presentingDate;
  final int sortingDate;
  final int period;
  final int yearEarly;
  final int yearLate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtDating &&
          runtimeType == other.runtimeType &&
          presentingDate == other.presentingDate &&
          sortingDate == other.sortingDate &&
          period == other.period &&
          yearEarly == other.yearEarly &&
          yearLate == other.yearLate;

  @override
  int get hashCode =>
      presentingDate.hashCode ^ sortingDate.hashCode ^ period.hashCode ^ yearEarly.hashCode ^ yearLate.hashCode;

  @override
  String toString() =>
      'ArtDating{presentingDate: $presentingDate, sortingDate: $sortingDate, period: $period, yearEarly: $yearEarly, yearLate: $yearLate}';
}

class ArtLabel {
  ArtLabel({
    required this.title,
    required this.makerLine,
    required this.description,
    required this.notes,
    required this.date,
  });

  final String title;
  final String makerLine;
  final String description;
  final String notes;
  final DateTime date;

  @override
  bool operator ==(covariant ArtLabel other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          title == other.title &&
          makerLine == other.makerLine &&
          description == other.description &&
          notes == other.notes &&
          date == other.date;

  @override
  int get hashCode => title.hashCode ^ makerLine.hashCode ^ description.hashCode ^ notes.hashCode ^ date.hashCode;

  @override
  String toString() =>
      'ArtLabel{title: $title, makerLine: $makerLine, description: $description, notes: $notes, date: $date}';
}
