import ballerina/http;

configurable string httpClientUrl = ?;

type Payload record {|
    record {|string[] symbol;|} payload;
|};

isolated service /CBRProxy on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post .(Payload payload) returns http:Response|http:Error {
        if !re `.*`.isFullMatch(payload.payload.symbol[1]) {
            return error("First order must be for the symbol IB");
        }

        return check self.httpClient->/;
    }
}
