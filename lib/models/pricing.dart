/*
* Basic Single Room - 4500
* Self-Contain Room(Personal Kitchen and Toilet) - 6000
* Room and Parlour Self-Contain - 8000
* 2 bedroom apartment - 12000
* 3 bedroom apartment - 17000
* 4 bedroom apartment - 23000
* Event Centers - Price is stated after inspection
*/

class PricingList {
  double singleRoom = 4500.0;
  double singleSelfContainRoom = 6000.0;
  double roomAndParlourSelfContain = 8000.0;
  double twoBedroom = 12000.0;
  double threeBedroom = 17000.0;
  double fourBedroom = 23000.0;
  double duplexVilla = 40000.0;
}

class SubscriptionPlans {
  double weeklyPlan = 0.20;
  double monthlyPlan = 0.10;
  double quarterlyPlan = 0.05;
}

List<String> apartmentTypes = [
  'Single Room',
  'Single Self Contain Room',
  'Self Contain Room and Parlour',
  '2-Bedroom Apartment',
  '3-Bedroom Apartment',
  '4-Bedroom Apartment',
  'Duplex',
  'Villa',
];
