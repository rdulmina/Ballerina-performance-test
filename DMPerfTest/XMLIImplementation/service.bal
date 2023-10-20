import ballerina/http;

configurable string httpClinetUrl = ?;

isolated service /DMPerfTest on new http:Listener(9090) {
    final http:Client httpClient;

    function init() returns error? {
        self.httpClient = check new (httpClinetUrl);
    }
    isolated resource function post .(xml payload) returns json {
        xml<'xml:Element> orders = payload/**/<'order>;
        return orders.toJson();
    }
}
