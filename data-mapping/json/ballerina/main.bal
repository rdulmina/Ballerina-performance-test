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
    isolated resource function post jsonmapper(StockDetails stockDetails) returns record {record {TargetType[] 'order;} buyStocks;}|error {
        SourceType[] orders = stockDetails.buyStocks.'order;
        return {buyStocks: {'order: mapToJson(orders)}};
    }
}

isolated function mapToJson(SourceType[] sourceType) returns TargetType[] => from var sourceTypeItem in sourceType
    select {
        symbol: sourceTypeItem.symbol,
        buyerID: sourceTypeItem.buyerID,
        totalPrice: sourceTypeItem.price * sourceTypeItem.volume
    };
