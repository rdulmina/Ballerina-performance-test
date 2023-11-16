import ballerina/http;
import ballerina/io;

configurable string httpClientUrl = ?;

xmlns "http://services.samples/xsd" as m;

isolated service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }

    isolated resource function post cbr(xml orders) returns http:Response|error {
        io:println(orders);
        if re `IBM`.isFullMatch((((orders/<m:'order>)[1])/<symbol>).data()) {
            return check self.clientOne->/;
        }
        return check self.clientTwo->/;
    }
}
