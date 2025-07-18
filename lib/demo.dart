// import 'dart:async';
// import 'package:flutter/material.dart';
//
//
//
// class MyHomePagePdf extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('flutter_cached_pdfview Demo'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute<dynamic>(
//                 builder: (_) => const PDFViewerFromUrl(
//                   url:
//                   'https://apiweb.ksadmission.in/upload/notes/subject/chapter/1736949805_Physics_Neet_volume_1.pdf',
//                 ),
//               ),
//             ),
//             child: const Text('PDF From Url'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute<dynamic>(
//                 builder: (_) => const PDFViewerCachedFromUrl(
//                   url:
//                   'https://apiweb.ksadmission.in/upload/notes/subject/chapter/1736949805_Physics_Neet_volume_1.pdf',
//                 ),
//               ),
//             ),
//             child: const Text('Cashed PDF From Url'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute<dynamic>(
//                 builder: (_) => PDFViewerFromAsset(
//                   pdfAssetPath: 'assets/pdf/file-example.pdf',
//                 ),
//               ),
//             ),
//             child: const Text('PDF From Asset'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PDFViewerFromUrl extends StatelessWidget {
//   const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF From Url'),
//       ),
//       body: const PDF().fromUrl(
//         url,
//         placeholder: (double progress) => Center(child: Text('$progress %')),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
//     );
//   }
// }
//
// class PDFViewerCachedFromUrl extends StatelessWidget {
//   const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);
//
//   final String url;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cached PDF From Url'),
//       ),
//       body: const PDF().cachedFromUrl(
//         url,
//         placeholder: (double progress) => Center(child: Text('$progress %')),
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
//     );
//   }
// }
//
// class PDFViewerFromAsset extends StatelessWidget {
//   PDFViewerFromAsset({Key? key, required this.pdfAssetPath}) : super(key: key);
//   final String pdfAssetPath;
//   final Completer<PDFViewController> _pdfViewController =
//   Completer<PDFViewController>();
//   final StreamController<String> _pageCountController =
//   StreamController<String>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF From Asset'),
//         actions: <Widget>[
//           StreamBuilder<String>(
//               stream: _pageCountController.stream,
//               builder: (_, AsyncSnapshot<String> snapshot) {
//                 if (snapshot.hasData) {
//                   return Center(
//                     child: Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.blue[900],
//                       ),
//                       child: Text(snapshot.data!),
//                     ),
//                   );
//                 }
//                 return const SizedBox();
//               }),
//         ],
//       ),
//       body: PDF(
//         enableSwipe: true,
//         swipeHorizontal: true,
//         autoSpacing: false,
//         pageFling: false,
//         backgroundColor: Colors.grey,
//         onPageChanged: (int? current, int? total) =>
//             _pageCountController.add('${current! + 1} - $total'),
//         onViewCreated: (PDFViewController pdfViewController) async {
//           _pdfViewController.complete(pdfViewController);
//           final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
//           final int? pageCount = await pdfViewController.getPageCount();
//           _pageCountController.add('${currentPage + 1} - $pageCount');
//         },
//       ).fromAsset(
//         pdfAssetPath,
//         errorWidget: (dynamic error) => Center(child: Text(error.toString())),
//       ),
//       floatingActionButton: FutureBuilder<PDFViewController>(
//         future: _pdfViewController.future,
//         builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
//           if (snapshot.hasData && snapshot.data != null) {
//             return Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 FloatingActionButton(
//                   heroTag: '-',
//                   child: const Text('-'),
//                   onPressed: () async {
//                     final PDFViewController pdfController = snapshot.data!;
//                     final int currentPage =
//                         (await pdfController.getCurrentPage())! - 1;
//                     if (currentPage >= 0) {
//                       await pdfController.setPage(currentPage);
//                     }
//                   },
//                 ),
//                 FloatingActionButton(
//                   heroTag: '+',
//                   child: const Text('+'),
//                   onPressed: () async {
//                     final PDFViewController pdfController = snapshot.data!;
//                     final int currentPage =
//                         (await pdfController.getCurrentPage())! + 1;
//                     final int numberOfPages =
//                         await pdfController.getPageCount() ?? 0;
//                     if (numberOfPages > currentPage) {
//                       await pdfController.setPage(currentPage);
//                     }
//                   },
//                 ),
//               ],
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }