import ballerina/http;
import ballerina/mime;

configurable string httpClinetUrl = ?;
final http:Client httpClient = check new (httpClinetUrl);

service /CBRHeaderProxy on new http:Listener(9090) {
    resource function get .(@http:Header string accept) returns http:Response|http:Error {
        if !string:equalsIgnoreCaseAscii(accept, mime:APPLICATION_XML) {
            return error("Only application/json is supported");
        }

        return check httpClient->/;
    }
}
