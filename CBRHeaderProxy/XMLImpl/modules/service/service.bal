import ballerina/http;

configurable string httpClientUrl = ?;

// xmlns "http://schemas.xmlsoap.org/soap/envelope/" as soapenv;

// xmlns "http://someuri" as t;

const string PerfTests = "perfTests";

// This service will handle the following xml requsts and access the request header and do nesosory routing
// <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
// <soapenv:Header><routing xmlns="http://someuri">xadmin;server1;community#1.0##</routing></soapenv:Header>
// <soapenv:Body><m:buyStocks xmlns:m="http://services.samples/xsd">
// <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
// </m:buyStocks></soapenv:Body></soapenv:Envelope>
service /CBRHeaderProxy on new http:Listener(9090) {
    final http:Client httpClient;
    function init() returns error? {
        self.httpClient = check new (httpClientUrl);
    }
    resource function post .(@http:Header string foo) returns http:Response|http:Error {
        if foo != PerfTests {
            return error("Invalid routing header");
        }
        // if !re `xadmin;server1;community#1.0##`.isFullMatch((payload/<soapenv:Header>/<t:routing>).data()) {
        //     return error("Invalid routing header");
        // }

        return check self.httpClient->/;
    }
}
