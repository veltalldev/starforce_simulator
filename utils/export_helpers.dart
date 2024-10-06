import 'dart:io';

void export_csv(Map<String, List<num>> data, String filename) async {
  var file = File(filename);
  var sink = file.openWrite();

  // Write headers
  sink.write('Trial,Meso Spent,Destructions\n');

  // Write data row by row
  for (int i = 0; i < data['Meso Spent']!.length; i++) {
    sink.write('$i,${data['Meso Spent']![i]},${data['Destructions']![i]}\n');
  }

  await sink.close();
  print('Data exported to $filename');
}
