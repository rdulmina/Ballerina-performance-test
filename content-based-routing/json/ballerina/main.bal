import ballerina/http;

configurable string httpClientUrl = ?;

type Payload record {|
    record {|string[] symbol;|} payload;
|};

isolated service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }
    isolated resource function post cbr(Payload payload) returns http:Response|http:Error {
        if re `IBM`.isFullMatch(payload.payload.symbol[1]) {
            return check self.clientOne->/;
        }

        return self.clientTwo->/;
    }
}
