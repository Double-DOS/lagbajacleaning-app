class CleaningSession {
  final String uid;
  final String location;
  final String subscription;
  final String apartmentType;
  final double totalCost;
  final int rating;
  final bool isRated;
  final bool isPaid;
  final bool isCompleted;
  final String userUid;
  final String cleaningDay;
  final DateTime cleaningDate;
  final DateTime orderDate;

  CleaningSession(
      {this.uid,
      this.userUid,
      this.location,
      this.subscription, //"One-Off", "Weekly", "Monthly", "Bi-Weekly"
      this.apartmentType,
      this.rating,
      this.totalCost,
      this.isRated,
      this.isCompleted,
      this.isPaid,
      this.cleaningDay,
      this.cleaningDate,
      this.orderDate});
  factory CleaningSession.initialData() {
    return CleaningSession(
        userUid: '',
        location: '25, Ademolekun street, Ikeja.',
        totalCost: 5000.0,
        subscription: "One-Off",
        apartmentType: "Single room",
        isRated: false,
        rating: 0,
        isPaid: false,
        cleaningDay: 'Tuesday',
        isCompleted: false,
        cleaningDate: DateTime.now().add(Duration(days: 1)),
        orderDate: DateTime.now());
  }
}

class SessionOverview {
  final String completed;
  final String pending;
  final String total;

  SessionOverview({this.completed, this.pending, this.total});
}

class CompletedSessionOverview {
  final String completed;

  CompletedSessionOverview({
    this.completed,
  });

  factory CompletedSessionOverview.initialData() {
    return CompletedSessionOverview(completed: '0');
  }
}

class PendingSessionOverview {
  final String pending;
  // final String total;

  PendingSessionOverview({
    this.pending,
  });

  factory PendingSessionOverview.initialData() {
    return PendingSessionOverview(pending: '0');
  }
}

class TotalSessionOverview {
  final String total;

  TotalSessionOverview({
    this.total,
  });

  factory TotalSessionOverview.initialData() {
    return TotalSessionOverview(total: '0');
  }
}
