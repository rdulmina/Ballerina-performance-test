import ballerina/http;
import ballerina/io;

configurable string httpClientUrl = ?;

isolated service /PassThroughXML on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function post [string... path](xml payload, http:Request req) returns http:Response|http:Error {
        io:println("Received request to post to " + req.rawPath);

        return check self.httpClient->/;
    }
}