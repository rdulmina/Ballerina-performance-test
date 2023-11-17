import ballerina/http;
import ballerina/xmldata;

public type Order record {|
    string symbol;
    string buyerID;
    float price;
    int volume;
|};

// This service will extract the order elements from the following soap like reuests and return json response
// Inbound request xml
// <m:buyStocks xmlns:m="http://services.samples/xsd">
// <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
// <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
// </m:buyStocks>
//
// Outbound response json
// {"buyStocks":{"order":[{"symbol":"N","buyerID":"n","price":1.0,"volume":1},{"symbol":"SUN","buyerID":"indika","price":14.56,"volume":500}]}}

isolated service / on new http:Listener(9090) {
    isolated resource function post xmltojson(xml payload) returns map<map<Order[]>>|xmldata:Error {
        return xmldata:fromXml(payload);
    }
}

