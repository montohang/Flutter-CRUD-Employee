part of 'pages.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _sallary = TextEditingController();

  final TextEditingController _age = TextEditingController();

  FocusNode salaryNode = FocusNode();
  FocusNode ageNode = FocusNode();

  bool _isLoading = false;

  final snackbarKey = GlobalKey<ScaffoldState>();

  void submit(BuildContext context) {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<EmployeeProvider>(context, listen: false)
          .storeEmployee(_name.text, _sallary.text, _age.text)
          .then((res) {
        if (res) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Employee()));
        } else {
          var snackbar = SnackBar(
            content: Text('Ops, Error. Hubungi Admin'),
          );
          snackbarKey.currentState.showSnackBar(snackbar);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: snackbarKey,
        appBar: AppBar(
          title: Text("Add Employee"),
          actions: [
            FlatButton(
              child: _isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
              onPressed: () => submit(context),
            )
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child: ListView(
              children: [
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    hintText: 'Name',
                  ),
                  onSubmitted: (_) {
                    //MAKA FOCUSNYA AKAN DIPINDAHKAN PADA FORM INPUT SELANJUTNYA
                    FocusScope.of(context).requestFocus(salaryNode);
                  },
                ),
                TextField(
                  controller: _sallary,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    hintText: 'Sallary',
                  ),
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(ageNode);
                  },
                ),
                TextField(
                  controller: _age,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    hintText: 'Age',
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
