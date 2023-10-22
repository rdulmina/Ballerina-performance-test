import ballerina/http;
import ballerina/xmldata;

type Order record {|
    string symbol;
    string buyerID;
    float price;
    int volume;
|};

// This service will accept following JSON payload and convrt to XML
// {
//     "payload": {
//         "symbol": [
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json",
//             "json"]
//             }
// }
isolated service /DMPerfTest on new http:Listener(9090) {
    isolated resource function post .(@http:Payload json payload) returns xml|xmldata:Error? {
        return xmldata:fromJson(payload);
    }
}
