import ballerina/http;
import ballerina/xmldata;

isolated service / on new http:Listener(9090) {
    isolated resource function post jsontoxml(@http:Payload json payload) returns xml|xmldata:Error? {
        return xmldata:fromJson(payload);
    }
}




