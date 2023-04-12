import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClinicVisitForm extends StatelessWidget {
  const ClinicVisitForm({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  DateTime? _visitDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != _visitDate)
      setState(() {
        _visitDate = picked;
      });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != _startTime)
      setState(() {
        _startTime = picked;
      });
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != _endTime)
      setState(() {
        _endTime = picked;
      });
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = new DateTime.now();
    final dt = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Clinic Visit Form'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Please confirm the details:'),
                Text('Are you sure to confirm this date and time ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                print('Confirmed');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ClinicVisitForm(),
                  ),
                );
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Color(0xFF7165D6),
        title: const Center(
          child: Text(
            "Clinic Visit Form",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 180,
                child: Image.asset("images/visitClinic.jpg"),
              ),
            ),
            SizedBox(
              height: 20,
              // width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Text(
                    'Schedule Consultation',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Text(""),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Text(
                          _visitDate == null
                              ? 'Select a visit date'
                              : 'Visit Date: ${_visitDate!.day}/${_visitDate!.month}/${_visitDate!.year}',
                          style: TextStyle(
                            fontSize: 21,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select From',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      _startTime == null
                          ? 'Select start time'
                          : 'Start Time: ${_formatTimeOfDay(_startTime!)}',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      _selectStartTime(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "To",
              style: TextStyle(fontSize: 21),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      _startTime == null
                          ? 'Select end time'
                          : 'End Time: ${_formatTimeOfDay(_startTime!)}',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () {
                      _selectStartTime(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ElevatedButton(
              // color: Colors.teal,
              // textColor: Colors.white,
              onPressed: () {
                _showMyDialog();
              },
              child: Text(
                "Submit details",
                style: TextStyle(fontSize: 19),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
