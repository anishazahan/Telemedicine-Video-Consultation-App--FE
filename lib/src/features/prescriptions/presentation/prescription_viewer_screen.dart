import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrescriptionViewerScreen extends StatelessWidget {
  const PrescriptionViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const demoPdf = 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
    return Scaffold(
      appBar: AppBar(title: const Text('Prescription')),
      body: SfPdfViewer.network(demoPdf),
    );
  }
}
