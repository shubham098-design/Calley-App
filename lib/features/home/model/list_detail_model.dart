class CallItem {
  final String firstName;
  final String lastName;
  final String title;
  final int phone;
  final int otherPhone1;
  final int otherPhone2;
  final int otherPhone3;
  final int otherPhone4;
  final String email;
  final String address;
  final String company;
  final int age;
  final int zip;
  final String maritalStatus;
  final String notes;
  final String calledAt;
  final String rescheduledAt;
  final String createdAt;
  final String status;
  final String agentName;
  final String agentId;
  final int duration;
  final String feedback;

  CallItem({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.phone,
    required this.otherPhone1,
    required this.otherPhone2,
    required this.otherPhone3,
    required this.otherPhone4,
    required this.email,
    required this.address,
    required this.company,
    required this.age,
    required this.zip,
    required this.maritalStatus,
    required this.notes,
    required this.calledAt,
    required this.rescheduledAt,
    required this.createdAt,
    required this.status,
    required this.agentName,
    required this.agentId,
    required this.duration,
    required this.feedback,
  });

  factory CallItem.fromJson(Map<String, dynamic> json) {
    return CallItem(
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      title: json['Title'] ?? '',
      phone: json['Phone'] ?? 0,
      otherPhone1: json['Other Phone 1'] ?? 0,
      otherPhone2: json['Other Phone 2'] ?? 0,
      otherPhone3: json['Other Phone 3'] ?? 0,
      otherPhone4: json['Other Phone 4'] ?? 0,
      email: json['Email'] ?? '',
      address: json['Address'] ?? '',
      company: json['Company'] ?? '',
      age: json['Age'] ?? 0,
      zip: json['Zip'] ?? 0,
      maritalStatus: json['MaritalStatus'] ?? '',
      notes: json['Notes'] ?? '',
      calledAt: json['calledAt'] ?? '',
      rescheduledAt: json['rescheduledAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      status: json['status'] ?? '',
      agentName: json['agentName'] ?? '',
      agentId: json['agentId'] ?? '',
      duration: json['duration'] ?? 0,
      feedback: json['feedback'] ?? '',
    );
  }
}

class ListDetailsModel {
  final int pending;
  final int called;
  final int rescheduled;
  final List<CallItem> calls;

  ListDetailsModel({
    required this.pending,
    required this.called,
    required this.rescheduled,
    required this.calls,
  });

  factory ListDetailsModel.fromJson(Map<String, dynamic> json) {
    var callsList = (json['calls'] as List<dynamic>? ?? [])
        .map((item) => CallItem.fromJson(item))
        .toList();

    return ListDetailsModel(
      pending: json['pending'] ?? 0,
      called: json['called'] ?? 0,
      rescheduled: json['rescheduled'] ?? 0,
      calls: callsList,
    );
  }
}
