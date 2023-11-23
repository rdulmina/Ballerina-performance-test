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

type BuyStocks record {|
    SourceType[] 'order;
|};

type StockDetails record {|
    BuyStocks buyStocks;
|};

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

isolated service / on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post jsonmapper(http:Request request) returns json|error {
        json stockDetails = check request.getJsonPayload();
        json[] orders = check stockDetails.buyStocks.'order.ensureType();
        return {buyStocks: {'order: check mapToJson(orders)}};
    }
}

isolated function mapToJson(json[] sourceType) returns json|error => from var sourceTypeItem in sourceType
    select {
        symbol: check sourceTypeItem.symbol,
        buyerID: check sourceTypeItem.buyerID,
        totalPrice: <float>check sourceTypeItem.price * <int>check sourceTypeItem.volume
    };
