import ballerina/http;

configurable string httpClinetUrl = ?;
final http:Client httpClient = check new (httpClinetUrl);

isolated service /CBRProxy on new http:Listener(9090) {
    isolated resource function post .(xml orders) returns http:Response|http:Error {
        if !re `.*`.isFullMatch((orders[1]/<symbol>[0]).data()) {
            return error("First order must be for the symbol IB");
        }

        return check httpClient->/;
    }
}
