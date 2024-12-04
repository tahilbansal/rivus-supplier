import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rivus_supplier/models/api_error.dart';
import 'package:rivus_supplier/models/environment.dart';
import 'package:rivus_supplier/models/hook_models/fetch_order.dart';
import 'package:rivus_supplier/models/order_details.dart';
import 'package:http/http.dart' as http;

FetchOrder fetchOrder(String id) {
  final order = useState<GetOrder?>(null);
  final isLoading = useState<bool>(false);
  final error = useState<ApiError?>(null);
  final appiError = useState<ApiError?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/orders/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        order.value = getOrderFromJson(response.body);
      } else {
        appiError.value = apiErrorFromJson(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchOrder(
    data: order.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
