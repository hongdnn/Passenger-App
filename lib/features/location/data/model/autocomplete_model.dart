import 'package:json_annotation/json_annotation.dart';
part 'autocomplete_model.g.dart';

@JsonSerializable()
class GgAutoComplete {
  GgAutoComplete({
    this.predictions,
    this.status,
  });

  factory GgAutoComplete.fromJson(Map<String, dynamic> json) =>
      _$GgAutoCompleteFromJson(json);

  @JsonKey(name: 'predictions')
  List<Prediction>? predictions;

  @JsonKey(name: 'status')
  String? status;

  Map<String, dynamic> toJson() => _$GgAutoCompleteToJson(this);
}

@JsonSerializable()
class Prediction {
  Prediction({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'matched_substrings')
  List<MatchedSubstring>? matchedSubstrings;

  @JsonKey(name: 'place_id')
  String? placeId;

  @JsonKey(name: 'reference')
  String? reference;

  @JsonKey(name: 'structured_formatting')
  StructuredFormatting? structuredFormatting;

  @JsonKey(name: 'terms')
  List<Term>? terms;

  @JsonKey(name: 'types')
  List<String>? types;

  Map<String, dynamic> toJson() => _$PredictionToJson(this);

  String get getMainText => structuredFormatting?.mainText ?? '';
  String get getSecondaryText => structuredFormatting?.secondaryText ?? '';
}

@JsonSerializable()
class MatchedSubstring {
  MatchedSubstring({
    this.length,
    this.offset,
  });

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringFromJson(json);

  @JsonKey(name: 'length')
  int? length;
  @JsonKey(name: 'offset')
  int? offset;

  Map<String, dynamic> toJson() => _$MatchedSubstringToJson(this);
}

@JsonSerializable()
class StructuredFormatting {
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  @JsonKey(name: 'main_text')
  String? mainText;

  @JsonKey(name: 'main_text_matched_substrings')
  List<MatchedSubstring>? mainTextMatchedSubstrings;

  @JsonKey(name: 'secondary_text')
  String? secondaryText;

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}

@JsonSerializable()
class Term {
  Term({
    this.offset,
    this.value,
  });

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);

  @JsonKey(name: 'offset')
  int? offset;
  @JsonKey(name: 'value')
  String? value;

  Map<String, dynamic> toJson() => _$TermToJson(this);
}
