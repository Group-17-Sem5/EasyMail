class AddressModel {
  String addressID;
  String description;
  String branchID;
  String location;
  Future<String> userIDList;

  AddressModel(this.addressID, this.description, this.branchID, this.location,
      this.userIDList);
}
