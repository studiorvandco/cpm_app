import '../sequence/sequence.dart';

class Episode {
  final String id;
  final int number;
  String title;
  String description;
  final String? director;
  final String? writer;
  final List<Sequence> sequences;

  Episode({
    required this.id,
    required this.number,
    required this.title,
    required this.description,
    this.director,
    this.writer,
    required this.sequences,
  });

  factory Episode.fromJson(json) {
    final sequencesJson = json['Sequences'];
    final List<Sequence> sequences =
        sequencesJson.map<Sequence>((sequence) => Sequence.fromJson(sequence)).toList() as List<Sequence>;

    return Episode(
      id: json['Id'].toString(),
      number: json['Number'] as int,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      sequences: sequences,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.isEmpty ? null : id,
      'number': number,
      'title': title,
      'description': description,
      'director': director ?? '',
      'writer': writer ?? '',
      'sequences': sequences,
    };
  }
}
