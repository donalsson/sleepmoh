import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:sleepmohapp/core/localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

class Datepicker extends StatefulWidget {
 //const Datepicker({ Key? key }) : super(key: key);

  @override
  _DatepickerState createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  String _selectedDate;
  String _dateCount;
  String _range;
  String _rangeCount;
final DateRangePickerController _controller = DateRangePickerController();
  final List<String> views = <String>['Month', 'Year', 'Decade', 'Century'];
  @override
  void initState() {
    _selectedDate = '';
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    
    super.initState();
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context, _range),
               ), 
              title: Text(AppLocalizations.of(context).datedeparr),
              centerTitle: true,
            ),
            body: Stack(
              children: <Widget>[
                
                Positioned(
                  left: 0,
                  top: 10,
                  right: 0,
                  bottom: 0,
                  child: SfDateRangePicker(
                    controller: _controller,
            view: DateRangePickerView.month,
                    onSelectionChanged: _onSelectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    startRangeSelectionColor: Colors.green,
                    endRangeSelectionColor: Colors.red,
                    rangeSelectionColor: Color.fromRGBO(255, 10, 0, 0.1),
                    enablePastDates: false 
                  ),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                    InkWell(
            onTap: () {
              Navigator.pop(context, _range);
            },
            child: Container(
              height: 55.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue[300],
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp)),
              child: Center(
                child: Text(
                  AppLocalizations.of(context).validd,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontFamily: "Sofia",
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
                    ],
                  ),
                ),
              ],
            )),
        localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        // put all locales you want to support here
        const Locale('fr', 'FR'),
      ],
            );
  }

}