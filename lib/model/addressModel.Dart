class AddressModel {
  String addressID;
  var description;
  var branchID;
  var lat;
  var lng;
  var userIDList;

  AddressModel({
    required this.addressID,
    this.description,
    this.branchID,
    this.lat,
    this.lng,
    this.userIDList,
  });
}
