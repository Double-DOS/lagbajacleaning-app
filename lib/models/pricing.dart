/*
* Basic Single Room - 4500
* Self-Contain Room(Personal Kitchen and Toilet) - 6000
* Room and Parlour Self-Contain - 8000
* 2 bedroom apartment - 12000
* 3 bedroom apartment - 17000
* 4 bedroom apartment - 23000
* Event Centers - Price is stated after inspection
*/

class SecretKey {
  final key;
  SecretKey(this.key);
}

class PricingList {
  double singleRoom = 4000.0;
  double singleSelfContainRoom = 6000.0;
  double roomAndParlourSelfContain = 8000.0;
  double twoBedroom = 13500.0;
  double threeBedroom = 20500.0;
  double fourBedroom = 23500.0;
  double duplex = 35000.0;
}

class CleaningLevels {
  double mild = 0.0;
  double standard = 2000;
  double deep = 4500;
}

class SubscriptionPlans {
  double weeklyPlan = 0.20;
  double biWeeklyPlan = 0.10;
  double monthlylyPlan = 0.05;
}

List<String> apartmentTypes = [
  'Single Room',
  'Self-Contain Room',
  'Self-Contain Room and Parlour',
  '2-Bedroom Apartment',
  '3-Bedroom Apartment',
  '4-Bedroom Apartment',
  'Duplex',
];
