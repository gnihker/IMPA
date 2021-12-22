import './model.dart';

const dummyModels = [
  Model(
    label: 'Cat Dog classification',
    method: 'POST',
    route: 'http://10.0.2.2:5000/submit',
    key: 'img',
    description: 'Cat and Dog classification',
  ),
  Model(
    label: 'Leaf classification',
    method: 'POST',
    route: 'https://test.com/proj/test/leaf',
    key: 'img',
    description:
        'leaf classification test, just simply add a photo of a leaf and wait for the result!!',
  ),
  Model(
    label: 'Bottle',
    method: 'POST',
    route: 'https://test.com/proj/test/bottle',
    key: 'img',
    description: 'bottle test',
  ),
  Model(
    label: 'OCR',
    method: 'POST',
    route:
        'https://api.ocr.space/parse/imageurl?apikey=3cc8d9406188957&base64Image=',
    key: 'img',
    description: 'free ocr',
  )
];
