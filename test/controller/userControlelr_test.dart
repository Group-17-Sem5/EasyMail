import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:easy_mail_app_frontend/controller/userController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserController userController = new UserController();
//postman controller tests
  test('The login user when username and password given', () async {
    var result = await userController.login("Kamal001", "post123");
    expect(0, result);
  });
  test('The getting addresses for the user', () async {
    var result = await userController.getLocations();
    expect(0, result);
  });
  test('Getting all received mails for the user', () async {
    var result = await userController.getReceivedMails();
    expect(0, result);
  });
  test('Getting all sent mails by the user', () async {
    var result = await userController.getSentMails();
    expect(0, result);
  });
  test('Getting all received money Orders for the user', () async {
    var result = await userController.getReceivedMoneyOrders();
    expect(0, result);
  });
  test('Getting all sent money orders by the user', () async {
    var result = await userController.getSentMoneyOrders();
    expect(0, result);
  });
  test('getting all received couriers', () async {
    var result = await userController.getReceivedCouriers();
    expect(0, result);
  });
  test('getting all cancelled couriers by postman', () async {
    var result = await userController.getSentCouriers();
    expect(0, result);
  });
}
