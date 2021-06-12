import 'package:flutter/material.dart';

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
  final DateTime cleaningDate;
  final DateTime orderDate;

  CleaningSession(
      {this.uid,
      this.userUid,
      this.location,
      this.subscription, //"One-Off", "Weekly", "Monthly", "Bi-Weekly"
      this.apartmentType, //"One-Off", "Weekly", "Monthly", "Bi-Weekly"
      this.rating,
      this.totalCost,
      this.isRated,
      this.isCompleted,
      this.isPaid,
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
        isCompleted: false,
        cleaningDate: DateTime(2021, 5, 30),
        orderDate: DateTime(2021, 5, 29));
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
