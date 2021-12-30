import './model.dart';

final dummyModels = [
  Model(
      detail: Detail(
          description: "this is cat-dog classification model",
          imgType: "file",
          key: "img",
          method: "POST",
          route: "http://10.0.2.2:5000/submit"),
      detailRoute: 'http://10.0.2.2:5000/detail',
      label: 'Cat Dog Classification'),
  Model(
      detail: Detail(
          description:
              "classify 5 types of flower including dandelion, daisy, sunflower, tulip and rose",
          imgType: "file",
          key: "img",
          method: "POST",
          route: "http://10.0.2.2:5001/submit"),
      detailRoute: 'http://10.0.2.2:5001/detail',
      label: 'Flower Classification'),
  // Model(
  //   label: 'Cat Dog classification',
  //   method: 'POST',
  //   route: 'http://10.0.2.2:5000/submit',
  //   key: 'img',
  //   description: 'Cat and Dog classification',
  // ),
  // Model(
  //   label: 'Flower classification',
  //   method: 'POST',
  //   route: 'http://10.0.2.2:5001/submit',
  //   key: 'img',
  //   description:
  //       'classify 5 types of flower including dandelion, daisy, sunflower, tulip and rose',
  // ),
  // Model(
  //   label: 'Leaf classification',
  //   method: 'POST',
  //   route: 'https://test.com/proj/test/leaf',
  //   key: 'img',
  //   description:
  //       'leaf classification test, just simply add a photo of a leaf and wait for the result!!',
  // ),
  // Model(
  //   label: 'Bottle',
  //   method: 'POST',
  //   route: 'https://test.com/proj/test/bottle',
  //   key: 'img',
  //   description: 'bottle test',
  // ),
  // Model(
  //   label: 'OCR',
  //   method: 'POST',
  //   route:
  //       'https://api.ocr.space/parse/image?apikey=3cc8d9406188957',
  //   key: 'img',
  //   description: 'free ocr',
  // )
];
