import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PostManController postManController = new PostManController();
//postman controller tests
  test('The login postman when username and password given', () async {
    var result = await postManController.login("Mat0001", "post123");
    expect(0, result);
  });
  test('The getting addresses for the postman', () async {
    var result = await postManController.getLocations();
    expect(0, result);
  });
  test('Getting all assigned mails for the postman', () async {
    var result = await postManController.getMails();
    expect(0, result);
  });
  test('Getting all delivered mails by the postman', () async {
    var result = await postManController.getDeliveredMails();
    expect(0, result);
  });
  test('Getting all cancelled mails by postman', () async {
    var result = await postManController.getCancelledMails();
    expect(0, result);
  });
  test('Getting all assigned couriers for the postman', () async {
    var result = await postManController.getAssignedCouriers();
    expect(0, result);
  });
  test('getting all delivered couriers by postman', () async {
    var result = await postManController.getDeliveredCouriers();
    expect(0, result);
  });
  test('getting all cancelled couriers by postman', () async {
    var result = await postManController.getCancelledCouriers();
    expect(0, result);
  });
}
