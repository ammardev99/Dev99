import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
class FlockOverallReportData {
 final String site;
 final String flockNumber;
  final String farmerName;
  final String startDate;
  final String endDate;
  final String procuredDoc;
  final String procuredFeed;
  final String billElectricity;
  final String kGsSold;
  final String moundSold;
  final String saleAmount;
  final String avgSaleRate;

  final String emptyFeedBags;
  final String manureSoldAmount;
  final String discardItems;
  final String otherItems;

  final String totalMortality;
  final String balanceBirds;
  final String bagsFlock;
  final String feedConversionRatio;
  final String plStatement;
  final String totalExpenses;
  final List<Map<String, String>> expenses;

  FlockOverallReportData({
    required this.site,
    required this.flockNumber,
    required this.farmerName,
    required this.startDate,
    required this.endDate,
    required this.procuredDoc,
    required this.procuredFeed,
    required this.billElectricity,
    required this.kGsSold,
    required this.moundSold,
    required this.saleAmount,
    required this.avgSaleRate,
    
    required this.emptyFeedBags,
    required this.manureSoldAmount,
    required this.discardItems,
    required this.otherItems,
    required this.totalMortality,
    required this.balanceBirds,
    required this.bagsFlock,
    required this.feedConversionRatio,
    required this.plStatement,
    required this.totalExpenses,
    required this.expenses,
  });
}

      pw.Text("Flock Overall Report", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 16),
        // Section 1: Flock details
        _sectionHeader("Details"),
        _table([
          ["Site", data.site],
          ["Flock Number", data.flockNumber],
          ["Farmer Name", data.farmerName],
          ["Flock Started Date", data.startDate],
          ["Flock End Date", data.endDate],
        ]),
        pw.SizedBox(height: 10),
        // Section 2: Expenses Record
        _sectionHeader("Expenses Record", trailing: "Total: ${data.totalExpenses}"),
        _table([
          ["DOC", data.procuredDoc],
          ["Feed", data.procuredFeed],
          ["Electricity", data.BillElectricity],
        ]),

        pw.SizedBox(height: 10),


        // Section 3: Sale Record
        _sectionHeader("Sale Record"),
        _table([
          ["Total KGs Sold", data.kGsSold],
          ["Total Mound Sold", data.moundSold],
          ["Total Sale Amount", data.saleAmount],
          ["Average Sale Rate", data.avgSaleRate],
          ["Total Broker Commission", data.brokerCommissio],
        ]),

        pw.SizedBox(height: 10),


        // Section 4: Total Recovery Amount
        _sectionHeader("Total Recovery Amount", trailing: "Total: ${data.recoveryAmount}"),
        _table([
          ["Empty Feed Bags", data.emptyFeedBags],
          ["Manure Sold Amount", data.manureSoldAmount],
          ["Discard Items", data.discardItems],
          ["Other Items", data.otherItems],
        ]),

        pw.SizedBox(height: 10),


        pw.SizedBox(height: 20),
        pw.Center(
          child: pw.Text(
            "Powered by Poul3y & Developed by TheWebConcept",
            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey),
          ),
        )
      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (format) async => pdf.save(),
  );
}

pw.Widget _sectionHeader(String title, {String? trailing}) {
  return pw.Container(
    color: PdfColors.orange,
    padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 14, color: PdfColors.white)),
        if (trailing != null)
          pw.Text(trailing, style: pw.TextStyle(fontSize: 14, color: PdfColors.white)),
      ],
    ),
  );
}

pw.Widget _table(List<List<String>> rows) {
  return pw.Table(
    border: pw.TableBorder.all(color: PdfColors.grey),
    columnWidths: {
      0: pw.FlexColumnWidth(3),
      1: pw.FlexColumnWidth(5),
    },
    children: rows.map((row) {
      return pw.TableRow(
        children: row.map((cell) {
          return pw.Padding(
            padding: pw.EdgeInsets.all(6),
            child: pw.Text(cell),
          );
        }).toList(),
      );
    }).toList(),
  );
}

pw.Widget _expenseTable(List<Map<String, String>> items) {
  return pw.Column(
    children: items.map((item) {
      String key = item.keys.first;
      String value = item.values.first;
      return pw.Container(
        padding: pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: pw.BoxDecoration(
          border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey100)),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(key),
            pw.Text(value),
          ],
        ),
      );
    }).toList(),
  );
}
