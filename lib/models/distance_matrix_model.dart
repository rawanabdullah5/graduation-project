class DistanceMatrixResponse
{
  final List<DistanceMatrixRow> rows;

  DistanceMatrixResponse({required this.rows});

  factory DistanceMatrixResponse.fromJson(Map<String, dynamic> json) {
    List<DistanceMatrixRow> rows = [];
    if (json['rows'] != null)
    {
      json['rows'].forEach((row) {
        rows.add(DistanceMatrixRow.fromJson(row));
      });
    }
    return DistanceMatrixResponse(rows: rows);
  }
}

class DistanceMatrixRow {
  final List<DistanceMatrixElement> elements;

  DistanceMatrixRow({required this.elements});

  factory DistanceMatrixRow.fromJson(Map<String, dynamic> json)
  {
    List<DistanceMatrixElement> elements = [];
    if (json['elements'] != null)
    {
      json['elements'].forEach((element) {
        elements.add(DistanceMatrixElement.fromJson(element));
      });
    }

    return DistanceMatrixRow(elements: elements);
  }
}

class DistanceMatrixElement
{
  final Distance distance;
  final Duration duration;

  DistanceMatrixElement({required this.distance,
    required this.duration});

  factory DistanceMatrixElement.fromJson(Map<String, dynamic> json)
  {
    return DistanceMatrixElement(
      distance: Distance.fromJson(json['distance']),
      duration: Duration.fromJson(json['duration']),
    );
  }
}

class Distance {
  final String text;
  Distance({required this.text});
  factory Distance.fromJson(Map<String, dynamic> json)
  {
    return Distance(
      text: json['text'],
    );
  }
}

class Duration {
  final String text;

  Duration({required this.text});

  factory Duration.fromJson(Map<String, dynamic> json) {
    return Duration(
      text: json['text'],
    );
  }
}
