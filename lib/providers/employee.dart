part of 'providers.dart';

class EmployeeProvider extends ChangeNotifier {
  ///DEFINISIKAN PRIVATE VARIABLE DENGAN TYPE List dan VALUENYA MENGGUNAKAN FORMAT EMPLOYEEMODEL
  ///DEFAULTNYA KITA BUAT KOSONG
  List<EmployeeModel> _data = [];

  ///KARENA PRIVATE VARIABLE TIDAK BISA DIAKSES OLEH CLASS/FILE LAINNYA,
  ///MAKA DIPERLUKAN GETTER YANG BISA DIAKSES SECARA PUBLIC, ADAPUN VALUENYA DIAMBIL DARI _DATA
  List<EmployeeModel> get dataEmployee => _data;

  ///BUAT FUNGSI UNTUK MELAKUKAN REQUEST DATA KE SERVER / API
  Future<List<EmployeeModel>> getEmployee() async {
    final url = 'http://employee-crud-flutter.daengweb.id/index.php';
    final response = await http.get(url);

    ///JIKA STATUSNYA BERHASIL ATAU = 200
    if (response.statusCode == 200) {
      ///MAKA KITA FORMAT DATANYA MENJADI MAP DENGNA KEY STRING DAN VALUE DYNAMIC
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();

      ///KEMUDIAN MAPPING DATANYA UNTUK KEMUDIAN DIUBAH FORMATNYA
      ///SESUAI DENGAN EMPLOYEEMODEL DAN DIPASSING KE DALAM VARIABLE _DATA
      _data = result
          .map<EmployeeModel>((json) => EmployeeModel.fromJson(json))
          .toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  ///FUNGSI UNTUK MEMBUAT ATAU ADD NEW EMPLOYEE
  Future<bool> storeEmployee(String name, String salary, String age) async {
    final url = 'http://employee-crud-flutter.daengweb.id/add.php';
    //KIRIM REQUEST KE SERVER DENGAN MENGIRIMKAN DATA YANG AKAN DITAMBAHKAN PADA BODY
    final response = await http.post(url, body: {
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age
    });

    //DECODE RESPONSE YANG DITERIMA
    final result = json.decode(response.body);
    //LAKUKAN PENGECEKAN, JIKA STATUS CODENYA 200 DAN STATUS SUCCESS
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners(); //MAKA INFORMASIKAN PADA LISTENERS BAHWA ADA DATA BARU
      return true;
    }
    return false;
  }
}
