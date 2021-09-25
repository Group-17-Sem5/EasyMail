class UserModel {
  var userName;
  var addressID;
  var addressDescription;
  var phoneNumber;
  var branchID;
  var receivedPostID;
  var sentPostID;
  var receivedMoneyOrdersList;
  var sentMoneyOrdersList;

  UserModel({
    this.userName,
    this.addressID,
    this.addressDescription,
    this.phoneNumber,
    this.branchID,
    this.receivedPostID,
    this.sentPostID,
    this.receivedMoneyOrdersList,
    this.sentMoneyOrdersList,
  });
}
