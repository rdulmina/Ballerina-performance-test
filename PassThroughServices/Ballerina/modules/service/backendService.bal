import ballerina/http;

isolated service / on new http:Listener(9090) {
    isolated resource function 'default [string... path]() returns string|error{
        return "Hello, World from Ballerina backend sevice";
    }
}
