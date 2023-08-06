import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:yatrigan/main.dart';

import '../screen/ticket.dart';

class Pdf {
  Future<void> createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    // Draw a text
    page.graphics.drawString('E-Ticket/Reservation Voucher',
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 120, 300, 50));

    // Draw an image
    page.graphics.drawImage(PdfBitmap(await readImageData('intro.png')),
        const Rect.fromLTWH(0, 0, 500, 100));

    final PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      // cellPadding: PdfPaddings(left: 5, right: 5, top: 5, bottom: 5),
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
    );

    // Add the columns to the grid.
    grid.columns.add(count: 2);

    final PdfGridRow dataRow0 = grid.rows.add();
    dataRow0.cells[0].value = 'Ticket :' ' $tickdetID';
    dataRow0.cells[1].value = ' ';

    dataRow0.cells[0].style.stringFormat = PdfStringFormat(
      alignment: PdfTextAlignment.left,
    );
    dataRow0.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);

    dataRow0.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    dataRow0.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    // Add data rows to the grid.
    final PdfGridRow dataRow = grid.rows.add();
    dataRow.cells[0].value = 'BusId :' ' $busNameAll';
    dataRow.cells[1].value = 'Date :' ' $selectedDateAllString';

    dataRow.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    dataRow.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    dataRow.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    dataRow.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow dataRow1 = grid.rows.add();
    dataRow1.cells[0].value = 'From :' ' $fromLocationAll';
    dataRow1.cells[1].value = 'To :' ' $toLocationAll';

    dataRow1.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    dataRow1.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    dataRow1.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    dataRow1.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow dataRow2 = grid.rows.add();
    dataRow2.cells[0].value = 'Depart :' ' $departAll';
    dataRow2.cells[1].value = 'Arrival :' ' $arrivalAll';
    dataRow2.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    dataRow2.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    dataRow2.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    dataRow2.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    // Draw the grid on the page
    grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(50, 150, 500, 0),
      // Adjust the vertical position of the grid
    );

    page.graphics.drawString('No of Seats :' '$maxPassengerAll',
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 230, 300, 50));

    page.graphics.drawString('Passenagers Details :',
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 280, 300, 50));

    final PdfGrid passengergrid = PdfGrid();
    passengergrid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
    );

    passengergrid.columns.add(count: 4);

    final PdfGridRow pasrow = passengergrid.rows.add();
    pasrow.cells[0].value = 'Name';
    pasrow.cells[1].value = 'Age';
    pasrow.cells[2].value = 'Gender';
    pasrow.cells[3].value = 'Seat';
    pasrow.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    pasrow.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    pasrow.cells[2].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    pasrow.cells[3].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    for (int i = 0; i < maxPassengerAll; i++) {
      final PdfGridRow pasrowi = passengergrid.rows.add();
      pasrowi.cells[0].value = personAll[i];
      pasrowi.cells[1].value = ageAll[i].toString();
      pasrowi.cells[2].value = genderAll[i];
      pasrowi.cells[3].value = selectedSeat[i].toString();
      pasrowi.cells[0].style.borders = PdfBorders(
          left: PdfPen(PdfColor(255, 255, 255)),
          top: PdfPen(PdfColor(255, 255, 255)),
          bottom: PdfPen(PdfColor(255, 255, 255)),
          right: PdfPen(PdfColor(255, 255, 255)));
      pasrowi.cells[1].style.borders = PdfBorders(
          left: PdfPen(PdfColor(255, 255, 255)),
          top: PdfPen(PdfColor(255, 255, 255)),
          bottom: PdfPen(PdfColor(255, 255, 255)),
          right: PdfPen(PdfColor(255, 255, 255)));
      pasrowi.cells[2].style.borders = PdfBorders(
          left: PdfPen(PdfColor(255, 255, 255)),
          top: PdfPen(PdfColor(255, 255, 255)),
          bottom: PdfPen(PdfColor(255, 255, 255)),
          right: PdfPen(PdfColor(255, 255, 255)));
      pasrowi.cells[3].style.borders = PdfBorders(
          left: PdfPen(PdfColor(255, 255, 255)),
          top: PdfPen(PdfColor(255, 255, 255)),
          bottom: PdfPen(PdfColor(255, 255, 255)),
          right: PdfPen(PdfColor(255, 255, 255)));
    }

    passengergrid.draw(
      page: page,
      bounds: const Rect.fromLTWH(
          50, 320, 500, 0), // Adjust the vertical position of the grid
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    page.graphics.drawString('Total Fare :',
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 400, 300, 50));

    final PdfGrid faregrid = PdfGrid();
    faregrid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
    );

    faregrid.columns.add(count: 2);

    final PdfGridRow farerow = faregrid.rows.add();
    farerow.cells[0].value = 'Basic Fare';
    farerow.cells[1].value = (priceAll * maxPassengerAll).toString();
    farerow.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    farerow.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    farerow.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    farerow.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow farerow1 = faregrid.rows.add();
    farerow1.cells[0].value = 'Reservation Charge';
    farerow1.cells[1].value = resevationChargeAll.toString();

    farerow1.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    farerow1.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    farerow1.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    farerow1.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow farerow2 = faregrid.rows.add();
    farerow2.cells[0].value = 'Toll Charge';
    farerow2.cells[1].value = tollTaxAll.toString();

    farerow2.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    farerow2.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);

    farerow2.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    farerow2.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow farerow3 = faregrid.rows.add();
    farerow3.cells[0].value = 'Service Charge';
    farerow3.cells[1].value = serviceTaxAll.toString();

    farerow3.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    farerow3.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    farerow3.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    farerow3.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    final PdfGridRow farerow4 = faregrid.rows.add();
    farerow4.cells[0].value = 'Total';
    farerow4.cells[1].value = (maxPassengerAll * priceAll +
            resevationChargeAll +
            tollTaxAll +
            serviceTaxAll)
        .toString();

    farerow4.cells[0].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    farerow4.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);
    farerow4.cells[0].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));
    farerow4.cells[1].style.borders = PdfBorders(
        left: PdfPen(PdfColor(255, 255, 255)),
        top: PdfPen(PdfColor(255, 255, 255)),
        bottom: PdfPen(PdfColor(255, 255, 255)),
        right: PdfPen(PdfColor(255, 255, 255)));

    faregrid.draw(
      page: page,
      bounds: const Rect.fromLTWH(
          50, 450, 500, 0), // Adjust the vertical position of the grid
      format: PdfLayoutFormat(layoutType: PdfLayoutType.paginate),
    );

    page.graphics.drawString('About Project :',
        PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 550, 300, 50));

    page.graphics.drawString(
        'This project is made by using Flutter and Firebase. ',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 580, 300, 50));

    page.graphics.drawString(
        'This project is uploaded on Github. ' '',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 600, 300, 50));

    page.graphics.drawString(
        'This is my Linkedin Profile link. ',
        PdfStandardFont(PdfFontFamily.helvetica, 12, style: PdfFontStyle.bold),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 620, 300, 50));
    

    List<int> bytes = await document.save();
    document.dispose();

    generatePDF(bytes, 'Ticket');
  }

  Future<Uint8List> readImageData(String name) async {
    final data = await rootBundle.load('lib/images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<void> generatePDF(List<int> bytes, String filename) async {
    try {
      final path =
          (await getExternalStorageDirectory())?.path; // Get the path string
      if (path == null) {
        print("Error: External storage directory not available.");
        return; // Return early if path is null
      }

      final file = File('$path/$filename.pdf');
      await file.writeAsBytes(bytes, flush: true);

      // Use the `await` keyword here to ensure the file is written before opening
      await OpenFile.open('$path/$filename.pdf');
    } catch (e) {
      print("Error generating or opening PDF: $e");
    }
  }
}
