import ballerina/http;

configurable string httpClientUrl = ?;

//  Source JSON
// {
//   "buyStocks": {
//     "order": [
//       {
//         "symbol": "SUN",
//         "buyerID": "indika",
//         "price": 14.56,
//         "volume": 500
//       },
//       {
//         "symbol": "MSFT",
//         "buyerID": "doe",
//         "price": 23.56,
//         "volume": 8030
//       }
//     ]
//   }
// }
//
// Target JSON
// {
//   "buyStocks": {
//     "order": [
//       {
//         "symbol": "SUN",
//         "buyerID": "indika",
//         "totalPrice": 7280
//       },
//       {
//         "symbol": "MSFT",
//         "buyerID": "doe",
//         "totalPrice": 189186.8
//       }
//     ]
//   }
// }

type SourceType record {|
    string symbol;
    string buyerID;
    float price;
    int volume;
|};

type TargetType record {|
    string symbol;
    string buyerID;
    float totalPrice;
|};

isolated service /JSONDataMapping on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post .(@http:Payload json payload) returns json|error {
        SourceType[] orders = check (check payload.buyStocks.'order).cloneWithType();
        TargetType[] target = from SourceType {symbol, buyerID, price, volume} in orders
        select {symbol, buyerID, totalPrice: price * volume};

        return {buyStocks: {'order: target}};

        // return check self.httpClient->/;
    }
}
