import ballerina/http;

configurable string httpClinetUrl = ?;
final http:Client httpClient = check new (httpClinetUrl);

isolated service /DMPerfTest on new http:Listener(9090) {
    isolated resource function post .(xml payload) returns json {
        xml<'xml:Element> orders = payload/**/<'order>;
        return orders.toJson();
    }
}
