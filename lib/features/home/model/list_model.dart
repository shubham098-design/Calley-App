class ListModel {
  final String id;
  final String name;
  final List<dynamic> agents;
  final String clientId;

  ListModel({
    required this.id,
    required this.name,
    required this.agents,
    required this.clientId,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      agents: json['agents'] ?? [],
      clientId: json['clientId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'agents': agents,
      'clientId': clientId,
    };
  }
}
