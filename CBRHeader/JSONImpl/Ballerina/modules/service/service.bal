import ballerina/http;

configurable string httpClientUrl = ?;

const string PerfTests = "perfTests";

public int a = 5;
service /CBRHeaderProxy on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    resource function post .(@http:Header string foo) returns http:Response|http:Error {
        if foo != PerfTests {
            return error("Invalid routing header");
        }

        return check self.httpClient->/;
    }
}
