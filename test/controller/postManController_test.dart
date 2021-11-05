import 'package:easy_mail_app_frontend/controller/postManController.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('The login postman when username and password given', () async {
    PostManController postManController = new PostManController();

    var result = postManController.login("postMan002", "post123");
    expect(0, result);
  });
}
