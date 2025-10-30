import 'package:root/src/services/productivity_service.dart';

class ProductivityRepository {
  // ignore: unused_field
  final ProductivityService _productivityService;

  ProductivityRepository({ProductivityService? productivityService})
    : _productivityService = productivityService ?? ProductivityService();
}
