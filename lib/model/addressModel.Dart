class AddressModel {
  var addressID;
  var description;
  var branchID;
  var location;
  var userIDList;

  // AddressModel(String addressID, String description, String branchID,
  //     String location, Future<String> userIDList) {
  //   this.addressID = addressID;
  //   this.description = description;
  //   this.branchID = branchID;
  //   this.location = location;
  //   this.userIDList = userIDList;
  // }
  AddressModel({
    this.addressID,
    this.description,
    this.branchID,
    this.location,
    this.userIDList,
  });
}
