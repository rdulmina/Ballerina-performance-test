import ballerina/http;
import ballerina/xmldata;

public type Order record {|
    string symbol;
    string buyerID;
    float price;
    int volume;
|};

// This service will extract the order elements from the following soap like reuests and return json response
    // <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    // <soapenv:Header><routing xmlns="http://someuri">xadmin;server1;community#1.0##</routing></soapenv:Header>
    // <soapenv:Body><m:buyStocks xmlns:m="http://services.samples/xsd">
    // <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
    // <order><symbol>SUN</symbol><buyerID>indika</buyerID><price>14.56</price><volume>500</volume></order>
    // </m:buyStocks></soapenv:Body></soapenv:Envelope>
isolated service /DMPerfTest on new http:Listener(9090) {
    isolated resource function post .(xml payload) returns map<Order>|xmldata:Error {
        xml<'xml:Element> orders = payload/**/<'order>;
        return xmldata:fromXml(orders);
    }
}
