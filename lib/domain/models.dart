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
    required this.titles,
    required this.longTitle,
    required this.subTitle,
    required this.scLabelLine,
    required this.label,
    required this.description,
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
  });

  final String id;
  final String objectNumber;
  final List<ArtColor> colors;
  final List<String> titles;
  final String longTitle;
  final String subTitle;
  final String scLabelLine;
  final ArtLabel label;
  final String description;
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

  @override
  bool operator ==(covariant ArtDetail other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType && id == other.id && objectNumber == other.objectNumber;

  @override
  int get hashCode => id.hashCode ^ objectNumber.hashCode;

  @override
  String toString() =>
      'ArtDetail{id: $id, objectNumber: $objectNumber, colors: $colors, titles: $titles, longTitle: $longTitle, subTitle: $subTitle, scLabelLine: $scLabelLine, label: $label, description: $description, principalMaker: $principalMaker, principalOrFirstMaker: $principalOrFirstMaker, principalMakers: $principalMakers, plaqueDescriptionEnglish: $plaqueDescriptionEnglish, materials: $materials, productionPlaces: $productionPlaces, hasImage: $hasImage, showImage: $showImage, historicalPersons: $historicalPersons, documentation: $documentation, dimensions: $dimensions, physicalMedium: $physicalMedium}';
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
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.placeOfDeath,
    required this.dateOfDeath,
    required this.labelDesc,
  });

  final String name;
  final String? bio;
  final String unFixedName;
  final String placeOfBirth;
  final String dateOfBirth;
  final String placeOfDeath;
  final String dateOfDeath;
  final String labelDesc;

  @override
  bool operator ==(covariant ArtMaker other) =>
      identical(this, other) || runtimeType == other.runtimeType && name == other.name && bio == other.bio;

  @override
  int get hashCode => name.hashCode ^ bio.hashCode;

  @override
  String toString() =>
      'ArtMaker{name: $name, bio: $bio, unFixedName: $unFixedName, placeOfBirth: $placeOfBirth, dateOfBirth: $dateOfBirth, placeOfDeath: $placeOfDeath, dateOfDeath: $dateOfDeath, labelDesc: $labelDesc}';
}

class ArtDimension {
  ArtDimension({required this.unit, required this.type, required this.part, required this.value});

  final String unit;
  final String type;
  final String? part;
  final String value;

  @override
  bool operator ==(covariant ArtDimension other) =>
      identical(this, other) ||
      runtimeType == other.runtimeType &&
          unit == other.unit &&
          type == other.type &&
          part == other.part &&
          value == other.value;

  @override
  int get hashCode => unit.hashCode ^ type.hashCode ^ part.hashCode ^ value.hashCode;

  @override
  String toString() => 'ArtDimension{unit: $unit, type: $type, part: $part, value: $value}';
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
  final String date;

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
