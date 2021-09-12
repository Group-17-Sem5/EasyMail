
class MailModel{
  String mailID;
  String addressID;
  String lastAppearedBranch;
  String postManID;
  String sourceBranchID;
  String receivingBranchID;
  String senderID;
  String receiverID;
  bool isAssigned;
  bool isDelivered;
  MailModel({
    this.mailID,
    this.addressID,
    this.lastAppearedBranch,
    this.postManID,
    this.sourceBranchID,
    this.receivingBranchID,
    this.senderID,
    this.receiverID,
    this.isAssigned,
    this.isDelivered
    });

}


