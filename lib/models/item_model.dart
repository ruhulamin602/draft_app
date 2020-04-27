class CountModel {
  String cases;
  String customers;
  String borrowers;

  CountModel({this.cases, this.customers, this.borrowers});

  factory CountModel.fromJson(Map<String, dynamic> parshedJson) {
    return CountModel(
        cases: parshedJson['cases'],
        customers: parshedJson['customers'],
        borrowers: parshedJson['borrowers']);
  }
}
