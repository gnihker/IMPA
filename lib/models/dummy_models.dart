import './model.dart';

const dummyModels = [
  Model(
    label: 'Leaf classification',
    method: 'PUT',
    route: 'https://test.com/proj/test/leaf',
    description:
        'leaf classification test, just simply add a photo of a leaf and wait for the result!!',
  ),
  Model(
    label: 'Bottle',
    method: 'PUT',
    route: 'https://test.com/proj/test/bottle',
    description: 'bottle test',
  ),
  Model(
    label: 'OCR',
    method: 'POST',
    route:
        'https://api.ocr.space/parse/imageurl?apikey=3cc8d9406188957&base64Image=',
    description: 'free ocr',
  )
];
