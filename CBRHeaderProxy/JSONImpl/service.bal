import ballerina/http;
import ballerina/mime;

configurable string httpClinetUrl = ?;

service /CBRHeaderProxy on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClinetUrl);
    }
    resource function get .(@http:Header string accept) returns http:Response|http:Error {
        if !string:equalsIgnoreCaseAscii(accept, mime:APPLICATION_XML) {
            return error("Only application/json is supported");
        }

        return check self.httpClient->/;
    }
}
