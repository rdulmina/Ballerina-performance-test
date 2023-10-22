import ballerina/http;

configurable string httpClinetUrl = ?;

xmlns "http://schemas.xmlsoap.org/soap/envelope/" as soapenv;

xmlns "http://someuri" as t;

// This service will handle the following soap like requsts and access the soap header and do nesosory routing
    // <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
    // <soapenv:Header><routing xmlns="http://someuri">xadmin;server1;community#1.0##</routing></soapenv:Header>
    // <soapenv:Body><m:buyStocks xmlns:m="http://services.samples/xsd">
    // <order><symbol>N</symbol><buyerID>n</buyerID><price>1.0</price><volume>1</volume></order>
    // </m:buyStocks></soapenv:Body></soapenv:Envelope>
service /CBRHeaderProxy on new http:Listener(9090) {
    final http:Client httpClient;
    function init() returns error? {
        self.httpClient = check new (httpClinetUrl);
    }
    resource function post .(xml payload) returns http:Response|http:Error {
        if !re `xadmin;server1;community#1.0##`.isFullMatch((payload/<soapenv:Header>/<t:routing>).data()) {
            return error("Only application/json is supported");
        }

        return check self.httpClient->/;
    }
}
