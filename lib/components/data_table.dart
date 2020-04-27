import 'package:flutter/material.dart';



dataTable(){
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    padding: EdgeInsets.all(10),
      child: DataTable(columns: [
      DataColumn(label: Text("Suit/case No")),
      DataColumn(label: Text("Seasion/Exicution case No")),
      DataColumn(label: Text("Instititions")),
      DataColumn(label: Text("Borrower")),
      DataColumn(label: Text("Court Nme")),
      DataColumn(label: Text("Previous Date")),
      DataColumn(label: Text("Status")),

    ], rows: [
      DataRow(cells: [
        DataCell(Text('1')),
        DataCell(Text('254')),
        DataCell(Text('AJK')),
        DataCell(Text('Jasj Ansj')),
        DataCell(Text('Josdl Court')),
        DataCell(Text('12-2-19')),
        DataCell(Text('active'))
      ])

    ]),
  );
}

