part of 'pages.dart';

class Employee extends StatelessWidget {
  final data = [
    EmployeeModel(
        id: "1",
        employeeName: "Harmon Sitohang",
        employeeSalary: "10000000",
        employeeAge: "23",
        profileImage: ""),
    EmployeeModel(
        id: "2",
        employeeName: "Cristiano Ronaldo",
        employeeSalary: "9999999",
        employeeAge: "35",
        profileImage: ""),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee CRUD"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("+"),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EmployeeAdd()));
        },
      ),

      ///FITUR DIMANA KETIKA PAGE DITARIK DARI ATAS KE BAWAH, MAKA AKAN MEMICU FUNGSI UNTUK MENGAMBIL DATA KE API
      body: RefreshIndicator(
        ///ADAPUN FUNGSI YANG DIJALANKAN ADALAH getEmployee() DARI EMPLOYEE_PROVIDER
        onRefresh: () =>
            Provider.of<EmployeeProvider>(context, listen: false).getEmployee(),
        child: Container(
            margin: EdgeInsets.all(10),

            ///KETIKA PAGE INI DIAKSES MAKA AKAN MEMINTA DATA KE API
            child: FutureBuilder(
              future: Provider.of<EmployeeProvider>(context, listen: false)
                  .getEmployee(),
              builder: (context, snapshot) {
                ///JIKA PROSES REQUEST MASIH BERLANGSUNG
                if (snapshot.connectionState == ConnectionState.waiting) {
                  ///MAKA KITA TAMPILKAN INDIKATOR LOADING
                  return Center(child: CircularProgressIndicator());
                }

                ///SELAIN ITU KITA RENDER ATAU TAMPILKAN DATANYA
                ///ADAPUN UNTUK MENGAMBIL DATA DARI STATE DI PROVIDER
                ///MAKA KITA GUNAKAN CONSUMER
                return Consumer<EmployeeProvider>(builder: (context, data, _) {
                  ///KEMUDIAN LOOPING DATANYA DENGAN LISTVIEW BUILDER
                  return ListView.builder(
                      itemCount: data.dataEmployee.length,
                      itemBuilder: (context, i) {
                        return Card(
                          elevation: 1,
                          child: ListTile(
                            title: Text(data.dataEmployee[i].employeeName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            subtitle: Text(
                                'umur :  ${data.dataEmployee[i].employeeAge}'),
                            trailing: Text(
                                "\$${data.dataEmployee[i].employeeSalary}"),
                          ),
                        );
                      });
                });
              },
            )),
      ),
    );
  }
}
