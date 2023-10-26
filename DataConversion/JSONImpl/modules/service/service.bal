import ballerina/http;
import ballerina/xmldata;

// This service will accept following JSON payload and convrt to XML
// Inbound request xml
// {
//     "payload": {
//         "symbol": [
//             "json",
//             "json",
//             "json",
//             "json"]
//             }
// }
//
// Outbound response xml
// <payload>
//     <symbol>json</symbol
//     <symbol>json</symbol>
//     <symbol>json</symbol>
//     <symbol>json</symbol>
//     <symbol>json</symbol>
// </payload>
isolated service /DMPerfTest on new http:Listener(9090) {
    isolated resource function post .(@http:Payload json payload) returns xml|xmldata:Error? {
        return xmldata:fromJson(payload);
    }
}
