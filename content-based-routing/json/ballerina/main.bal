import ballerina/http;

configurable string httpClientUrl = ?;

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

isolated service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }
    isolated resource function post cbr(StockDetails payload) returns http:Response|http:Error {
        if re `SUN`.isFullMatch(payload.buyStocks.'order[1].symbol) {
            return check self.clientOne->/.post(payload);
        }
        return self.clientTwo->/.post(payload);
    }
}
