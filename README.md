# HttpBaseHelper Plugin


Make implementation with http more easier and short.

### Examples
Here are small examples that show you how to use http base helper.

#### Request Network
```dart
// Obtain shared preferences.
final httpBaseHelper = await ApiBaseHelper();

// for get method request.
    httpBaseHelper.onNetworkRequesting(methode: METHODE.get, baseUrl: "http//...", url: "/list").then((response) {
      //here for status code 200
      debugPrint("response$response");
    }).onError((ErrorModel error, stackTrace) {
      //here for error status code
      debugPrint('Status code: ${error.statusCode}');
    });
// for post method request.
    httpBaseHelper.onNetworkRequesting(methode: METHODE.post, baseUrl: "http//...", url: "/product",body: {
      "id": 1
    }).then((response) {
      //here for status code 200
      debugPrint("response$response");
    }).onError((ErrorModel error, stackTrace) {
      //here for error status code
      debugPrint('Status code: ${error.statusCode}');
    });

```
#### All Method Request
```dart
//for get request
Method.get
//for post request
Method.post
//for put request
Method.put
//for delete request
Method.delete
 

```
## Copyright & License

This open source project authorized by https://pub.dev/packages/get , and the license is MIT.