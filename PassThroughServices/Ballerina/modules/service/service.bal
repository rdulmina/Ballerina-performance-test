import ballerina/http;

configurable string httpClientUrl = ?;

isolated service / on new http:Listener(9092) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    isolated resource function 'default [string... path](http:Request req) returns http:Response|error{
        return self.httpClient->forward(req.rawPath, req);
    }
}
