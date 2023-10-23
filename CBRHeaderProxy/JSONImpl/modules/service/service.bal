import ballerina/http;
import ballerina/mime;

configurable string httpClientUrl = ?;

public int a = 5;
service /CBRHeaderProxy on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    resource function post .(@http:Header string accept) returns http:Response|http:Error {
        if !string:equalsIgnoreCaseAscii(accept, mime:APPLICATION_JSON) {
            return error("Invalid routing header");
        }

        return check self.httpClient->/;
    }
}
