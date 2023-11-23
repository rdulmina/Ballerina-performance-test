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

service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }
    resource function post cbr(http:Request request) returns http:Response|error {
        final json payload = check request.getJsonPayload();
        //  worker w1 returns http:Response|error {
        json[] orders = check payload?.buyStocks?.'order.ensureType();
        string symbol = check orders[1]?.symbol.ensureType();
        if re `SUN`.isFullMatch(symbol) {
            return self.clientOne->/.post(payload);
        }
        return self.clientTwo->/.post(payload);
        //   }
    }
}
