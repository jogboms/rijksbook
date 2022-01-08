import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:rijksbook/data.dart';

void main() {
  group('Repositories', () {
    group('HttpRijksRepository', () {
      group('fetchAll', () {
        test('Smoke test for list of Art', () async {
          final Client client = clientWithOkResponse(r'''{
            "artObjects": [{
              "links": {
                "self": "http://www.rijksmuseum.nl/api/en/collection/SK-A-1505",
                "web": "http://www.rijksmuseum.nl/en/collection/SK-A-1505"
              },
              "id": "en-SK-A-1505",
              "objectNumber": "SK-A-1505",
              "title": "A Windmill on a Polder Waterway, Known as 'In the Month of July'",
              "longTitle": "A Windmill on a Polder Waterway, Known as 'In the Month of July', Paul Joseph Constantin Gabriël, c. 1889",
              "hasImage": true,
              "principalOrFirstMaker": "Paul Joseph Constantin Gabriël",
              "showImage": true,
              "permitDownload": true,
              "webImage": {
                "guid": "3e83eca2-5306-4d6d-b499-f86091c81d39",
                "offsetPercentageX": 0,
                "offsetPercentageY": 0,
                "width": 1767,
                "height": 2748,
                "url": "https://lh3.googleusercontent.com/nfJiRConmXf4QR1bK3-E456qIEp2bYtuemyy3P3t7PonntyGJ8iPzFNKJPhZFCSSmJmj2AHePE4V1xl3BOz2NT8mfbNg=s0"
              },
              "headerImage": {
                "guid": "34e94d7f-4d7a-464e-b3f9-eb5532f98c27",
                "offsetPercentageX": 0,
                "offsetPercentageY": 0,
                "width": 1767,
                "height": 424,
                "url": "https://lh3.googleusercontent.com/aBYq1zHv15e7b3QhO20l8calrdCVOljfAjpoZeipAFZi53VhuDD-CFOym2ICOWD10C79flH_nW7rU7XBOQCKq50ozlY=s0"
              },
              "productionPlaces": []
            }]
          }''');
          await HttpRijksRepository(client, apiKey: '').fetchAll(page: 1);
        });

        test('Failure case', () async {
          final Client client = clientWithFailedResponse();
          expect(() => HttpRijksRepository(client, apiKey: '').fetchAll(page: 1), throwsException);
        });
      });

      group('fetch', () {
        test('Smoke test for ArtDetail', () async {
          final Client client = clientWithOkResponse(r'''{
            "artObject": {
              "links": {
                "search": "http://www.rijksmuseum.nl/api/nl/collection"
              },
              "id": "en-SK-A-135",
              "priref": "8609",
              "objectNumber": "SK-A-135",
              "language": "en",
              "title": "A Militiaman Holding a Berkemeyer, Known as the 'Merry Drinker'",
              "copyrightHolder": null,
              "webImage": {
                "guid": "447b11f6-7c16-48b5-a04e-8694929bd7ae",
                "offsetPercentageX": 50,
                "offsetPercentageY": 36,
                "width": 2254,
                "height": 2646,
                "url": "https://lh3.googleusercontent.com/bMCQgUbifzAl-How19Ru06KYgdVuND2pdYzY81zIx3MJ0ld6yqzPnWLVUOu0Aj1JNgK-lFDT2CSjfmQ-erpBdJ6AM4XGAwuQoivxWpJ8=s0"
              },
              "colors": [
                {"percentage": 39, "hex": "#634829"},
                {"percentage": 18, "hex": " #716442"},
                {"percentage": 14, "hex": " #947A48"},
                {"percentage": 14, "hex": " #1F2019"},
                {"percentage": 7, "hex": " #3D3421"},
                {"percentage": 2, "hex": " #C9BC97"},
                {"percentage": 2, "hex": " #B9A370"}
              ],
              "colorsWithNormalization": [
                {"originalHex": "#634829", "normalizedHex": "#B35A1F"},
                {"originalHex": " #716442", "normalizedHex": "#E0CC91"},
                {"originalHex": " #947A48", "normalizedHex": "#E09714"},
                {"originalHex": " #1F2019", "normalizedHex": "#000000"},
                {"originalHex": " #3D3421", "normalizedHex": "#000000"},
                {"originalHex": " #C9BC97", "normalizedHex": "#E0CC91"},
                {"originalHex": " #B9A370", "normalizedHex": "#E0CC91"}
              ],
              "normalizedColors": [
                {"percentage": 39, "hex": "#8B4513"},
                {"percentage": 18, "hex": " #556B2F"},
                {"percentage": 14, "hex": " #B8860B"},
                {"percentage": 14, "hex": " #000000"},
                {"percentage": 7, "hex": " #696969"},
                {"percentage": 5, "hex": " #D2B48C"}
              ],
              "normalized32Colors": [],
              "titles": [
                "A Civic Guardsman holding a Berkemeier, known as 'The Merry Drinker'",
                "The Merry Drinker"
              ],
              "description": "De vrolijke drinker. Lachende man met baard en grote zwarte hoed, ten halven lijve, met een berkenmeier in de linkerhand en opgeheven rechterhand. Om de hals een medaillon aan een ketting.",
              "labelText": null,
              "objectTypes": ["painting"],
              "objectCollection": ["paintings"],
              "makers": [],
              "principalMakers": [
                {
                  "name": "Frans Hals",
                  "unFixedName": "Hals, Frans",
                  "placeOfBirth": "Antwerpen (stad)",
                  "dateOfBirth": "1583",
                  "dateOfBirthPrecision": "c.",
                  "dateOfDeath": "1666-08-26",
                  "dateOfDeathPrecision": null,
                  "placeOfDeath": "Haarlem",
                  "occupation": ["draughtsman"],
                  "roles": ["painter"],
                  "nationality": null,
                  "biography": null,
                  "productionPlaces": [],
                  "qualification": "mentioned on object",
                  "labelDesc": "mentioned on object Frans Hals (c. 1583 - 26-aug-1666)"
                },
                {
                  "name": "Frans Hals",
                  "unFixedName": "Hals, Frans",
                  "dateOfBirth": "1583-10",
                  "occupation": ["draughtsman"],
                  "roles": ["painter"],
                  "labelDesc": "mentioned on object Frans Hals (c. 1583 - 26-aug-1666)"
                },
                {
                  "name": "Frans Hals",
                  "unFixedName": "Hals, Frans",
                  "dateOfBirth": "1583-10-45",
                  "occupation": ["draughtsman"],
                  "roles": ["painter"],
                  "labelDesc": "mentioned on object Frans Hals (c. 1583 - 26-aug-1666)"
                }
              ],
              "plaqueDescriptionDutch": "Deze jolige man heft het glas alsof hij ons toedrinkt. Hoewel de gangbare stijl in Hals' tijd verfijnd en gedetailleerd was, bracht hij de verf hier met snelle, maar trefzekere streken aan. Door deze schilderwijze lijkt de man echt te bewegen. Bij zijn rechterhand is dat het beste te zien. ",
              "plaqueDescriptionEnglish": "This cheery young man is raising his glass as if to propose a toast. Although the fashion was then for intricate, detailed paintings, Hals applied his paints with quick, confident strokes. This style of painting gives the subject a real sense of movement. This is most obvious with the right hand. ",
              "principalMaker": "Frans Hals",
              "artistRole": null,
              "associations": [],
              "acquisition": {
                "method": "purchase",
                "date": "1816-01-01T00:00:00",
                "creditLine": null
              },
              "exhibitions": [],
              "materials": [
                "canvas",
                "oil paint (paint)"
              ],
              "techniques": [],
              "productionPlaces": [],
              "dating": {
                "presentingDate": "c. 1628 - c. 1630",
                "sortingDate": 1628,
                "period": 17,
                "yearEarly": 1628,
                "yearLate": 1630
              },
              "classification": {
                "iconClassIdentifier": [
                  "41C323",
                  "41D221(HAT)(+81)",
                  "45(+26)",
                  "41C12",
                  "31B62321"
                ],
                "iconClassDescription": [
                  "glass, rummer",
                  "head-gear: hat (+ men's clothes)",
                  "warfare; military affairs (+ citizen soldiery, civil guard, citizen militia)",
                  "drinking",
                  "laughing"
                ],
                "motifs": [],
                "events": [],
                "periods": [],
                "places": [],
                "people": [],
                "objectNumbers": [
                  "SK-A-135"
                ]
              },
              "hasImage": true,
              "historicalPersons": [],
              "inscriptions": [],
              "documentation": [
                "F. Desbuissons, A l'enseigne du Bon Bock, in:  La revue de Musée d'Orsay nr. 30 (automne 2010) 48, 14, p. 35, fig. 2",
                "Rijksmuseum Kunstkrant, Jaargang 33 (sept.-okt. 2007), nr. 5, p. 9",
                "H. Kaufmann, 'Die Fünfsinne in der Niederlänischen Malerei des 17. Jahrhunderts', in: Kunstgeschichtliche Studien, Breslau 1943, p. 141, afb. 22 (misschien de smaak of meer speciaal de geneugten van het drinken)."
              ],
              "catRefRPK": [],
              "principalOrFirstMaker": "Frans Hals",
              "dimensions": [
                {
                  "unit": "cm",
                  "type": "height",
                  "part": "support",
                  "value": "81"
                },
                {
                  "unit": "cm",
                  "type": "width",
                  "part": "support",
                  "value": "66.5"
                }
              ],
              "physicalProperties": [],
              "physicalMedium": "oil on canvas",
              "longTitle": "A Militiaman Holding a Berkemeyer, Known as the 'Merry Drinker', Frans Hals, c. 1628 - c. 1630",
              "subTitle": "h 81cm × w 66.5cm",
              "scLabelLine": "Frans Hals (c. 1582–1666), oil on canvas, c. 1628–1630",
              "label": {
                "title": "A Militiaman Holding a Berkemeyer, Known as the 'Merry Drinker'",
                "makerLine": "Frans Hals (c. 1582–1666), oil on canvas, c. 1628–1630",
                "description": "This militiaman merrily raises his glass to toast us – who would not wish to join him? The execution is just as free and easy as the sitter himself: the swift, spontaneously applied brushstrokes enhance the portrait’s sense of liveliness and animation. The man actually seems to be moving. This bravura painting style ensured the continued success of Frans Hals.",
                "notes": "Multimediatour",
                "date": "2018-02-27"
              },
              "showImage": true,
              "location": "HG-2.30.2"
            }
          }''');
          await HttpRijksRepository(client, apiKey: '').fetch('id');
        });

        test('Failure case', () async {
          final Client client = clientWithFailedResponse();
          expect(() => HttpRijksRepository(client, apiKey: '').fetch('id'), throwsException);
        });
      });
    });
  });
}

Client clientWithOkResponse(String response) => MockClient(
    (_) async => Response(response, 200, headers: <String, String>{'content-type': 'application/json; charset=utf-8'}));

Client clientWithFailedResponse() => MockClient((_) async => Response('', 404));
