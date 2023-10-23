import ballerina/http;

configurable string httpClientUrl = ?;

isolated service /CBRProxy on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post .(xml orders) returns http:Response|http:Error {
        if !re `.*`.isFullMatch((orders[1]/<symbol>[0]).data()) {
            return error("First order must be for the symbol IB");
        }

        return check self.httpClient->/;
    }
}
