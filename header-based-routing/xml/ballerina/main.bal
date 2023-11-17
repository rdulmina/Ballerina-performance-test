import ballerina/http;

configurable string httpClientUrl = ?;

const ONE = "1.0";
const TWO = "2.0";

service / on new http:Listener(9090) {
    final http:Client clientOne;
    final http:Client clientTwo;

    function init() returns error? {
        self.clientOne = check new (httpClientUrl);
        self.clientTwo = check new (httpClientUrl);
    }
    resource function post hbr(@http:Header string version, xml payload) returns http:Response|http:Error {
        if version != ONE {
            return check self.clientOne->/.post(payload);
        }

        return check self.clientTwo->/.post(payload);
    }
}
